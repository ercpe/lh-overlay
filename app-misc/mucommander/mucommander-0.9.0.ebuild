# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

JAVA_PKG_IUSE=""

inherit eutils java-pkg-2 versionator

UPSTREAM_PN="muCommander"
UPSTREAM_PV=$(replace_all_version_separators '_')

DESCRIPTION="Lightweight file manager featuring a Norton Commander style interface"
HOMEPAGE="http://www.mucommander.com"
SRC_URI="http://www.mucommander.com/download/${PN}-${UPSTREAM_PV}-src.tar.gz
	http://www.mucommander.com/download/${PN}-${UPSTREAM_PV}.jar
	http://ivy.${PN}.com/${PN}/${PN}-commons-collections/1.0.0-b15/com.${PN}.commons.collections-sources.jar
	http://ivy.${PN}.com/${PN}/${PN}-commons-conf/1.0.0-b28/com.${PN}.commons.conf-sources.jar
	http://ivy.${PN}.com/${PN}/${PN}-commons-file/1.0.0-b66/com.${PN}.commons.file-sources.jar
	http://ivy.${PN}.com/${PN}/${PN}-commons-io/1.0.0-b14/com.${PN}.commons.io-sources.jar
	http://ivy.${PN}.com/${PN}/${PN}-commons-runtime/1.0.0-b20/com.${PN}.commons.runtime-sources.jar
	http://ivy.${PN}.com/${PN}/${PN}-commons-util/1.0.0-b19/com.${PN}.commons.util-sources.jar
"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

CDEPEND="
	dev-java/ant-core
	dev-java/commons-collections
	dev-java/commons-compress
	dev-java/commons-net
	dev-java/icu4j
	dev-java/jcifs
	dev-java/jmdns
	dev-java/jna
	dev-java/j2ssh
	dev-java/logback-bin
	dev-java/slf4j[simple]
	dev-java/yanfs
	"
RDEPEND="${CDEPEND}
	>=virtual/jre-1.5"
DEPEND="${CDEPEND}
	app-arch/unzip
	>=virtual/jdk-1.5"

MY_P="${UPSTREAM_PN}-${UPSTREAM_PV}"
S="${WORKDIR}/${MY_P}"
BIN_S="${WORKDIR}/binary"

src_unpack() {
	unpack "${PN}-${UPSTREAM_PV}-src.tar.gz"
	for mod in collections conf file io runtime util; do
		unzip -n "${DISTDIR}/com.${PN}.commons.${mod}-sources.jar" -d "${S}/main/" || die 
	done

	unzip -n "${DISTDIR}/${PN}-${UPSTREAM_PV}.jar" -d "${BIN_S}" || die
}

src_prepare() {
	# remove implementation for other OS 
	rm -r "${S}"/main/com/${PN}/desktop/{windows,osx,openvms} || die
	rm -r "${S}"/main/com/${PN}/ui/macosx || die
	rm ${S}/main/com/${PN}/commons/file/util/{Kernel32,Kernel32API,Shell32,Shell32API}.java || die 

	epatch "${FILESDIR}/${PV}-remove-unsupported-desktops.patch"
	epatch "${FILESDIR}/${PV}-fix-ftp-client.patch"

	# junrar changed the namespace but upstream source doesn't reflect this yet
	sed -i -e "s/de.innosystec.unrar/com.github.junrar/g" \
		$(find ${S}/main/com/${PN}/commons/file/impl/rar -name "*.java") || die

	rm -r "${S}"/main/com/${PN}/commons/file/impl/{s3,hadoop,vsphere} || die
	rm "${S}"/main/com/${PN}/ui/dialog/server/{S3Panel,HDFSPanel}.java || die

	sed -i -e 's/registerProtocol(FileProtocols.S3.*//g' \
		"${S}"/main/com/${PN}/commons/file/FileFactory.java || die
	sed -i -e 's/addTab(FileProtocols.S3.*//g' \
		"${S}"/main/com/${PN}/ui/dialog/server/ServerConnectDialog.java || die
	sed -i -e 's/registerProtocol(FileProtocols.HDFS.*//g' \
		"${S}"/main/com/${PN}/commons/file/FileFactory.java || die
	sed -i -e 's/addTab(FileProtocols.HDFS.*//g' \
		"${S}"/main/com/${PN}/ui/dialog/server/ServerConnectDialog.java || die
	sed -i -e 's/registerProtocol(FileProtocols.VSPHERE.*//g' \
		"${S}"/main/com/${PN}/commons/file/FileFactory.java || die
}

src_compile() {
	local build_dir="${S}"/build
	local dist_dir="${S}"/dist
	mkdir ${build_dir} ${dist_dir} || die

	local deps="$(java-pkg_getjars commons-collections,commons-net,commons-compress,ant-core)"
	deps="${deps}:$(java-pkg_getjars slf4j,icu4j-49,jna,jcifs-1.1,j2ssh,junrar,yanfs,jmdns,logback-bin)"
	local classpath="-classpath ${deps}"

	ejavac ${classpath} -nowarn -d "${build_dir}" $(find main/ -name "*.java")

	# some required resources aren't available in the source jar but in the binary
	cp -r ${BIN_S}/{META-INF,images,themes,dictionary.txt,license.txt,*.properties,*.xml} \
		${build_dir} || die
	cp ${BIN_S}/com/${PN}/commons/file/icon/impl/link.png \
		${build_dir}/com/${PN}/commons/file/icon/impl/ || die
	cp ${BIN_S}/com/${PN}/commons/file/mime.types \
		${build_dir}/com/${PN}/commons/file/ || die

	local manifest="${build_dir}/META-INF/MANIFEST.MF"
	sed -i -e "s/Build-Date:.*/Build-Date: $(date +%Y%m%d)/g" ${manifest} && \
			sed -i -e '/^\s*$/d' ${manifest} || die
	jar cfm "${dist_dir}/${PN}.jar" ${manifest} -C ${build_dir} . || die "jar failed"
}

src_install() {
	java-pkg_dojar "${S}/dist/${PN}.jar"
	java-pkg_dolauncher ${PN} --main "com.mucommander.Launcher"
		
	newicon "${S}"/build/images/mucommander/icon48_24.png ${PN}.png
	make_desktop_entry ${UPSTREAM_PN} "${UPSTREAM_PN}" ${PN}
}
