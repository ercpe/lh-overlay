# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils

DESCRIPTION="A small command line application, intended to be a replacement for the apm tool"
HOMEPAGE="http://freeunix.dyndns.org:8088/site2/acpitool.shtml"
#SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"
SRC_URI="http://freeunix.dyndns.org:8088/ftp_site/pub/unix/acpitool/acpitool-0.5.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

src_unpack() {
	unpack ${A}
#	epatch "${FILESDIR}"/${PN}-0.4.7-proc_acpi_info_move.patch
	epatch "${FILESDIR}"/${P}-gcc43.patch
}

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS ChangeLog README TODO
}
