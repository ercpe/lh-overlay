# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="3"

inherit eutils toolchain-funcs

DESCRIPTION="NAT-PMP daemon"
HOMEPAGE="http://tedp.id.au/stallone/"
SRC_URI="http://tedp.id.au/stallone/releases/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND="app-text/asciidoc dev-libs/libdaemon sys-libs/libcap"
RDEPEND="${DEPEND}"

S=${WORKDIR}/${P}

src_install() {
	emake DESTDIR="${D}" install || die;
	newinitd "${FILESDIR}"/stallone.init.d stallone
}
