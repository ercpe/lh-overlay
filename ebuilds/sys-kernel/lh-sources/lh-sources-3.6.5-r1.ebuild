# Copyright 1999-2012 Gentoo Foundation
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

BFQ_URI_PATCH_LEVEL="5"
AUFS_URI_PATCH_LEVEL="121104"

BFQ_PATCH_LIST="
	${WORKDIR}/bfq-patches/0001-block-cgroups-kconfig-build-bits-for-BFQ-v5-$(get_version_component_range 1-2).patch
	${WORKDIR}/bfq-patches/0002-block-introduce-the-BFQ-v5-I-O-sched-for-$(get_version_component_range 1-2).patch"
BFQ_DOC="${WORKDIR}/bfq-patches/README.BFQ"

# http://unicorn.drogon.net/rpi/linux-arm.patch
ARM_PATCH_LIST="${FILESDIR}/${P}-armv6.patch"

AUFS_MAX=6
if [[ "$(get_version_component_range 2)" -gt "${AUFS_MAX}" ]]; then
	AUFS_KVER="3.x-rcN"
else
	AUFS_KVER=$(get_version_component_range 1-2)
fi

AUFS_PATCH_LIST="
	${WORKDIR}/aufs3-patches/${AUFS_KVER}-aufs3-kbuild.patch
	${WORKDIR}/aufs3-patches/${AUFS_KVER}-aufs3-base.patch"
#	${WORKDIR}/aufs3-patches/${AUFS_KVER}-aufs3-proc_map.patch"

UNIPATCH_LIST="${BFQ_PATCH_LIST} ${ARM_PATCH_LIST}"
UNIPATCH_DOCS="${BFQ_DOC}"
PATCH_DEPTH="1"

KEYWORDS="~amd64 ~x86"
HOMEPAGE="http://dev.gentoo.org/~mpagano/genpatches http://algo.ing.unimo.it/people/paolo/disk_sched"
IUSE="deblob"

DESCRIPTION="Full sources including the Gentoo patchset and the BFQ patchset for the $(get_version_component_range 1-2) kernel tree"

BFQ_URI_BASE="http://algo.ing.unimo.it/people/paolo/disk_sched/patches/$(get_version_component_range 1-2).0-v${BFQ_URI_PATCH_LEVEL}"
BFQ_URI="
	${BFQ_URI_BASE}/0001-block-cgroups-kconfig-build-bits-for-BFQ-v5-$(get_version_component_range 1-2).patch
	${BFQ_URI_BASE}/0002-block-introduce-the-BFQ-v5-I-O-sched-for-$(get_version_component_range 1-2).patch
	${BFQ_URI_BASE}/README.BFQ
	"

BFQ_URI_BASE="bfq-patches-$(get_version_component_range 1-2).tar.xz"
BFQ_URI="http://dev.gentoo.org/~jlec/distfiles/${BFQ_URI_BASE}"

LOGO_URI="http://dev.gentoo.org/~jlec/distfiles/lh-logo_linux_clut224.ppm"

AUFS_URI_BASE="aufs3-patches-${AUFS_URI_PATCH_LEVEL}.tar.xz"
AUFS_URI="http://dev.gentoo.org/~jlec/distfiles/${AUFS_URI_BASE}"

SRC_URI="${KERNEL_URI} ${GENPATCHES_URI} ${ARCH_URI} ${LOGO_URI} ${BFQ_URI}"

src_unpack() {
	unpack ${BFQ_URI_BASE}
	kernel-2_src_unpack
}

pkg_postinst() {
	kernel-2_pkg_postinst
	einfo "For more info on this patchset, and how to report problems, see:"
	einfo "${HOMEPAGE}"
}

src_prepare() {
	cp "${DISTDIR}"/lh-logo_linux_clut224.ppm drivers/video/logo/logo_linux_clut224.ppm || die
}

pkg_postrm() {
	kernel-2_pkg_postrm
}
