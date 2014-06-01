# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

USE_RUBY="ruby19 ruby20 jruby"
RUBY_FAKEGEM_RECIPE_DOC="rdoc"
RUBY_S="${PN}-ruby-${PV}"

inherit ruby-fakegem

DESCRIPTION="Ruby implementation of noncriptographic hash Murmur3 (both native and pure ruby)"
HOMEPAGE="https://github.com/funny-falcon/"
SRC_URI="https://github.com/funny-falcon/${PN}-ruby/archive/v${PV}.tar.gz -> ${P}.tar.gz"
LICENSE="MIT"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

ruby_add_bdepend "test? ( dev-ruby/test-unit dev-ruby/minitest )"

each_ruby_configure() {
	${RUBY} -Cext/${PN/-ruby} extconf.rb || die
}

each_ruby_compile() {
	[[ "${RUBY}" == *jruby* ]] && return
	emake -Cext/${PN/-ruby} CFLAGS="${CFLAGS} -fPIC" archflag="${LDFLAGS}" V=1
	cp ext/${PN/-ruby}/*$(get_modname) lib/murmurhash3 || die
}

each_ruby_test() {
	[[ "${RUBY}" == *ruby19* ]] || return
	each_fakegem_test
}
