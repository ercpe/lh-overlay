# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

USE_RUBY="ruby19 ruby20 ruby21 jruby"
RUBY_FAKEGEM_RECIPE_DOC="rdoc"
RUBY_FAKEGEM_RECIPE_TEST="rspec"

inherit ruby-fakegem

DESCRIPTION="A Ruby command-line application framework"
HOMEPAGE="https://github.com/mdub/clamp"
SRC_URI="https://github.com/mdub/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
LICENSE="BSD"

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
