# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils

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
	tail -n +390 ${DISTDIR}/${A} > ${T}/sfx_archive.tar.gz
	mkdir ${T}/content
	tar -xf ${T}/sfx_archive.tar.gz -C ${T}/content
	unzip ${T}/content/content.zip -d ${WORKDIR} 1>/dev/null
}

src_install() {
	dodir ${INSTDIR}
	dodir /usr/share/pixmaps

	cp ${S}/license.html ${D}${INSTDIR}
	cp ${S}/${PN}.jar ${D}${INSTDIR}
	cp ${S}/.install4j\\${PN}.png ${D}/usr/share/pixmaps/${PN}.png

	make_desktop_entry ${PN} "yEd" ${PN}.png "Graphics"

	echo "#!/bin/sh" > ${D}${INSTDIR}/${PN}
	echo "" >> ${D}${INSTDIR}/${PN}
	echo "java -jar ${INSTDIR}/${PN}.jar" >> ${D}${INSTDIR}/${PN}

	chmod 644 ${D}${INSTDIR}/*
	chmod +x ${D}${INSTDIR}/${PN}

	dosym ${D}${INSTDIR}/${PN} /usr/bin/${PN}
}
