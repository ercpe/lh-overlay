# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit python

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~amd64"
DESCRIPTION="A plugin for PyMOL that helps to setup docking run s and view docking results"
SRC_URI="http://www.mpibpc.mpg.de/groups/grubmueller/start/people/dseelig/autodock.py"
HOMEPAGE="http://www.mpibpc.mpg.de/groups/grubmueller/start/people/dseelig/adplugin.html"
IUSE=""
RESTRICT="mirror"
RDEPEND="sci-chemistry/autodock
		 >sci-chemistry/pymol-0.99"
DEPEND=""

src_unpack(){
	cp "${DISTDIR}"/autodock.py "${WORKDIR}"
}

src_install(){
	python_version
	insinto /usr/$(get_libdir)/python${PYVER}/site-packages/pmg_tk/startup/
	doins "${WORKDIR}"/autodock.py
}

pkg_postrm() {
	python_mod_cleanup "${ROOT}"/usr/$(get_libdir)/python${PYVER}/site-packages/pmg_tk/startup/
}