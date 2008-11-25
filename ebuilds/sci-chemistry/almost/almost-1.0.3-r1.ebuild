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
## Upstream only uses sys-cluster/mpich2, so we should first get this to work.
RDEPEND="mpi? ( sys-cluster/mpich2 )"
DEPEND="${RDEPEND}"

src_unpack(){
	unpack ${A}

	cd "${S}"

	epatch "${FILESDIR}"/gcc-4.3.patch
}

src_compile(){

	## MPI will be included when any version of mpich2 builds AND works
	#use mpi && append-flags -DALM_MPI_FF -DMPICH_IGNORE_CXX_SEEK

	#use mpi && myconf="CXX=/usr/bin/mpicxx"

	econf $(use_enable mpi) \
	      ${myconf} || \
	die

	emake CFLAGS="${CFLAGS}" CXXFLAGS="${CXXFLAGS}" || \
	die

}

src_test() {
	emake check
}

src_install() {
	emake DESTDIR="${D}" install || die "Install failed"

	dodoc README NEWS ChangeLog AUTHORS
}
