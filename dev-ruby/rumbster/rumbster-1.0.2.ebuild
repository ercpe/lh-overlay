# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

USE_RUBY="ruby19 ruby20" # jruby is missing on dev-ruby/mail
RUBY_FAKEGEM_RECIPE_DOC="rdoc"
RUBY_FAKEGEM_RECIPE_TEST=""

inherit ruby-fakegem

DESCRIPTION="Fake smtp server for email testing in Ruby"
HOMEPAGE="https://github.com/aesterline/rumbster"
SRC_URI="https://github.com/aesterline/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
LICENSE="Apache-2.0"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

ruby_add_bdepend ">=dev-ruby/mail-2.5.3"

# broken test case in test/test_message_observers.rb
# And it randomly failes to execute the tests due to port 10025 stuck in TIME_WAIT
#each_ruby_test() {
#	ruby-ng_testrb-2 test/*.rb
#}