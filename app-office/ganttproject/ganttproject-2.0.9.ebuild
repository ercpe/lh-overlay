# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

WANT_ANT_TASKS="ant-commons-logging"
#JAVA_ANT_IGNORE_SYSTEM_CLASSES="true"
JAVA_PKG_IUSE="source"

inherit eutils java-pkg-2 java-ant-2

MY_P="${P}-src"

DESCRIPTION="A tool for creating a project schedule by means of Gantt chart and resource load chart."
HOMEPAGE="http://ganttproject.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.zip"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

COMMON_DEP="
	dev-java/apple-java-extensions-bin:0
	dev-java/commons-httpclient:3
	dev-java/commons-transaction:0
	dev-java/jakarta-slide-webdavclient:0
	dev-java/jdom:1.0
	dev-java/jgoodies-looks:1.2
	dev-java/helpgui:0
	dev-java/poi:3.2
	dev-java/xml-im-exporter:0"

RDEPEND=">=virtual/jre-1.6
	${COMMON_DEP}"

DEPEND="${COMMON_DEP}
	app-arch/unzip
	>=virtual/jdk-1.6"

S="${WORKDIR}"/${MY_P}/${PN}-builder

#NEEDED_JARS="AppleJavaExtensions.jar commons-httpclient.jar commons-httpclient-contrib.jar eclipsito.jar helpgui-1.1.jar jakarta-slide-webdavlib-2.1.jar jdnc-modifBen.jar"
#NEEDED_JARS="AppleJavaExtensions.jar commons-httpclient-contrib.jar commons-httpclient.jar commons-logging.jar commons-transaction-1.0.jar eclipsito.jar helpgui-1.1.jar \
#					jakarta-poi-2.5.jar jakarta-slide-webdavlib-2.1.jar jdnc-modifBen.jar jdom-1.0.jar jgoodies-looks-1.2.2.jar xml-im-exporter1.1.jar"
#NEEDED_JARS="commons-httpclient.jar commons-httpclient-contrib.jar eclipsito.jar jdnc-modifBen.jar"
#NEEDED_JARS="commons-httpclient-contrib.jar eclipsito.jar jdnc-modifBen.jar jakarta-poi-2.5.jar commons-transaction-1.0.jar"
NEEDED_JARS="commons-httpclient-contrib.jar eclipsito.jar jdnc-modifBen.jar jakarta-poi-2.5.jar"

JAVA_ANT_ENCODING=UTF-8

java_prepare() {
#	pushd ${WORKDIR}
#	epatch "${FILESDIR}"/${PV}-include.patch
#	popd
	sed -e "s:GP_HOME=.:GP_HOME=/usr/share/${PN}/lib:g" \
		-e "s:cd \${COMMAND_PATH}:cd \${GP_HOME}:g" \
		-i ganttproject.command || die

#	find ${WORKDIR} \
#		-type f \
#		-exec \
#			sed \
#				-e "s:commons-transaction-1.0.jar:commons-transaction.jar:g" \
#				-e "s:helpgui-1.1.jar:helpgui-1.1.jar:g" \
#				-e "s:jakarta-slide-webdavlib-2.1.jar:jakarta-slide-webdavlib.jar:g" \
#				-e "s:jdom-1.0.jar:jdom.jar:g" \
#				-e "s:jgoodies-looks-1.2.2.jar:looks.jar:g" \
#				-e "s:xml-im-exporter1.1.jar:xml-im-exporter.jar:g" \
#				-i '{}' \;

	cd ../${PN}/lib/core

	for jar in *.jar ;do
		has ${jar} "${NEEDED_JARS}" || \
		{  rm -v ${jar} || die; }
	done
	cd "${S}"/..
	java-ant_rewrite-classpath "${S}"/../ganttproject/build.xml
}

JAVA_ANT_REWRITE_CLASSPATH="true"
#EANT_GENTOO_CLASSPATH="apple-java-extensions-bin,commons-transaction,helpgui,poi-3.2,jakarta-slide-webdavclient,commons-logging,jdom-1.0,jgoodies-looks-1.2,xml-im-exporter"
#EANT_GENTOO_CLASSPATH="apple-java-extensions-bin,commons-httpclient-3,commons-transaction,helpgui,poi-3.2,jakarta-slide-webdavclient,commons-logging,jdom-1.0,jgoodies-looks-1.2,xml-im-exporter"
EANT_GENTOO_CLASSPATH="apple-java-extensions-bin,commons-httpclient-3,commons-transaction,helpgui,jakarta-slide-webdavclient,commons-logging,jdom-1.0,jgoodies-looks-1.2,xml-im-exporter"

