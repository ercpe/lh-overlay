# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

USE_RUBY="ruby19 ruby20 jruby"
RUBY_FAKEGEM_RECIPE_DOC="rdoc"
RUBY_FAKEGEM_RECIPE_TEST=""

inherit ruby-fakegem

DESCRIPTION="An experimental library to instrument ruby"
HOMEPAGE="https://github.com/eric/metriks"
SRC_URI="https://github.com/eric/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
LICENSE="MIT"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
