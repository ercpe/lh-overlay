# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit cmake-utils flag-o-matic

DESCRIPTION="A NFSv3,v4,v4.1 fileserver that runs in user mode on most UNIX/Linux systems"
HOMEPAGE="https://github.com/nfs-ganesha/nfs-ganesha"
SRC_URI="https://github.com/nfs-ganesha/${PN}/archive/V${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS=""

IUSE="ceph glusterfs jemalloc xfs" # zfs

DEPEND="
	net-libs/ntirpc
	net-libs/libnfsidmap
	sys-devel/bison
	sys-devel/flex
	virtual/krb5
	virtual/pkgconfig
	jemalloc? ( dev-libs/jemalloc )
	glusterfs? ( sys-cluster/glusterfs )
	ceph? ( sys-cluster/ceph )
	xfs? ( sys-fs/xfsprogs )
"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${P}/src"

CMAKE_BUILD_TYPE="Release"

PATCHES=(
	"${FILESDIR}/remove-cityhash-sse4_2.patch"
)

src_configure() {
	local mycmakeargs=(
		"-DUSE_SYSTEM_NTIRPC=ON"
	)

	cmake-utils_src_configure
}
