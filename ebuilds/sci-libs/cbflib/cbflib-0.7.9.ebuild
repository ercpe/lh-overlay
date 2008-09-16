# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils flag-o-matic

MY_P="CBFlib_${PV}"

DESCRIPTION="Library providing a simple mechanism for accessing CBF files and imgCIF files."
HOMEPAGE="http://www.bernstein-plus-sons.com/software/CBF/"
SRC_URI="http://www.bernstein-plus-sons.com/software/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

RDEPEND=""
DEPEND="${RDEPEND}"

S="${WORKDIR}/${MY_P}"

src_unpack(){
	unpack ${A}
	cd "${S}"
	cp Makefile_LINUX_gcc42 Makefile
	epatch "${FILESDIR}"/HOMEDIR.patch
}

src_compile(){
	#append-flags -ansi -D_POSIX_SOURCE
#	export CFLAGS="${CFLAGS} -ansi -D_POSIX_SOURCE"
#	export CXXFLAGS="${CXXFLAGS} -ansi -D_POSIX_SOURCE"
#	append-fflags -fno-range-check
	make all #\
#	CFLAGS="${CFLAGS}" \
#	F90FLAGS="${FFLAGS}" \
#	all
}
