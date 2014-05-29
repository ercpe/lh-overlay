# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

USE_RUBY="ruby19 ruby20 jruby"
RUBY_FAKEGEM_RECIPE_DOC="rdoc"
RUBY_FAKEGEM_RECIPE_TEST=""
RUBY_FAKEGEM_EXTRAINSTALL="data"

inherit ruby-fakegem

DESCRIPTION="Ruby gem for querying Maxmind.com's GeoIP database"
HOMEPAGE="http://geoip.rubyforge.org/ https://github.com/cjheath/geoip"
SRC_URI="https://github.com/cjheath/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
LICENSE="LGPL-2.1"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

ruby_add_bdepend "test? ( dev-ruby/test-unit )"

each_ruby_test() {
	ruby-ng_testrb-2 test/*.rb
}