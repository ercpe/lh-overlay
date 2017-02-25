# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit cmake-utils flag-o-matic

DESCRIPTION="New development on tirpc"
HOMEPAGE="https://github.com/nfs-ganesha/ntirpc"
SRC_URI="https://github.com/nfs-ganesha/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"
IUSE="rdma rpcsec_gss"

DEPEND="
	dev-libs/cityhash
	rdma? (
		sys-fabric/librdmacm
		sys-fabric/libibverbs
	)
	rpcsec_gss? ( virtual/krb5 )
"
RDEPEND="${DEPEND}"

src_configure() {
	local mycmakeargs=(
		-DUSE_GSS=$(usex rpcsec_gss)
		-DUSE_RPC_RDMA=$(usex rdma)
	)
	cmake-utils_src_configure
}
