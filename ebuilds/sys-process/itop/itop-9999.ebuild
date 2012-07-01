# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit git-2

DESCRIPTION="Interrupts 'top-like' utility for Linux"
HOMEPAGE="https://github.com/kargig/itop"
SRC_URI=""
EGIT_REPO_URI="git://github.com/kargig/itop.git"

SLOT="0"
LICENSE="MIT"
KEYWORDS=""
IUSE=""

RDEPEND="dev-lang/perl"
DEPEND=""

src_install() {
	dobin ${PN}
	dodoc README.md
}
