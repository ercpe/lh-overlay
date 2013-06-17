# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

PYTHON_COMPAT=( python2_7 )

inherit distutils-r1 gnome2-utils

UPSTREAM_PN="${PN^}"

DESCRIPTION="Linux Twitter client designed for multiple columns of multiple accounts"
HOMEPAGE="https://launchpad.net/polly"
SRC_URI="https://launchpad.net/${PN}/1.0/pre-alpha-2/+download/${UPSTREAM_PN}-${PV}%20%28pre-alpha%203.9%29.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="dev-python/dbus-python
	dev-python/pyxdg
	dev-python/notify-python
	dev-python/oauth2
	dev-python/gconf-python
	dev-python/socksipy
	dev-python/httplib2
	dev-python/pycurl
	dev-python/numpy
	dev-python/keyring
	dev-python/gtkspell-python
"

S="${WORKDIR}/${UPSTREAM_PN}-${PV} (pre-alpha 3.9)"

DOCS=(README THANKS CREDITS CHANGELOG)

python_install_all() {
	insinto /etc/gconf/schemas
	doins "${S}/share/gconf/schemas/polly.schemas"

	default
}

pkg_preinst() {
	gnome2_gconf_savelist
}

pkg_postinst() {
	gnome2_gconf_install
}

pkg_postrm() {
	gnome2_gconf_uninstall
}