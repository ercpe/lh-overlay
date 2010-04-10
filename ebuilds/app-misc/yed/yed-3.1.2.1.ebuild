# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils java-pkg-2

MY_PV=${PV}
MY_PV=${MY_PV/./_}
MY_PV=${MY_PV/./_}
MY_PV=${MY_PV/./_}

DESCRIPTION="yEd is a very powerful graph editor that is written entirely in the Java programming language."
SRC_URI="http://www.yworks.com/products/yed/demo/yEd${MY_PV}.sh"
HOMEPAGE="http://www.yworks.com/en/products_yed_about.htm"
LICENSE="yEd Software License Agreement"
SLOT="0"
KEYWORDS="~x86 ~amd64"
DEPEND=">=virtual/jre-1.4"
IUSE=""
RESTRICT="fetch"

S=${WORKDIR}
INSTDIR="/opt/${P}"

pkg_nofetch() {
	einfo
	einfo " Due to license restrictions, we cannot fetch the"
	einfo " distributables automatically."
	einfo
	einfo " 1. Visit http://www.yworks.com/en/products_yed_about.htm#download"
	einfo " 2. Download ${A}"
	einfo " 3. Move the file to ${DISTDIR}"
	einfo
}

src_unpack() {
	tail -n +390 ${DISTDIR}/${A} > ${T}/sfx_archive.tar.gz || die
	mkdir ${T}/content || die
	tar -xf ${T}/sfx_archive.tar.gz -C ${T}/content || die
	unzip ${T}/content/content.zip -d ${WORKDIR} 1>/dev/null || die
}

src_compile() {
	:;
}

src_install() {
	# install DOC files
	dodoc license.html

	# install JAR file
	java-pkg_dojar ${PN}.jar

	# install new icon
	newicon .install4j\\${PN}.png ${PN}.png

	# create desktop entry
	make_desktop_entry ${PN} "yEd" ${PN}.png "Graphics"

	# create wrapper script
	java-pkg_dolauncher ${PN} --main B.A.A.B
}
