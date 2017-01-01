# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

# XXX: tests

EAPI=5

PYTHON_COMPAT=( python2_7 )

inherit eutils gnome2-utils git-2 distutils-r1

DESCRIPTION="Ninja-IDE Is Not Just Another IDE"
HOMEPAGE="http://www.ninja-ide.org"
SRC_URI=""
EGIT_REPO_URI="git://github.com/ninja-ide/ninja-ide.git"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""
IUSE=""

RDEPEND="
	dev-python/PyQt4[webkit,${PYTHON_USEDEP}]
	dev-python/simplejson[${PYTHON_USEDEP}]
	dev-python/pyinotify[${PYTHON_USEDEP}]
	virtual/python-argparse[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}"

python_install_all() {
	distutils-r1_python_install_all
	newicon -s 256 icon.png ${PN}.png
	make_desktop_entry ${PN} "NINJA-IDE"
}

pkg_preinst() {
	gnome2_icon_savelist
}

pkg_postinst() {
	gnome2_icon_cache_update
}

pkg_postrm() {
	gnome2_icon_cache_update
}
