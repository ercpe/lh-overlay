# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils flag-o-matic autotools

DESCRIPTION="all atom molecular simulation toolkit"
HOMEPAGE="http://www-almost.ch.cam.ac.uk/site"
#SRC_URI="http://www-almost.ch.cam.ac.uk/site/downloads/${P}.tar.gz"
## Upstream change tarballs w/o revision bump
SRC_URI="http://gentoo.j-schmitz.net/portage/distfiles/All/${P}.tar.gz"
LICENSE="GPL-2"

SLOT="0"
#KEYWORDS="~amd64 ~x86"
KEYWORDS="-*"

IUSE="mpi"
## Upstream only uses sys-cluster/mpich2, so we should first get this to work.
RDEPEND="mpi? ( sys-cluster/mpich2 )"

## dev-libs/boost-1.3.6 once it is in the tree soft masked
## until then we use the shipped one
DEPEND="${RDEPEND}"

src_unpack(){
	unpack ${A}

	cd "${S}"

	epatch "${FILESDIR}"/gcc-4.3.patch
	epatch "${FILESDIR}"/configure-boost.patch
	eautoreconf || die "Reconfiguration failed"
}

src_compile(){

	## MPI will be included when any version of mpich2 builds AND works
	use mpi && append-flags -DALM_MPI_FF -DMPICH_IGNORE_CXX_SEEK

	use mpi && myconf="CXX=/usr/bin/mpicxx"

	econf $(use_enable mpi) \
	      ${myconf} || \
	die "configure failed"

	emake CFLAGS="${CFLAGS}" CXXFLAGS="${CXXFLAGS}" LDFLAGS="${LDFLAGS}" || \
	die "make failed"

}

src_test() {
	emake check || \
	die "test failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "Install failed"

	dodoc README NEWS TODO ChangeLog AUTHORS
}
