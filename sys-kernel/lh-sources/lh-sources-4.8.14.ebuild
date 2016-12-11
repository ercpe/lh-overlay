# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

ETYPE="sources"
K_WANT_GENPATCHES="base extras"
K_GENPATCHES_VER=16
K_DEBLOB_AVAILABLE="0"
K_KDBUS_AVAILABLE="0"
UNIPATCH_STRICTORDER=1
inherit kernel-2 readme.gentoo-r1 versionator
detect_version
detect_arch

KMAIN_VER=$(get_version_component_range 1-2)

AUFS_VERSION=4.8_p20161010
AUFS_TARBALL="aufs-sources-${AUFS_VERSION}.tar.xz"
AUFS_URI="http://dev.gentoo.org/~jlec/distfiles/${AUFS_TARBALL}"

LOGO_URI="http://dev.gentoo.org/~jlec/distfiles/lh-logo_linux_320_240_clut224.ppm"

# Set to true, if BFQ needs to apply seperately
BFQ=true

BFQ_URI_PATCH_MAJOR="8"
BFQ_URI_PATCH_MINOR="0"
BFQ_URI_PATCH_LEVEL="7r11"
#BFQ_BASE="http://algo.ing.unimo.it/people/paolo/disk_sched/patches/4.${BFQ_URI_PATCH_MAJOR}.${BFQ_URI_PATCH_MINOR}-v${BFQ_URI_PATCH_LEVEL}"
BFQ_BASE="http://algo.ing.unimo.it/people/paolo/disk_sched/patches/4.${BFQ_URI_PATCH_MAJOR}.${BFQ_URI_PATCH_MINOR}-v8r4"
BFQ_URI="
	${BFQ_BASE}/0001-block-cgroups-kconfig-build-bits-for-BFQ-v${BFQ_URI_PATCH_LEVEL}-4.${BFQ_URI_PATCH_MAJOR}.${BFQ_URI_PATCH_MINOR}.patch
	${BFQ_BASE}/0002-block-introduce-the-BFQ-v${BFQ_URI_PATCH_LEVEL}-I-O-sched-to-be-ported.patch
	${BFQ_BASE}/0003-block-bfq-add-Early-Queue-Merge-EQM-to-BFQ-v${BFQ_URI_PATCH_LEVEL}-to-.patch
	${BFQ_BASE}/0004-Turn-BFQ-v${BFQ_URI_PATCH_LEVEL}-into-BFQ-v8r4-for-4.${BFQ_URI_PATCH_MAJOR}.${BFQ_URI_PATCH_MINOR}.patch
"
#	${BFQ_BASE}/README.BFQ -> README-v${BFQ_URI_PATCH_LEVEL}-${BFQ_URI_PATCH_MAJOR}.BFQ"
BFQ_PATCH_LIST=(
	"${DISTDIR}/0001-block-cgroups-kconfig-build-bits-for-BFQ-v${BFQ_URI_PATCH_LEVEL}-4.${BFQ_URI_PATCH_MAJOR}.${BFQ_URI_PATCH_MINOR}.patch"
	"${DISTDIR}/0002-block-introduce-the-BFQ-v${BFQ_URI_PATCH_LEVEL}-I-O-sched-to-be-ported.patch"
	"${DISTDIR}/0003-block-bfq-add-Early-Queue-Merge-EQM-to-BFQ-v${BFQ_URI_PATCH_LEVEL}-to-.patch"
	"${DISTDIR}/0004-Turn-BFQ-v${BFQ_URI_PATCH_LEVEL}-into-BFQ-v8r4-for-4.${BFQ_URI_PATCH_MAJOR}.${BFQ_URI_PATCH_MINOR}.patch"
)

GCCOPT_PATCH_LEVEL=e50ee4fe4039e7bc9eae6bd17797de0dd30a087b
GCCOPT_PATCH_NAME="enable_additional_cpu_optimizations_for_gcc_v4.9+_kernel_v3.15+.patch"
GCCOPT_URI="https://raw.github.com/graysky2/kernel_gcc_patch/${GCCOPT_PATCH_LEVEL}/${GCCOPT_PATCH_NAME} -> ${PN}-kernel-${GCCOPT_PATCH_LEVEL}.patch"
GCCOPT_HOMEPAGE="https://github.com/graysky2/kernel_gcc_patch"
DESCRIPTION="Full sources including the Gentoo patchset, the BFQ patchset and aufs support for the  4.${BFQ_URI_PATCH_MAJOR} kernel"
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
	HOMEPAGE+=" http://algo.ing.unimo.it/people/paolo/disk_sched/"
	SRC_URI+=" ${BFQ_URI}"
fi

KEYWORDS="~amd64 ~x86"
IUSE="deblob module vanilla"
README_GENTOO_SUFFIX="-r1"

PDEPEND="=sys-fs/aufs-util-4*"

AUFS_PATCH_LIST="
	"${WORKDIR}"/aufs4-kbuild.patch
	"${WORKDIR}"/aufs4-base.patch
	"${WORKDIR}"/aufs4-mmap.patch"
GCCOPT_LIST=( "${DISTDIR}"/${PN}-kernel-${GCCOPT_PATCH_LEVEL}.patch )

#BFQ_DOC="${DISTDIR}/README-v${BFQ_URI_PATCH_LEVEL}-${BFQ_URI_PATCH_MINOR}.BFQ"

UNIPATCH_LIST="
	${AUFS_PATCH_LIST}
	${GCCOPT_LIST}
"

if [[ ${BFQ} == "true" ]]; then
	# UNIPATCH_LIST+=" ${BFQ_PATCH_LIST[@]}"
	UNIPATCH_DOCS="${BFQ_DOC}"
fi

src_unpack() {
	local p
	if use vanilla; then
		unset UNIPATCH_LIST_GENPATCHES UNIPATCH_LIST_DEFAULT
		ewarn "You are using USE=vanilla"
		ewarn "This will drop all support from the gentoo kernel security team"
	fi
	use module && UNIPATCH_LIST+=" "${WORKDIR}"/aufs4-standalone.patch"
	unpack ${AUFS_TARBALL}
	if [[ ${BFQ} == "true" ]]; then
		mkdir "${WORKDIR}"/patches || die
		for p in ${BFQ_PATCH_LIST[@]}; do
			cp "${p}" "${WORKDIR}"/patches/$(basename ${p})1 || die
		done
	fi
	kernel-2_src_unpack
}

src_prepare() {
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
