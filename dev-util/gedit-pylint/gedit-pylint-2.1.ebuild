# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

PYTHON_COMPAT=( python3_3 )

inherit distutils-r1 gnome2-utils fdo-mime

MY_PN="${PN}-2"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Pylint static analysis support in Gedit"
HOMEPAGE="https://launchpad.net/gedit-pylint-2"
SRC_URI="https://launchpad.net/${MY_PN}/trunk/${PV}/+download/${MY_P}.tar.gz"

SLOT="0"
LICENSE="GPL-3"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE=""

RDEPEND="app-editors/gedit[introspection,${PYTHON_USEDEP}]"
DEPEND=""

S="${WORKDIR}"/${MY_P}

pkg_preinst() {
	gnome2_gconf_savelist
	gnome2_icon_savelist
	gnome2_schemas_savelist
	gnome2_scrollkeeper_savelist
}

pkg_postinst() {
	gnome2_gconf_install
	fdo-mime_desktop_database_update
	fdo-mime_mime_database_update
	gnome2_icon_cache_update
	gnome2_schemas_update
	gnome2_scrollkeeper_update
}

pkg_postrm() {
	fdo-mime_desktop_database_update
	fdo-mime_mime_database_update
	gnome2_icon_cache_update
	gnome2_schemas_update
	gnome2_scrollkeeper_update
}
