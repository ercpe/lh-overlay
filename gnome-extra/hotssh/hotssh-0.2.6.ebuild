# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

PYTHON_COMPAT=( python2_7 )

inherit python-r1 versionator

DESCRIPTION="Interface to Secure Shell, for GNOME and OpenSSH"
HOMEPAGE="http://projects.gnome.org/hotssh/"
SRC_URI="http://ftp.gnome.org/pub/GNOME/sources/${PN}/$(get_version_component_range 1-2)/${P}.tar.bz2"

SLOT="0"
KEYWORDS="~amd64 ~x86"
LICENSE="GPL-2"
IUSE=""

RDEPEND="
	dev-python/dbus-python[${PYTHON_USEDEP}]
	dev-python/pygobject:2[${PYTHON_USEDEP}]
	dev-python/pygtk[${PYTHON_USEDEP}]
	x11-libs/pango[introspection]"
DEPEND=""

src_prepare() {
	python_export_best
	${PYTHON} ./waf configure --prefix="${EPREFIX}/usr" || die
}

src_configure() {
	${PYTHON} ./waf || die
}

src_install() {
	python_foreach_impl ${PYTHON} ./waf install --destdir="${D}"
	python_replicate_script "${ED}"/usr/bin/${PN}
}
