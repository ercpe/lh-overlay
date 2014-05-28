# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

USE_RUBY="ruby19 ruby20 jruby"
RUBY_FAKEGEM_RECIPE_DOC="rdoc"
RUBY_FAKEGEM_RECIPE_TEST=""

inherit ruby-fakegem

DESCRIPTION="Library for structured and contextual loggin"
HOMEPAGE="https://github.com/jordansissel/ruby-cabin"
SRC_URI="http://dev.gentoo.org/~ercpe/distfiles/${CATEGORY}/${PN}/${P}.tar.bz2"
LICENSE="Apache-2.0"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="examples"

all_ruby_install() {
	all_fakegem_install

	if use examples; then
		insinto /usr/share/doc/${PF}/examples
		doins examples/* || die
	fi
}