EANT_BUILD_TARGET="build"

use source && EANT_BUILD_TARGET+=" dist-src"

src_install() {
	basedir="/usr/share/${PN}/lib/"
	insinto "${basedir}"
	doins -r dist-bin/plugins || die
	java-pkg_dojar dist-bin/eclipsito.jar
	java-pkg_regjar $(find "${D}" -name "*.jar")

	java-pkg_dolauncher ${PN} \
		--jar "eclipsito.jar" \
		--main "org.bardsoftware.eclipsito.Boot" \
		--java_args "-Xmx256m" \
		--pkg_args "ganttproject-eclipsito-config.xml -log \${HOME}/.${PN}.log" \
		--pwd ${basedir}
# -Dorg.ganttproject.resourcebase=/usr/share/${PN}/lib/plugins/net.sourceforge.ganttproject_2.0.0/data/resources/" \

	dodoc dist-bin/HouseBuildingSample.gan || die

	newbin dist-bin/${PN}.command ${PN}-2

	use source && java-pkg_dosrc dist-src
}

src_2_install() {
	java-pkg_dojar dist-bin/*.jar || die "plugins are missing"

	basedir="/usr/share/${PN}/lib/"

	plugin="plugins/net.sourceforge.ganttproject_2.0.0"

	insinto ${basedir}/${plugin}
	doins -r dist-bin/${plugin}/{data,plugin.xml} || die "plugins are missing"

#	java-pkg_jarinto ${basedir}/${plugin}/lib/core
#	for jar in ${NEEDED_JARS/eclipsito.jar/};do
#		java-pkg_dojar dist-bin/${plugin}/lib/core/${jar}
#	done

	java-pkg_jarinto ${basedir}/${plugin}/lib/core
	java-pkg_dojar dist-bin/${plugin}/lib/core/*.jar

	java-pkg_jarinto ${basedir}/${plugin}
	java-pkg_dojar dist-bin/${plugin}/ganttproject.jar

	plugin="plugins/org.ganttproject.chart.pert_2.0.0"

	insinto ${basedir}/${plugin}
	doins -r dist-bin/${plugin}/{resources,plugin.xml} || die "plugins are missing"

	java-pkg_jarinto ${basedir}/${plugin}
	java-pkg_dojar dist-bin/${plugin}/pert.jar

	plugin="plugins/org.ganttproject.impex.htmlpdf_2.0.0"

	insinto ${basedir}/${plugin}
	doins -r dist-bin/${plugin}/{resource,plugin.xml} || die

	java-pkg_jarinto ${basedir}/${plugin}
	java-pkg_dojar dist-bin/${plugin}/ganttproject-htmlpdf.jar

	java-pkg_jarinto ${basedir}/${plugin}/lib
	java-pkg_dojar dist-bin/${plugin}/lib/*.jar

	plugin="plugins/org.ganttproject.impex.msproject_2.0.0"

	insinto ${basedir}/${plugin}
	doins dist-bin/${plugin}/plugin.xml || die

	java-pkg_jarinto ${basedir}/${plugin}
	java-pkg_dojar dist-bin/${plugin}/ganttproject-msproject.jar

	java-pkg_jarinto ${basedir}/${plugin}/lib/mpxj
	java-pkg_dojar dist-bin/${plugin}/lib/mpxj/*.jar

	java-pkg_dolauncher ${PN} \
		--jar "eclipsito.jar" \
		--main "org.bardsoftware.eclipsito.Boot" \
		--java_args "-Xmx256m" \
		--pkg_args "ganttproject-eclipsito-config.xml -log \${HOME}/.${PN}.log" \
		--pwd ${basedir}
#		-pre "${FILESDIR}"/launcher.stub

	dodoc dist-bin/HouseBuildingSample.gan || die

	newbin dist-bin/${PN}.command ${PN}-2

	use source && java-pkg_dosrc dist-src
}
