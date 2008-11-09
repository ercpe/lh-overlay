# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils

DESCRIPTION="recover deleted files on an ext3 file system"
HOMEPAGE="http://www.xs4all.nl/~carlo17/howto/undelete_ext3.html"
SRC_URI="http://ext3grep.googlecode.com/files/${P}.tar.gz"

LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE="largefile pch"
RDEPEND=""
DEPEND="${RDEPEND}"

src_unpack(){
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/gcc-4.3.patch
}

src_compile() {

	econf \
		$(use_enable pch) \
		$(use_enable largefile)

	emake
}


src_install() {

	emake DESTDIR="${D}" install || \
	die

	dodoc NEWS README
}
