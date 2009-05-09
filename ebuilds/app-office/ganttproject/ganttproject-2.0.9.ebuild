# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

WANT_ANT_TASKS="ant-commons-logging"
JAVA_ANT_IGNORE_SYSTEM_CLASSES="true"
JAVA_ANT_REWRITE_CLASSPATH="true"
EANT_GENTOO_CLASSPATH="commons-httpclient:3,apple-java-extensions-bin,commons-logging,commons-transaction,helpgui,poi,jakarta-slide-webdavclient,jdom:1.0,jgoodies-looks:1.2,xml-im-exporter"
EANT_BUILD_TARGET="build"

NEEDED_JARS="AppleJavaExtensions.jar commons-httpclient.jar eclipsito.jar helpgui-1.1.jar jakarta-slide-webdavlib-2.1.jar jdnc-modifBen.jar"

inherit java-pkg-2 java-ant-2 java-utils-2

MY_P="${P}-src"

DESCRIPTION="A tool for creating a project schedule by means of Gantt chart and resource load chart."
HOMEPAGE="http://ganttproject.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.zip"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-java/commons-httpclient:3
	dev-java/apple-java-extensions-bin:0
	dev-java/commons-logging:0
	dev-java/commons-transaction:0
	dev-java/helpgui:0
	dev-java/poi:0
	dev-java/jakarta-slide-webdavclient:0
	dev-java/jdom:1.0
	dev-java/jgoodies-looks:1.2
	dev-java/xml-im-exporter:0
	>=virtual/jre-1.6"
DEPEND="${RDEPEND}
	app-arch/unzip
	>=virtual/jdk-1.6"

S="${WORKDIR}"/${MY_P}/${PN}-builder

src_prepare() {
	java-pkg-2_src_prepare

	sed -e "s:GP_HOME=.:GP_HOME=/usr/share/${PN}/lib:g" \
		-e "s:cd \${COMMAND_PATH}:cd \${GP_HOME}:g" \
		-i ganttproject.command || die

	cd ../${PN}/lib/core

	for jar in *.jar ;do
		has ${jar} "${NEEDED_JARS}" || \
		{  rm -v ${jar} || die; }
	done
}

src_install() {
	newbin dist-bin/${PN}.command ${PN} || die "no bins installed"
	insinto /usr/share/${PN}/lib
	doins -r dist-bin/{HouseBuildingSample.gan,*.jar,plugins} || die "plugins are missing"
}
