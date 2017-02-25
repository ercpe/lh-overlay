# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

inherit eutils

MY_P="${PN}${PV/./}"

DESCRIPTION="A Web Content Scanner to look for existing/hidden content"
HOMEPAGE="http://dirb.sourceforge.net/"
SRC_URI="mirror://sourceforge/project/${P}/${P}/${PV}/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

S="${WORKDIR}/${MY_P}"

src_prepare() {
	chmod u+x "${S}"/configure || die
}

src_install() {
	default
	## FIXME: collision with icu - but i don't know how to rename this thing
	rm "${D}"/usr/bin/gendict || die
	insinto /usr/share/${PN}/wordlists
	doins -r wordlists/*
}
