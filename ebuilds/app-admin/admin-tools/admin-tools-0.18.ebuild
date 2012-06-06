# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit eutils

DESCRIPTION="A set of useful tools to make your (gentoo) admin life easier"
HOMEPAGE="http://www.j-schmitz.net/projects/admin-tools/"
SRC_URI="http://gentoo.j-schmitz.net/portage-overlay/${PF}.tar.xz"

SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
LICENSE="as-is"
IUSE=""

RDEPEND="
	app-portage/eix
	app-portage/gentoolkit
	app-admin/lib_users
	app-portage/portage-utils"
DEPEND=""

RESTRICT="mirror"

pkg_setup() {
	ewarn "This package contains potentially dangerous scripts. Use it with care!"
}

src_install() {
	dosbin autounmask regen-meta-flat rebuild-all adduse.py resume-list ps_mem.py update-portage
}
