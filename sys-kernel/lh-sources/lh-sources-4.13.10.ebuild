# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

ETYPE="sources"
K_WANT_GENPATCHES="base extras"
K_GENPATCHES_VER=12
UNIPATCH_STRICTORDER=1
inherit kernel-2 readme.gentoo-r1 versionator
detect_version
detect_arch

KMAIN_VER=$(get_version_component_range 1-2)

AUFS_VERSION=4.13_p20171002
AUFS_TARBALL="aufs-sources-${AUFS_VERSION}.tar.xz"
AUFS_URI="https://dev.gentoo.org/~jlec/distfiles/${AUFS_TARBALL}"

LOGO_URI="https://dev.gentoo.org/~jlec/distfiles/lh-logo_linux_320_240_clut224.ppm"

GCCOPT_PATCH_LEVEL=720b1c392a2dd956d46407d4b689d3c379ccc107
GCCOPT_PATCH_NAME="enable_additional_cpu_optimizations_for_gcc_v4.9+_kernel_v4.13+.patch"
GCCOPT_URI="https://raw.github.com/graysky2/kernel_gcc_patch/${GCCOPT_PATCH_LEVEL}/${GCCOPT_PATCH_NAME} -> ${PN}-kernel-${GCCOPT_PATCH_LEVEL}.patch"
GCCOPT_HOMEPAGE="https://github.com/graysky2/kernel_gcc_patch"
DESCRIPTION="Full linux kernel sources including the Gentoo and aufs patchset"
HOMEPAGE="
	https://dev.gentoo.org/~mpagano/genpatches
	https://aufs.sourceforge.net/
	${GCCOPT_HOMEPAGE}
	"
SRC_URI="
	${KERNEL_URI}
	${ARCH_URI}
	${AUFS_URI}
	${LOGO_URI}
	${GCCOPT_URI}
	!vanilla? ( ${GENPATCHES_URI} )
"

KEYWORDS="~amd64 ~x86"
IUSE="module vanilla"
README_GENTOO_SUFFIX="-r1"

PDEPEND="=sys-fs/aufs-util-4*"

AUFS_PATCH_LIST="
	"${WORKDIR}"/aufs4-kbuild.patch
	"${WORKDIR}"/aufs4-base.patch
	"${WORKDIR}"/aufs4-mmap.patch"
GCCOPT_LIST=( "${DISTDIR}"/${PN}-kernel-${GCCOPT_PATCH_LEVEL}.patch )

UNIPATCH_LIST="
	${AUFS_PATCH_LIST}
	${GCCOPT_LIST}
"

src_unpack() {
	local p
	if use vanilla; then
		unset UNIPATCH_LIST_GENPATCHES UNIPATCH_LIST_DEFAULT
		ewarn "You are using USE=vanilla"
		ewarn "This will drop all support from the gentoo kernel security team"
	fi
	use module && UNIPATCH_LIST+=" "${WORKDIR}"/aufs4-standalone.patch"
	unpack ${AUFS_TARBALL}
	kernel-2_src_unpack
}

src_prepare() {
	kernel-2_src_prepare
	if ! use module; then
		sed -e 's:tristate:bool:g' -i "${WORKDIR}"/fs/aufs/Kconfig || die
	fi
	cp \
		"${WORKDIR}"/include/uapi/linux/aufs_type.h \
		include/uapi/linux/aufs_type.h || die
	cp -r "${WORKDIR}"/{Documentation,fs} . || die
	cp \
		"${DISTDIR}"/lh-logo_linux_320_240_clut224.ppm \
		drivers/video/logo/logo_linux_clut224.ppm || die
}

src_install() {
	kernel-2_src_install
	dodoc "${WORKDIR}"/{aufs4-loopback,vfs-ino,tmpfs-idr}.patch
	docompress -x /usr/share/doc/${PF}/{aufs4-loopback,vfs-ino,tmpfs-idr}.patch
	readme.gentoo_create_doc
}

pkg_postinst() {
	kernel-2_pkg_postinst
	einfo "For more info on this patchset, and how to report problems, see:"
	einfo "${HOMEPAGE}"
	has_version sys-fs/aufs-util || \
		elog "In order to use aufs FS you need to install sys-fs/aufs-util"

	readme.gentoo_print_elog
}

pkg_postrm() {
	kernel-2_pkg_postrm
}
