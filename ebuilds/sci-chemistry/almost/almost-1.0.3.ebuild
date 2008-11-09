# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils

DESCRIPTION="all atom molecular simulation toolkit"
HOMEPAGE="http://www-almost.ch.cam.ac.uk/site"
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

	eautoreconf
}

src_compile(){

	econf $(use_enable mpi) || \
	die

	use mpi && append-flags -DALM_MPI_FF -DMPICH_IGNORE_CXX_SEEK

	emake CFLAGS="${CFLAGS}" CXXFLAGS="${CXXFLAGS}" || \
	die

}

src_install() {
	emake DESTDIR="${D}" install || die "Install failed"
	#dodoc README CHANGES || die
}
