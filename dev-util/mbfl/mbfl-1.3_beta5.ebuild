# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

MY_PV="${PV/_beta/b}"

DESCRIPTION="Marco's Bash Functions Library"
HOMEPAGE="http://gna.org/projects/mbfl/"
SRC_URI="http://download.gna.org/mbfl/${MY_PV}/${PN}-${MY_PV}-src.tar.bz2"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE="doc emacs sudo"

S="${WORKDIR}"/${PN}-${MY_PV}

MAKEOPTS+=" -j1"

src_configure() {
	econf \
		$(use_enable doc) \
		$(use_enable doc doc-info) \
		$(use_enable doc doc-html) \
		$(use_enable doc doc-pdf) \
		$(use_enable doc doc-dvi) \
		$(use_enable doc doc-ps) \
		$(use_enable emacs sendmail) \
		$(use_enable sudo use-sudo)
}
