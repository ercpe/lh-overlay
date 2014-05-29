# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

USE_RUBY="ruby19 ruby20 jruby"
RUBY_FAKEGEM_RECIPE_DOC="rdoc"

inherit ruby-fakegem

DESCRIPTION="A Ruby gem for parsing user agent strings with the help of BrowserScope's UA database"
HOMEPAGE="https://github.com/toolmantim/user_agent_parser"
SRC_URI="https://github.com/toolmantim/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
LICENSE="MIT"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="app-misc/ua-parser"

each_ruby_prepare() {
	rm -r vendor/ua-parser || die
	ln -s /usr/share/ua-parser vendor/ua-parser || die
}

each_ruby_test() {
	[[ "${RUBY}" == *ruby19* ]] || continue
	each_fakegem_test
}

each_ruby_install() {
	dosym /usr/share/ua-parser $(ruby_fakegem_gemsdir)/gems/${P}/vendor/ua-parser
	each_fakegem_install
}