# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit python eutils

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~amd64"
DESCRIPTION="Several plugins for PyMOL to make life with PyMOL easier."
SRC_URI="http://www.rubor.de/anlagen/rTools_${PV}.zip"
HOMEPAGE="http://www.rubor.de/bioinf/pymol_extensions.html"
IUSE=""
RESTRICT="mirror"
RDEPEND=">sci-chemistry/pymol-0.99"
DEPEND=""

S="rTools"

src_unpack(){
	unpack rTools_0.7.2.zip
	edos2unix "${S}"/color_protscale.py
	if [[ "${PYVER}" == "2.5" ]] ; then
		epatch "${FILESDIR}"/rtools-${PV}-python2.5.patch
	else
		epatch "${FILESDIR}"/rtools-${PV}.patch
	fi
}

src_install(){
	python_version
	insinto /usr/$(get_libdir)/python${PYVER}/site-packages/pmg_tk/startup/
	doins -r "${S}"/{protscale/,scripts/,*.py,scripts.lst}
	dodoc "${S}"/{LICENSE.TXT,rtools_doku.rtf}
}

pkg_postrm() {
	python_mod_cleanup "${ROOT}"/usr/$(get_libdir)/python${PYVER}/site-packages/pmg_tk/startup/
}