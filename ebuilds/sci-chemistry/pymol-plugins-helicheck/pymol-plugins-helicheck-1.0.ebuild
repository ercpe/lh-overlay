# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit python

SLOT="0"
LICENSE="BSD"
KEYWORDS="~x86 ~amd64"
DESCRIPTION="helicity_check shows the evolution of O -- N distances over an amino acid sequence"
SRC_URI="http://www.pymolwiki.org/images/6/6e/Helicity_check-${PV}.tar.bz2"
HOMEPAGE="http://www.pymolwiki.org/index.php/Helicity_check"
IUSE=""
RESTRICT="mirror"
RDEPEND=">sci-chemistry/pymol-0.99
		 sci-visualization/gnuplot"
DEPEND=""

src_install(){
	python_version
	insinto /usr/$(get_libdir)/python${PYVER}/site-packages/pmg_tk/startup/
	doins helicity_check.py
}

pkg_postinst(){
	python_mod_optimize "${ROOT}"/usr/$(get_libdir)/python${PYVER}/site-packages/pmg_tk/startup/
}

pkg_postrm() {
	python_mod_cleanup "${ROOT}"/usr/$(get_libdir)/python${PYVER}/site-packages/pmg_tk/startup/
}