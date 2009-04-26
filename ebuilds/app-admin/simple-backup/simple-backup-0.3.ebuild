# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils

SLOT="0"
LICENSE="as-is"
KEYWORDS="~x86 ~amd64"
DESCRIPTION="Simple bash-based backup script"
SRC_URI="http://gentoo.j-schmitz.net/private-overlay/distfiles/app-admin/simple-backup/${P}.tar.bz2"
HOMEPAGE="http://www.j-schmitz.net"
IUSE=""
RESTRICT="primaryuri"

src_install(){
	exeinto /usr/lib/simple-backup
	doexe simple-backup.sh

	insinto /etc/
	doins simple-backup.conf

	insinto /etc/simple-backup/
	doins .sample.conf

	dosym /usr/lib/simple-backup/simple-backup.sh /usr/bin/simple-backup

	einfo "Remember to copy the sample file /etc/simple-backup/.sample.conf and adjust it for your needs!";
}
