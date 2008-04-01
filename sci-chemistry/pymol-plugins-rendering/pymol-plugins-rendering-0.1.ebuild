# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit python

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~amd64"
DESCRIPTION="This is a PyMOL plugin to aid in publication-quality rendering."
SRC_URI="http://www-personal.umich.edu/~mlerner/PyMOL/rendering.py"
HOMEPAGE="http://www-personal.umich.edu/~mlerner/PyMOL/"
IUSE=""
RESTRICT="mirror"
RDEPEND=">sci-chemistry/pymol-0.99"
DEPEND=""

src_unpack(){
	cp "${DISTDIR}"/rendering.py "${WORKDIR}"
}

src_install(){
	insinto /usr/$(get_libdir)/python${PYVER}/site-packages/pmg_tk/startup/
	doins rendering.py
}

pkg_postrm() {
	python_mod_cleanup "${ROOT}"/usr/$(get_libdir)/python${PYVER}/site-packages/pmg_tk/startup/
}