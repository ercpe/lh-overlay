# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

PYTHON_COMPAT=( python{2_6,2_7} )

inherit multilib prefix python-single-r1

DESCRIPTION="Tools to handle squashed portage"
HOMEPAGE="http://www.j-schmitz.net/projects/squashed-portage/"
SRC_URI="http://gentoo.j-schmitz.net/portage-overlay/${CATEGORY}/${PN}/${P}.tar.xz"

SLOT="0"
KEYWORDS="~amd64 ~x86"
LICENSE="GPL-3"
IUSE="zsync"

RDEPEND="
	dev-python/progressbar[${PYTHON_USEDEP}]
	sys-fs/squashfs-tools:0
	virtual/python-argparse[${PYTHON_USEDEP}]
	zsync? ( net-misc/zsync )"
DEPEND=""

RESTRICT="mirror"

src_prepare() {
	eprefixify *
	sed \
		-e "s:GENTOOLIBDIR:$(get_libdir):g" \
		-i get-squashed-portage || die
	sed \
		-e 's:get-squashed-portage:get-squashed-portage -z:g' \
		-i squashed-portage.init || die
}

src_install() {
	dodir /var/portage
	keepdir /var/portage
	newinitd ${PN}.init ${PN}
	newconfd ${PN}.conf ${PN}
	dobin get-squashed-portage

	exeinto /usr/$(get_libdir)/${PN}/
	doexe fetch-squashed-portage.py
}
