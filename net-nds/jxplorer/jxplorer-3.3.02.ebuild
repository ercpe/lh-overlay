# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
JAVA_PKG_IUSE="doc source"

inherit eutils java-pkg-2 java-ant-2 prefix

DESCRIPTION="A fully functional ldap browser written in java."
HOMEPAGE="http://jxplorer.org/"
SRC_URI="mirror://sourceforge/${PN}/${PN}-${PV}-project.zip"
LICENSE="CAOSL"

IUSE="test"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND=">=virtual/jre-1.5
	>=dev-java/javahelp-2.0.02_p46"
DEPEND=">=virtual/jdk-1.5
	test? ( =dev-java/junit-3.8* )
	${RDEPEND}"

S="${WORKDIR}/${PN}"

JAVA_ANT_REWRITE_CLASSPATH="yes"
EANT_GENTOO_CLASSPATH="javahelp"

src_prepare() {
	rm -v jars/*.jar || die
	sed -i -e 's/<fileset dir="${jasper}.*//g' "${S}/build.xml" || die

	if use !test ; then
		find . -iname '*Test*.java' -delete || die
	fi
}

src_test(){
	ANT_TASKS="ant-junit" eant test
}

src_install() {
	java-pkg_dojar jars/${PN}.jar

	dodir /usr/share/${PN}
	for i in "icons images htmldocs language templates plugins security.default csvconfig.txt.default"
	do
		cp -r ${i} "${ED}/usr/share/${PN}" || die
	done

	dodoc README.3.3.TXT || die

	# By default the config dir is ${HOME}/jxplorer
	java-pkg_dolauncher ${PN} \
		--main com.ca.directory.jxplorer.JXplorer \
		--pwd '"${HOME}/.jxplorer"' \
		-pre "${FILESDIR}/${PN}-3-pre"

	eprefixify "${ED}/usr/bin/${PN}"

	use source && java-pkg_dosrc src/com
	use doc && java-pkg_dojavadoc docs

	make_desktop_entry ${PN} JXplorer /usr/share/jxplorer/images/logo_32_trans.gif System
}
