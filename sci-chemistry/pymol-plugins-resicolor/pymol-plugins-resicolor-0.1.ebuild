# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit python toolchain-funcs

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~amd64"
DESCRIPTION="Resicolor is a small plugin to color proteins according to residue type."
SRC_URI="http://www.pymolwiki.org/images/6/6c/Resicolor-${PV}.tar.bz2"
HOMEPAGE="http://www.pymolwiki.org/index.php/Resicolor_plugin"
IUSE=""
RESTRICT="mirror"
RDEPEND=">sci-chemistry/pymol-0.99"
DEPEND=""

src_install(){
	python_version
	insinto /usr/$(get_libdir)/python${PYVER}/site-packages/pmg_tk/startup/
	doins resicolor.py
}

pkg_postrm() {
	python_mod_cleanup "${ROOT}"/usr/$(get_libdir)/python${PYVER}/site-packages/pmg_tk/startup/
}