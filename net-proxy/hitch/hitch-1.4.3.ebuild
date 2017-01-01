# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit eutils

DESCRIPTION="A libev-based high performance SSL/TLS proxy"
HOMEPAGE="https://hitch-tls.org/"
SRC_URI="https://hitch-tls.org/source/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE=""

DEPEND="dev-libs/openssl:0
		>=dev-libs/libev-4"
RDEPEND="${DEPEND}"
