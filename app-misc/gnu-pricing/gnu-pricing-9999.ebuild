# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit git-r3

DESCRIPTION="Turn GNU command line tools into SaaS (Stupid Hackathon Project)"
HOMEPAGE="https://github.com/diafygi/gnu-pricing"
SRC_URI=""
EGIT_REPO_URI="https://github.com/diafygi/gnu-pricing.git"

SLOT="0"
LICENSE="GPL-3"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE=""

src_install() {
	exeinto /usr/libexec/${PN}/bin
	doexe bin/*
	exeinto /usr/libexec/${PN}/
	doexe *sh

	cat >> "${T}"/99${PN} <<- EOF
	PATH="${EPREFIX}/usr/libexec/${PN}/bin"
	EOF
	doenvd "${T}"/99${PN}
}
