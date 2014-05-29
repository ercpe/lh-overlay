# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

USE_RUBY="ruby19 ruby20"
RUBY_FAKEGEM_RECIPE_DOC="rdoc"
RUBY_FAKEGEM_RECIPE_TEST=""
RUBY_FAKEGEM_EXTRAINSTALL="patterns"

inherit ruby-fakegem

DESCRIPTION="Pure-ruby implementation of grok"
HOMEPAGE="https://github.com/jordansissel/ruby-grok"
SRC_URI="https://github.com/jordansissel/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
LICENSE="Apache-2.0"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-libs/grok"

each_ruby_test() {
	${RUBY} test/pure-ruby/alltests.rb || die "Test failed with ${RUBY}"
}