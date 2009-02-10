
# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit toolchain-funcs

DESCRIPTION="Squidview is an interactive console program which monitors and displays squid logs in a nice fashion, and may then go deeper with searching and reporting functions."
HOMEPAGE="http://www.rillion.net/squidview/"
SRC_URI="http://www.rillion.net/squidview/${PN}-${PV}.tar.gz"
LICENSE="GPL"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""
RESTRICT="mirror"

src_install(){
	dobin squidview
	dodoc AUTHORS BUGS COPYING ChangeLog HOWTO
}
