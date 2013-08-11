# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

PYTHON_COMPAT=( python{2_6,2_7} )

inherit git-2 multilib prefix python-r1 systemd

DESCRIPTION="Tools to handle squashed portage"
HOMEPAGE="http://www.j-schmitz.net/projects/squashed-portage/"
SRC_URI=""
EGIT_REPO_URI="https://repos.j-schmitz.net/git/pub/squashed-portage.git"

SLOT="0"
LICENSE="GPL-3"
KEYWORDS=""
IUSE="aufs zsync"

RDEPEND="
	dev-python/progressbar[${PYTHON_USEDEP}]
	sys-fs/squashfs-tools:0
	virtual/python-argparse[${PYTHON_USEDEP}]
	aufs? ( sys-fs/aufs-util )
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

	dobin get-squashed-portage

	python_scriptinto /usr/libexec/${PN}/
	python_foreach_impl python_doscript fetch-squashed-portage.py

	newinitd ${PN}.init ${PN}
	newconfd ${PN}.conf ${PN}

	systemd_dounit *.service *.mount *.target
	systemd_dotmpfilesd squashed-portage.tmpfiles.conf
	use aufs && systemd_newunit usr-portage.mount.aufs usr-portage.mount
}
