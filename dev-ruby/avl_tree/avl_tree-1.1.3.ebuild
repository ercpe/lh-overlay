# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

USE_RUBY="ruby19 ruby20 jruby"
RUBY_FAKEGEM_RECIPE_DOC="rdoc"

inherit ruby-fakegem

DESCRIPTION="AVL tree and Red-black tree in Ruby"
HOMEPAGE="https://github.com/nahi/avl_tree"
SRC_URI="https://github.com/nahi/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
LICENSE="Ruby"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

each_ruby_test() {
	${RUBY} -I lib test/test_{red_black,avl}_tree.rb || die
}
