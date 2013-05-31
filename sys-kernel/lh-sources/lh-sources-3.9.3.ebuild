# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/gentoo-sources/gentoo-sources-3.6.1.ebuild,v 1.1 2012/10/07 19:36:37 mpagano Exp $

EAPI=5

ETYPE="sources"
K_WANT_GENPATCHES="base extras"
K_GENPATCHES_VER="6"
K_DEBLOB_AVAILABLE="1"
inherit kernel-2 versionator
detect_version
detect_arch

KMAIN_VER=$(get_version_component_range 1-2)

AUFS_VERSION=3.9_p20130519
AUFS_TARBALL="aufs-sources-${AUFS_VERSION}.tar.xz"
# git archive -v --remote=git://git.code.sf.net/p/aufs/aufs3-standalone aufs3.8 > aufs-sources-${AUFS_VERSION}.tar
AUFS_URI="http://dev.gentoo.org/~jlec/distfiles/${AUFS_TARBALL}"

LOGO_URI="http://dev.gentoo.org/~jlec/distfiles/lh-logo_linux_clut224.ppm"

BFQ_URI_PATCH_LEVEL="6r1"
BFQ_BASE="http://www.algogroup.unimo.it/people/paolo/disk_sched/patches/${KMAIN_VER}.0-v${BFQ_URI_PATCH_LEVEL}"
BFQ_URI="
	${BFQ_BASE}/0001-block-cgroups-kconfig-build-bits-for-BFQ-v${BFQ_URI_PATCH_LEVEL}-${KMAIN_VER}.patch -> \
		0001-block-cgroups-kconfig-build-bits-for-BFQ-v${BFQ_URI_PATCH_LEVEL}-${KMAIN_VER}.patch1
	${BFQ_BASE}/0002-block-introduce-the-BFQ-v${BFQ_URI_PATCH_LEVEL}-I-O-sched-for-${KMAIN_VER}.patch -> \
		0002-block-introduce-the-BFQ-v${BFQ_URI_PATCH_LEVEL}-I-O-sched-for-${KMAIN_VER}.patch1
	${BFQ_BASE}/README.BFQ -> README-${PV}.BFQ"

DESCRIPTION="Full sources including the Gentoo patchset, the BFQ patchset and aufs support for the  ${KMAIN_VER} kernel"
HOMEPAGE="
	http://dev.gentoo.org/~mpagano/genpatches
	http://www.algogroup.unimo.it/people/paolo/disk_sched
	http://aufs.sourceforge.net/"
SRC_URI="${KERNEL_URI} ${GENPATCHES_URI} ${ARCH_URI} ${AUFS_URI} ${LOGO_URI} ${BFQ_URI}"

KEYWORDS="~amd64 ~x86"
IUSE="deblob module proc"

PDEPEND=">=sys-fs/aufs-util-3.7"

AUFS_PATCH_LIST="
	"${WORKDIR}"/aufs3-kbuild.patch
	"${WORKDIR}"/aufs3-base.patch"

_BFQ_PATCH_LIST="
	${DISTDIR}/0001-block-cgroups-kconfig-build-bits-for-BFQ-v${BFQ_URI_PATCH_LEVEL}-${KMAIN_VER}.patch1
	${DISTDIR}/0002-block-introduce-the-BFQ-v${BFQ_URI_PATCH_LEVEL}-I-O-sched-for-${KMAIN_VER}.patch1"

BFQ_DOC="${DISTDIR}/README-${PV}.BFQ"

# http://unicorn.drogon.net/rpi/linux-arm.patch
ARM_PATCH_LIST="${FILESDIR}/${PN}-${KMAIN_VER}-armv6.patch"

UNIPATCH_LIST="${BFQ_PATCH_LIST} ${ARM_PATCH_LIST} ${AUFS_PATCH_LIST}"
UNIPATCH_DOCS="${BFQ_DOC}"

src_unpack() {
	use module && UNIPATCH_LIST+=" "${WORKDIR}"/aufs3-standalone.patch"
	use proc && UNIPATCH_LIST+=" "${WORKDIR}"/aufs3-proc_map.patch"
	unpack ${AUFS_TARBALL}
	mkdir "${WORKDIR}"/patches || die
	cp ${_BFQ_PATCH_LIST} "${WORKDIR}"/patches || die
	kernel-2_src_unpack
}

src_prepare() {
	if ! use module; then
		sed -e 's:tristate:bool:g' -i "${WORKDIR}"/fs/aufs/Kconfig || die
	fi
	if ! use proc; then
		sed '/config AUFS_PROC_MAP/,/^$/d' -i "${WORKDIR}"/fs/aufs/Kconfig || die
	fi
	cp -i "${WORKDIR}"/include/linux/aufs_type.h include/linux/aufs_type.h || die
	cp -i "${WORKDIR}"/include/uapi/linux/aufs_type.h include/uapi/linux/aufs_type.h || die
	cp -ri "${WORKDIR}"/{Documentation,fs} . || die
	cp "${DISTDIR}"/lh-logo_linux_clut224.ppm drivers/video/logo/logo_linux_clut224.ppm || die
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
