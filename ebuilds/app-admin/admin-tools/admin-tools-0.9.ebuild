# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils

DESCRIPTION="A set of useful tools to make your (gentoo) admin life easier"
HOMEPAGE="http://www.j-schmitz.net/"
SRC_URI="http://gentoo.j-schmitz.net/portage-overlay/${CATEGORY}/${PN}/${PF}.tar.bz2"

SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
LICENSE="as-is"
IUSE=""

RDEPEND="
	app-portage/eix
	app-portage/gentoolkit
	app-portage/portage-utils"
DEPEND=""

RESTRICT="mirror"

S="${WORKDIR}"/${PN}

pkg_setup() {
	ewarn "This package contains potentially dangerous scripts. Use it with care!"
}

src_install() {
	dosbin autounmask regen-meta-flat rebuild-all adduse.py resume-list || die
	dodoc ChangeLog || die
}
