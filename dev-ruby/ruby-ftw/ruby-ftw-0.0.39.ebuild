# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

USE_RUBY="ruby19"
RUBY_FAKEGEM_RECIPE_DOC="rdoc"
RUBY_FAKEGEM_RECIPE_TEST="none"

inherit ruby-fakegem

DESCRIPTION="Ruby FTW - For The Web. Experimentation in web clients and servers."
HOMEPAGE="https://github.com/jordansissel/ruby-ftw/"
SRC_URI="http://dev.gentoo.org/~ercpe/distfiles/${CATEGORY}/${PN}/${P}.tar.bz2"
LICENSE="Apache-2.0"

SLOT="0"
KEYWORDS="~amd64" # ~x86 missing due to http_parser_rb
IUSE=""

ruby_add_rdepend "dev-ruby/addressable dev-ruby/http_parser_rb"