# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

JAVA_PKG_IUSE="doc source"

inherit subversion java-pkg-2 java-ant-2

MY_P="${PN}-${PV//./_}"

DESCRIPTION="muCommander is a lightweight file manager featuring a Norton Commander style interface"
HOMEPAGE="http://www.mucommander.com"
ESVN_REPO_URI="https://svn.${PN}.com/${PN}/tags/release_${PV//./_}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="=virtual/jdk-1.6*
		dev-java/ant-core
		dev-java/ant-junit
	!app-misc/mucommander-bin"
RDEPEND="${DEPEND}"

src_unpack() {
	subversion_src_unpack
	java-pkg_jar-from --build-only ant-core
}


src_compile() {
	cd lib/include/
	java-pkg_jar-from ant-core
	java-pkg_jar-from ant-junit

	cd "${S}"
	eant nightly
}


src_install() {
	insinto /usr/$(get_libdir)/mucommander/
	doins dist/mucommander.jar

	cat >> "${T}"/mucommander <<- EOF
	#!/bin/bash
	$(which java) -jar /usr/$(get_libdir)/mucommander/mucommander.jar
	EOF

	dobin "${T}"/mucommander
	dodoc readme.txt

	newicon res/images/about.png ${PN}.png
	make_desktop_entry ${PN} "muCommander" ${PN}
}
# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

JAVA_PKG_IUSE="doc source"

inherit subversion java-pkg-2 java-ant-2

MY_P="${PN}-${PV//./_}"

DESCRIPTION="muCommander is a lightweight file manager featuring a Norton Commander style interface"
HOMEPAGE="http://www.mucommander.com"
ESVN_REPO_URI="https://svn.${PN}.com/${PN}/tags/release_${PV//./_}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="=virtual/jdk-1.6*
		dev-java/ant-core
		dev-java/ant-junit
	!app-misc/mucommander-bin"
RDEPEND="${DEPEND}"

src_unpack() {
	subversion_src_unpack
	java-pkg_jar-from --build-only ant-core
}


src_compile() {
	cd lib/include/
	java-pkg_jar-from ant-core
	java-pkg_jar-from ant-junit

	cd "${S}"
	eant nightly
}


src_install() {
	insinto /usr/$(get_libdir)/mucommander/
	doins dist/mucommander.jar

	cat >> "${T}"/mucommander <<- EOF
	#!/bin/bash
	$(which java) -jar /usr/$(get_libdir)/mucommander/mucommander.jar
	EOF

	dobin "${T}"/mucommander
	dodoc readme.txt

	newicon res/images/about.png ${PN}.png
	make_desktop_entry ${PN} "muCommander" ${PN}
}
JAVA_PKG_IUSE="doc source"

inherit subversion java-pkg-2 java-ant-2

MY_P="${PN}-${PV//./_}"

DESCRIPTION="muCommander is a lightweight file manager featuring a Norton Commander style interface"
HOMEPAGE="http://www.mucommander.com"
ESVN_REPO_URI="https://svn.${PN}.com/${PN}/tags/release_${PV//./_}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="=virtual/jdk-1.6*
		dev-java/ant-core
		dev-java/ant-junit
		dev-java/commons-logging
		dev-java/icu4j
		=dev-java/jakarta-oro-2.0*
		=dev-java/jcifs-1.2*
		dev-java/jmdns"

RDEPEND="${DEPEND}"

src_unpack() {
	subversion_src_unpack
	java-pkg_jar-from --build-only ant-core
}


src_compile() {
	cd lib/include/

	## remove libs provided by the dependencies
	rm {commons-logging.jar,icu4j.jar,jakarta-oro.jar,jcifs.jar,jmdns.jar}

	## now link the dependencies
	java-pkg_jar-from ant-core
	java-pkg_jar-from ant-junit
	java-pkg_jar-from commons-logging
	## commons-net in lib/ is a custom version!
	#java-pkg_jar-from commons-net
	java-pkg_jar-from icu4j
	java-pkg_jar-from jmdns
	## strange, on these to lines a version is required?!?
	java-pkg_jar-from jakarta-oro-2.0
	java-pkg_jar-from jcifs-1.1

	cd "${S}"
	eant nightly
}


src_install() {
	java-pkg_dojar dist/mucommander.jar

	## create a launcher
	java-pkg_dolauncher

	dodoc readme.txt

	newicon res/images/about.png ${PN}.png
	make_desktop_entry ${PN} "muCommander" ${PN}
}
