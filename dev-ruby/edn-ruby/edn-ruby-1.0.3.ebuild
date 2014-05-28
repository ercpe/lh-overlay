# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

USE_RUBY="ruby19 ruby20"
RUBY_FAKEGEM_RECIPE_DOC="rdoc"
RUBY_FAKEGEM_RECIPE_TEST=""

inherit ruby-fakegem

DESCRIPTION="Ruby implementation of Extensible Data Notation as defined by Rich Hickey"
HOMEPAGE="https://github.com/relevance/edn-ruby"
SRC_URI="https://github.com/relevance/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
LICENSE="MIT"

SLOT="0"
KEYWORDS="~amd64" # no ~x86 due to parslet
IUSE=""

ruby_add_rdepend "dev-ruby/parslet"