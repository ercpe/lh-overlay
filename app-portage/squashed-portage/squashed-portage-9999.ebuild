# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

PYTHON_COMPAT=( python2_7 )

inherit git-r3 multilib python-r1 systemd

DESCRIPTION="Tools to handle squashed portage"
HOMEPAGE="http://ercpe.de/projects/squashed-portage"
SRC_URI=""
EGIT_REPO_URI="git://git.j-schmitz.net/squashed-portage.git"

SLOT="0"
LICENSE="GPL-3+"
KEYWORDS=""
IUSE="aufs zsync"

RDEPEND="
	dev-python/progressbar[${PYTHON_USEDEP}]
	>=sys-apps/portage-2.2.8
	sys-fs/squashfs-tools:0
	aufs? ( sys-fs/aufs-util )
	zsync? ( net-misc/zsync )"
DEPEND="app-misc/ca-certificates[cacert]"

RESTRICT="mirror"
EGIT_NONSHALLOW=true

src_prepare() {
	sed \
		-e "s:\@GENTOOLIBDIR\@:$(get_libdir):g" \
		-i src/get-squashed-portage || die

	if use zsync; then
		sed \
			-e 's:get-squashed-portage:get-squashed-portage -z:g' \
			-i src/squashed-portage.init || die
	fi
}

src_install() {
	dobin src/get-squashed-portage

	python_foreach_impl python_newscript src/fetch-squashed-portage.py fetch-squashed-portage

	newinitd src/${PN}.init ${PN}
	newconfd src/${PN}.confd ${PN}

	insinto /etc/
	doins src/${PN}.conf

	systemd_dounit src/{*.service,*.mount,*.target}
	systemd_dotmpfilesd src/squashed-portage.tmpfiles.conf
	use aufs && systemd_newunit src/var-db-portage.mount.aufs var-db-portage.mount
}

pkg_postinst() {
	einfo "Starting with 0.16 some fundamental things have changed:"
	einfo " - The get-squashed-portage does no longer stop the squashed-portage service. As a result,"
	einfo "   you have to change your sync to something like:"
	einfo ""
	einfo "     /etc/init.d/squashed-portage stop"
	einfo "     get-squashed-portage"
	einfo "     /etc/init.d/squashed-portage start"
	einfo ""
	einfo " - It is no longer supported to have anything mounted below PORTDIR."
	einfo "   You are encouraged to set PKGDIR / DISTDIR in /etc/portage/make.conf or make sure you umount/remount"
	einfo "   the filesystems before starting or stopping the squashed-portage service."
	echo ""
	ewarn "The config file location changed"
	ewarn "please check /etc/${PN}.conf"
}
