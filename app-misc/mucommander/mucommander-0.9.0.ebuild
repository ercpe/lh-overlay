# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

JAVA_PKG_IUSE="doc source"

inherit eutils java-pkg-2 java-ant-2 versionator

UPSTREAM_PN="muCommander"
UPSTREAM_PV=$(replace_all_version_separators '_')

DESCRIPTION="Lightweight file manager featuring a Norton Commander style interface"
HOMEPAGE="http://www.mucommander.com"
SRC_URI="http://gentoo.j-schmitz.net/overlays/last-hope/${CATEGORY}/${PN}/${P}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="s3"

CDEPEND="
	dev-java/ant-core
	dev-java/commons-collections
	dev-java/commons-compress
	dev-java/commons-net
	dev-java/icu4j
	dev-java/jcifs
	dev-java/jmdns:3.1
	dev-java/jna
	dev-java/j2ssh
	dev-java/junrar
	dev-java/logback-bin
	dev-java/slf4j-simple
	dev-java/yanfs
	s3? ( dev-java/jets3t )
"

RDEPEND="${CDEPEND}
	>=virtual/jre-1.5"
DEPEND="${CDEPEND}
	app-arch/unzip
	>=virtual/jdk-1.5"

MY_P="${UPSTREAM_PN}-${UPSTREAM_PV}"

ANT_TASKS="dev-java/ant-ivy"
JAVA_ANT_REWRITE_CLASSPATH="yes"
EANT_BUILD_TARGET="jar"
EANT_GENTOO_CLASSPATH="commons-collections
	commons-net
	commons-compress
	ant-core
	slf4j-api
	slf4j-simple
	icu4j-49
	jna
	jcifs-1.1
	j2ssh
	junrar
	yanfs
	jmdns-3.1
	logback-bin"

src_prepare() {
	epatch "${FILESDIR}/${PV}-build.xml.patch"
	epatch "${FILESDIR}/${PV}-remove-unsupported-desktops.patch"

	epatch "${FILESDIR}/${PV}-fix-ftp-client.patch"
	epatch "${FILESDIR}/${PV}-fix-s3impl.patch"
	epatch "${FILESDIR}/${PV}-rename-junrar-namespace.patch"

	# remove implementation for other OS 
	rm -r "${S}"/src/main/com/${PN}/desktop/{windows,osx,openvms} || die
	rm -r "${S}"/src/main/com/${PN}/ui/macosx || die
	rm "${S}"/src/main/com/${PN}/commons/file/util/{Kernel32,Kernel32API,Shell32,Shell32API}.java || die

	if ! use s3; then
		rm -r "${S}"/src/main/com/${PN}/commons/file/impl/s3 || die
		sed -i -e 's/registerProtocol(FileProtocols.S3.*//g' \
			"${S}"/src/main/com/${PN}/commons/file/FileFactory.java || die
		sed -i -e 's/addTab(FileProtocols.S3.*//g' \
			"${S}"/src/main/com/${PN}/ui/dialog/server/ServerConnectDialog.java || die
	fi

	rm -r "${S}"/src/main/com/${PN}/commons/file/impl/hadoop || die
	rm "${S}"/src/main/com/${PN}/ui/dialog/server/HDFSPanel.java || die
	sed -i -e 's/registerProtocol(FileProtocols.HDFS.*//g' \
		"${S}"/src/main/com/${PN}/commons/file/FileFactory.java || die
	sed -i -e 's/addTab(FileProtocols.HDFS.*//g' \
		"${S}"/src/main/com/${PN}/ui/dialog/server/ServerConnectDialog.java || die

	rm -r "${S}"/src/main/com/${PN}/commons/file/impl/vsphere || die
	sed -i -e 's/registerProtocol(FileProtocols.VSPHERE.*//g' \
		"${S}"/src/main/com/${PN}/commons/file/FileFactory.java || die
}

src_compile() {
	use s3 && EANT_GENTOO_CLASSPATH="${EANT_GENTOO_CLASSPATH} jets3t"
	java-pkg-2_src_compile
}

src_install() {
	java-pkg_newjar "${S}/tmp/${PN}-normal.jar" "${PN}.jar"
	java-pkg_dolauncher ${PN} --main "com.mucommander.Launcher"

	use source && java-pkg_dosrc "${S}"/src/main/*
	use doc && java-pkg_dojavadoc "${S}"/docs

	newicon "${S}"/res/runtime/images/mucommander/icon48_24.png ${PN}.png
	make_desktop_entry ${PN} "${UPSTREAM_PN}" ${PN}
}
