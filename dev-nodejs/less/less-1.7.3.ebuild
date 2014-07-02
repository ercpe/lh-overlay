# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit npm

DESCRIPTION="CSS pre-processor"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc"

DEPEND=">=net-libs/nodejs-0.8.10"
RDEPEND="${DEPEND}"

NPM_DOCS="LICENSE CNAME CONTRIBUTING.md"

src_install() {
	npm_src_install

	dobin bin/*
}
