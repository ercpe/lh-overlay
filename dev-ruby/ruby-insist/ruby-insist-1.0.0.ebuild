# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

USE_RUBY="ruby19 ruby20 jruby"
RUBY_FAKEGEM_RECIPE_DOC="rdoc"
RUBY_FAKEGEM_RECIPE_TEST="rspec"

inherit ruby-fakegem

DESCRIPTION="A simple block-driven assertion library for both testing and for production code"
HOMEPAGE="https://github.com/jordansissel/ruby-insist"
SRC_URI="http://dev.gentoo.org/~ercpe/distfiles/${CATEGORY}/${PN}/${P}.tar.bz2"
LICENSE="Apache-2.0"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

each_fakegem_test() {
	[[ ${RUBY} != *ruby20 ]] && ruby-ng_rspec
}