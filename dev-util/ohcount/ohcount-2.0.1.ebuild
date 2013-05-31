# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit multilib

DESCRIPTION="A source code line counter"
HOMEPAGE="http://labs.ohloh.net/ohcount"
SRC_URI="http://labs.ohloh.net/download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=dev-lang/ruby-1.8.6
	dev-libs/libpcre
	dev-ruby/diff-lcs"
DEPEND="${RDEPEND}
	dev-ruby/rake
	dev-util/ragel"

src_compile() {
	rake || die "failed to compile"
}

src_install() {
	local ohcountins
	local myarch

	ohcountins="/usr/$(get_libdir)/ruby/site_ruby/${P}"
	myarch=$(uname -m)-linux

	rake package || die "failed to create package"
	insinto "${ohcountins}"
	doins -r pkg/${P}/* || die "failed to install things"

	insinto "${ohcountins}"/lib/${myarch}/
	doins -r lib/${myarch}/*.so || die "failed to install libs"

	fperms 755 "${ohcountins}"/bin/${PN}

	cat >> "${T}"/${PN} <<- EOF
	#!/bin/bash
	OHCOUNT_ROOT="${ohcountins}"
	exec \${OHCOUNT_ROOT}/bin/${PN}
	EOF
	dobin  "${T}"/${PN} || die "failed to install wrapper"

	dodoc README || die "nothing to read"
}
