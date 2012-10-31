# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/gentoo-sources/gentoo-sources-3.6.1.ebuild,v 1.1 2012/10/07 19:36:37 mpagano Exp $

EAPI="3"

ETYPE="sources"
K_WANT_GENPATCHES="base extras"
K_GENPATCHES_VER="5"
K_DEBLOB_AVAILABLE="1"
inherit kernel-2 versionator
detect_version
detect_arch

UNIPATCH_LIST="
	"${FILESDIR}"/0001-block-cgroups-kconfig-build-bits-for-BFQ-v5-$(get_version_component_range 1-2).patch
	"${FILESDIR}"/0002-block-introduce-the-BFQ-v5-I-O-sched-for-$(get_version_component_range 1-2).patch"
UNIPATCH_DOCS="${FILESDIR}/README.BFQ"
PATCH_DEPTH="1"

KEYWORDS="~amd64 ~x86"
HOMEPAGE="http://dev.gentoo.org/~mpagano/genpatches http://algo.ing.unimo.it/people/paolo/disk_sched"
IUSE="deblob"

DESCRIPTION="Full sources including the Gentoo patchset and the BFQ patchset for the $(get_version_component_range 1-2) kernel tree"
BFQ_URI_PATCH_LEVEL="5"
BFQ_URI_BASE="http://algo.ing.unimo.it/people/paolo/disk_sched/patches/$(get_version_component_range 1-2).0-v${BFQ_URI_PATCH_LEVEL}"
BFQ_URI="
	${BFQ_URI_BASE}/0001-block-cgroups-kconfig-build-bits-for-BFQ-v5-$(get_version_component_range 1-2).patch
	${BFQ_URI_BASE}/0002-block-introduce-the-BFQ-v5-I-O-sched-for-$(get_version_component_range 1-2).patch
	${BFQ_URI_BASE}/README.BFQ
	"

LOGO_URI="http://dev.gentoo.org/~jlec/distfiles/lh-logo_linux_clut224.ppm"

#SRC_URI="${KERNEL_URI} ${GENPATCHES_URI} ${ARCH_URI} ${BFQ_URI}"
SRC_URI="${KERNEL_URI} ${GENPATCHES_URI} ${ARCH_URI} ${LOGO_URI}"

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
