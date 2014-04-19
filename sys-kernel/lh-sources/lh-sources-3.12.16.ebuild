# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/gentoo-sources/gentoo-sources-3.6.1.ebuild,v 1.1 2012/10/07 19:36:37 mpagano Exp $

EAPI=5

ETYPE="sources"
K_WANT_GENPATCHES="base extras"
K_GENPATCHES_VER="17"
K_DEBLOB_AVAILABLE="1"
UNIPATCH_STRICTORDER=1
inherit kernel-2 versionator
detect_version
detect_arch

KMAIN_VER=$(get_version_component_range 1-2)

AUFS_VERSION=3.12.x_p20140310
AUFS_TARBALL="aufs-sources-${AUFS_VERSION}.tar.xz"
# git archive -v --remote=git://git.code.sf.net/p/aufs/aufs3-standalone aufs3.8 > aufs-sources-${AUFS_VERSION}.tar
AUFS_URI="http://dev.gentoo.org/~jlec/distfiles/${AUFS_TARBALL}"

LOGO_URI="http://dev.gentoo.org/~jlec/distfiles/lh-logo_linux_320_240_clut224.ppm"

# Set to true, if BFQ needs to apply seperately
BFQ=true

BFQ_URI_PATCH_MINOR="0"
BFQ_URI_PATCH_LEVEL="7r2"
BFQ_BASE="http://www.algogroup.unimo.it/people/paolo/disk_sched/patches/${KMAIN_VER}.${BFQ_URI_PATCH_MINOR}-v${BFQ_URI_PATCH_LEVEL}"
BFQ_URI="
	${BFQ_BASE}/0001-block-cgroups-kconfig-build-bits-for-BFQ-v${BFQ_URI_PATCH_LEVEL}-${KMAIN_VER}.patch -> \
		0001-block-cgroups-kconfig-build-bits-for-BFQ-v${BFQ_URI_PATCH_LEVEL}-${KMAIN_VER}.patch1
	${BFQ_BASE}/0002-block-introduce-the-BFQ-v${BFQ_URI_PATCH_LEVEL}-I-O-sched-for-${KMAIN_VER}.patch -> \
		0002-block-introduce-the-BFQ-v${BFQ_URI_PATCH_LEVEL}-I-O-sched-for-${KMAIN_VER}.patch1
	${BFQ_BASE}/0003-block-bfq-add-Early-Queue-Merge-EQM-to-BFQ-v${BFQ_URI_PATCH_LEVEL}-for-${KMAIN_VER}.${BFQ_URI_PATCH_MINOR}.patch -> \
		0003-block-bfq-add-Early-Queue-Merge-EQM-to-BFQ-v${BFQ_URI_PATCH_LEVEL}-for-${KMAIN_VER}.${BFQ_URI_PATCH_MINOR}.patch1
	${BFQ_BASE}/README.BFQ -> README-${PV}.BFQ"

GCCOPT_PATCH_LEVEL="391b268db43db7e45acdec900adebb2d1545db9f"
GCCOPT_URI="https://raw.github.com/graysky2/kernel_gcc_patch/master/kernel-${GCCOPT_PATCH_LEVEL}.patch -> ${PN}-kernel-${GCCOPT_PATCH_LEVEL}.patch"
GCCOPT_HOMEPAGE="https://github.com/graysky2/kernel_gcc_patch"
DESCRIPTION="Full sources including the Gentoo patchset, the BFQ patchset and aufs support for the  ${KMAIN_VER} kernel"
HOMEPAGE="
	http://dev.gentoo.org/~mpagano/genpatches
	http://aufs.sourceforge.net/
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

if [[ ${BFQ} == "true" ]]; then
	HOMEPAGE+=" http://www.algogroup.unimo.it/people/paolo/disk_sched"
	SRC_URI+=" ${BFQ_URI}"
fi

KEYWORDS="~amd64 ~x86"
IUSE="deblob module vanilla"

PDEPEND=">=sys-fs/aufs-util-3.7"

AUFS_PATCH_LIST="
	"${WORKDIR}"/aufs3-kbuild.patch
	"${WORKDIR}"/aufs3-base.patch
	"${WORKDIR}"/aufs3-mmap.patch"
BFQ_PATCH_LIST=(
	"${DISTDIR}"/0001-block-cgroups-kconfig-build-bits-for-BFQ-v${BFQ_URI_PATCH_LEVEL}-${KMAIN_VER}.patch1
	"${DISTDIR}"/0002-block-introduce-the-BFQ-v${BFQ_URI_PATCH_LEVEL}-I-O-sched-for-${KMAIN_VER}.patch1
	"${DISTDIR}"/0003-block-bfq-add-Early-Queue-Merge-EQM-to-BFQ-v${BFQ_URI_PATCH_LEVEL}-for-${KMAIN_VER}.${BFQ_URI_PATCH_MINOR}.patch1
	)
GCCOPT_LIST=( "${DISTDIR}"/${PN}-kernel-${GCCOPT_PATCH_LEVEL}.patch )

BFQ_DOC="${DISTDIR}/README-${PV}.BFQ"

# http://unicorn.drogon.net/rpi/linux-arm.patch
ARM_PATCH_LIST="${FILESDIR}/${PN}-${KMAIN_VER}-armv6.patch"

UNIPATCH_LIST="
	${ARM_PATCH_LIST}
	${AUFS_PATCH_LIST}
	${GCCOPT_LIST}
"

if [[ ${BFQ} == "true" ]]; then
	# UNIPATCH_LIST+=" ${BFQ_PATCH_LIST[@]}"
	UNIPATCH_DOCS="${BFQ_DOC}"
fi

src_unpack() {
	if use vanilla; then
		unset UNIPATCH_LIST_GENPATCHES UNIPATCH_LIST_DEFAULT
		ewarn "You are using USE=vanilla"
		ewarn "This will drop all support from the gentoo kernel security team"
	fi
	use module && UNIPATCH_LIST+=" "${WORKDIR}"/aufs3-standalone.patch"
	unpack ${AUFS_TARBALL}
	if [[ ${BFQ} == "true" ]]; then
		mkdir "${WORKDIR}"/patches || die
		cp ${BFQ_PATCH_LIST[@]} "${WORKDIR}"/patches || die
	fi
	kernel-2_src_unpack
}

src_prepare() {
	if ! use module; then
		sed -e 's:tristate:bool:g' -i "${WORKDIR}"/fs/aufs/Kconfig || die
	fi
	cp -f "${WORKDIR}"/include/uapi/linux/aufs_type.h include/uapi/linux/aufs_type.h || die
	cp -rf "${WORKDIR}"/{Documentation,fs} . || die
	cp "${DISTDIR}"/lh-logo_linux_320_240_clut224.ppm drivers/video/logo/logo_linux_clut224.ppm || die
}

pkg_postinst() {
	kernel-2_pkg_postinst
	einfo "For more info on this patchset, and how to report problems, see:"
	einfo "${HOMEPAGE}"
	has_version sys-fs/aufs-util || \
		einfo "In order to use aufs FS you need to install sys-fs/aufs-util"
}

pkg_postrm() {
	kernel-2_pkg_postrm
}