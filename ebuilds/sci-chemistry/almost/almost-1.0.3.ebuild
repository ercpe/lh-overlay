# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils

DESCRIPTION="all atom molecular simulation toolkit"
HOMEPAGE="http://www-almost.ch.cam.ac.uk"
SRC_URI="http://www-almost.ch.cam.ac.uk/site/downloads/${P}.tar.gz"

LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE="mpi"
RDEPEND="mpi? ( virtual/mpi )"
DEPEND="${RDEPEND}"

src_unpack(){
	unpack ${A}

	cd "${S}"

	epatch "${FILESDIR}"/gcc-4.3.patch
}

src_compile(){

	econf

	emake -j1 CFLAGS="${CFLAGS}" CXXFLAGS="${CXXFLAGS}"

}
