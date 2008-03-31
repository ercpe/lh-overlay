# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit python toolchain-funcs

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~amd64"
DESCRIPTION="COLORAMA is a PyMOL plugin which allows to color objects using adjustable scale bars"
SRC_URI="http://www.pymolwiki.org/images/f/f8/Colorama-${PV}.tar.bz2"
HOMEPAGE="http://www.pymolwiki.org/index.php/Colorama"
IUSE=""
RESTRICT="mirror"
DEPEND=""
RDEPEND=""

src_install(){
	python_version
	insinto /usr/$(get_libdir)/python${PYVER}/site-packages/pmg_tk/startup/
	doins colorama.py
}

pkg_postrm() {
	python_mod_cleanup "${ROOT}"/usr/$(get_libdir)/python${PYVER}/site-packages/pmg_tk/startup/
}