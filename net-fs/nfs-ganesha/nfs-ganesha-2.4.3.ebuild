# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python2_7 )

inherit cmake-utils flag-o-matic python-single-r1

DESCRIPTION="A NFSv3,v4,v4.1 fileserver that runs in user mode on most UNIX/Linux systems"
HOMEPAGE="https://github.com/nfs-ganesha/nfs-ganesha"
SRC_URI="https://github.com/nfs-ganesha/${PN}/archive/V${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE="dbus debug gui nfs3 nfsidmap rdma tools vsock"
FS_SUPPORT=" vfs ceph gpfs zfs xfs panfs proxy glusterfs null rgw"
IUSE+=" ${FS_SUPPORT// / ganesha_fs_}"

REQUIRED_USE="gui? ( tools )"

RDEPEND="
	dev-libs/jemalloc
	net-libs/libnfsidmap
	net-libs/ntirpc[rdma?,rpcsec_gss]
	virtual/krb5
	dbus? ( sys-apps/dbus )
	ganesha_fs_ceph? ( sys-cluster/ceph )
	ganesha_fs_glusterfs? ( sys-cluster/glusterfs )
	ganesha_fs_xfs? ( sys-fs/xfsprogs )
	ganesha_fs_zfs? ( sys-fs/zfs )
	gui? (
		${PYTHON_DEPS}
		dev-python/PyQt4[${PYTHON_USEDEP},X]
	)
	tools? (
		${PYTHON_DEPS}
		dev-python/pygobject:2[${PYTHON_USEDEP}]
	)
"
DEPEND="${RDEPEND}
	sys-devel/bison
	sys-devel/flex
	virtual/pkgconfig
"

S="${WORKDIR}/${P}/src"

CMAKE_BUILD_TYPE="Release"

PATCHES=(
	"${FILESDIR}"/${P}-semicolon.patch
)

src_prepare() {
	sed \
		-e "/config_samples/s:doc\/ganesha:doc\/${PF}:g" \
		-e '/run\/ganesha/d' \
		-i CMakeLists.txt  || die
	cmake-utils_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DUSE_SYSTEM_NTIRPC=ON
		-DTIRPC_EPOLL=ON
		-DKRB5_FIND_COMPONENTS="gssrpc"
		-DUSE_GSS=ON
		-DUSE_DBUS=$(usex dbus)
		-DUSE_NFSIDMAP=$(usex nfsidmap)
		-DENABLE_VFS_DEBUG_ACL=$(usex debug)
		-DENABLE_RFC_ACL=$(usex debug)
		-DUSE_EFENCE=$(usex debug)
		-DDEBUG_SAL=$(usex debug)
		-DENABLE_LOCKTRACE=$(usex debug)
		-DUSE_NFS_RDMA=$(usex rdma)
		-DUSE_RPC_RDMA=$(usex rdma)
		-DUSE_NFS3=$(usex nfs3)
		-DUSE_NLM=$(usex nfs3)
		-DUSE_VSOCK=$(usex vsock)
		-DUSE_ADMIN_TOOLS=$(usex tools)
		-DUSE_GUI_ADMIN_TOOLS=$(usex gui)

		-DUSE_FSAL_CEPH=$(usex ganesha_fs_ceph)
		-DUSE_FSAL_GLUSTER=$(usex ganesha_fs_glusterfs)
		-DUSE_FSAL_GPFS=$(usex ganesha_fs_gpfs)
		-DUSE_FSAL_NULL=$(usex ganesha_fs_null)
		-DUSE_FSAL_PanFS=$(usex ganesha_fs_panfs)
		-DUSE_FSAL_PROXY=$(usex ganesha_fs_proxy)
		-DUSE_FSAL_RGW=$(usex ganesha_fs_rgw)
		-DUSE_FSAL_VFS=$(usex ganesha_fs_vfs)
		-DUSE_FSAL_XFS=$(usex ganesha_fs_xfs)
		-DUSE_FSAL_ZFS=$(usex ganesha_fs_zfs)
	)
	cmake-utils_src_configure
}
#testing
#/var/tmp/portage/net-fs/nfs-ganesha-2.4.3/work/nfs-ganesha-2.4.3/src/CMakeLists.txt:option(USE_TOOL_MULTILOCK "build multilock tool" OFF)
#/var/tmp/portage/net-fs/nfs-ganesha-2.4.3/work/nfs-ganesha-2.4.3/src/CMakeLists.txt:option(USE_CB_SIMULATOR "enable callback simulator thread" OFF)
#/var/tmp/portage/net-fs/nfs-ganesha-2.4.3/work/nfs-ganesha-2.4.3/src/CMakeLists.txt:option(ENABLE_ERROR_INJECTION "enable error injection" OFF)
#/var/tmp/portage/net-fs/nfs-ganesha-2.4.3/work/nfs-ganesha-2.4.3/src/CMakeLists.txt:# These are -D_FOO options, why ???  should be flags??
#/var/tmp/portage/net-fs/nfs-ganesha-2.4.3/work/nfs-ganesha-2.4.3/src/CMakeLists.txt:option(_NO_TCP_REGISTER "disable registration of tcp services on portmapper" OFF)
#/var/tmp/portage/net-fs/nfs-ganesha-2.4.3/work/nfs-ganesha-2.4.3/src/CMakeLists.txt:option(_NO_PORTMAPPER "disable registration on portmapper" OFF)
#/var/tmp/portage/net-fs/nfs-ganesha-2.4.3/work/nfs-ganesha-2.4.3/src/CMakeLists.txt:option(_NO_XATTRD "disable ghost xattr directory and files support" ON)
#/var/tmp/portage/net-fs/nfs-ganesha-2.4.3/work/nfs-ganesha-2.4.3/src/CMakeLists.txt:option(_VALGRIND_MEMCHECK "Initialize buffers passed to GPFS ioctl that valgrind doesn't understand" OFF)
#/var/tmp/portage/net-fs/nfs-ganesha-2.4.3/work/nfs-ganesha-2.4.3/src/CMakeLists.txt:option(USE_CUNIT "Use Cunit test framework" OFF)
#/var/tmp/portage/net-fs/nfs-ganesha-2.4.3/work/nfs-ganesha-2.4.3/src/CMakeLists.txt:option(USE_BLKIN "Use Blkin/Zipkin trace framework" OFF)
#/var/tmp/portage/net-fs/nfs-ganesha-2.4.3/work/nfs-ganesha-2.4.3/src/CMakeLists.txt:option(BLKIN_PREFIX "Blkin installation prefix" "/opt/blkin")
#/var/tmp/portage/net-fs/nfs-ganesha-2.4.3/work/nfs-ganesha-2.4.3/src/CMakeLists.txt:option(USE_GTEST "Use Google Test test framework" OFF)
#/var/tmp/portage/net-fs/nfs-ganesha-2.4.3/work/nfs-ganesha-2.4.3/src/CMakeLists.txt:option(GTEST_PREFIX "Google Test installation prefix"

src_install() {
	cmake-utils_src_install
	doinitd "${FILESDIR}"/${PN}.init
	doconfd "${FILESDIR}"/${PN}.confd
}
