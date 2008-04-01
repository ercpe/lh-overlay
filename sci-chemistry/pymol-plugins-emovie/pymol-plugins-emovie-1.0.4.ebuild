# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit python

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~amd64"
DESCRIPTION="eMovie is a plug-in tool for the molecular visualization program PyMOL"
SRC_URI="http://www.weizmann.ac.il/ISPC/eMovie_package.zip"
HOMEPAGE="http://www.weizmann.ac.il/ISPC/eMovie.html"
IUSE=""
RESTRICT="mirror"
RDEPEND=">sci-chemistry/pymol-0.99"
DEPEND=""

src_install(){
	insinto /usr/$(get_libdir)/python${PYVER}/site-packages/pmg_tk/startup/
	doins eMovie.py
}

pkg_postrm() {
	python_mod_cleanup "${ROOT}"/usr/$(get_libdir)/python${PYVER}/site-packages/pmg_tk/startup/
}