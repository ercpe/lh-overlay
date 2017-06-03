# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
inherit user systemd

DESCRIPTION="Fast and easily configured backup server"
HOMEPAGE="https://www.urbackup.org"
SRC_URI="https://hndl.urbackup.org/Server/${PV}/${P}.tar.gz"

SLOT="0"
LICENSE="AGPL-3"
KEYWORDS="~amd64 ~x86"
IUSE="crypt hardened fuse mail zlib"

RDEPEND="
	crypt? ( >=dev-libs/crypto++-5.1 )
	dev-db/sqlite
	fuse? ( sys-fs/fuse )
	mail? ( >=net-misc/curl-7.2 )
	zlib? ( sys-libs/zlib )"

DEPEND="${RDEPEND}"

pkg_setup() {
	enewgroup urbackup
	enewuser urbackup -1 /bin/bash "${EPREFIX}"/var/lib/urbackup urbackup
}

src_configure() {
	econf \
		$(use_with crypt crypto) \
		$(use_enable hardened fortify) \
		$(use_with fuse mountvhd) \
		$(use_with mail) \
		$(use_with zlib) \
		--enable-packaging
}

src_install() {
	dodir /usr/share/man/man1

	emake DESTDIR="${D}" install

	insinto /etc/logrotate.d
	newins logrotate_urbackupsrv urbackupsrv

	newconfd defaults_server urbackupsrv
	newinitd "${FILESDIR}"/${P}-urbackupsrv ${PN}

	systemd_newunit "${FILESDIR}/${P}-urbackup-server.service" "${PN}.service"

	fowners -R urbackup:urbackup "${EPREFIX}/var/lib/urbackup"
	fowners -R urbackup:urbackup "${EPREFIX}/usr/share/urbackup/www"
}
