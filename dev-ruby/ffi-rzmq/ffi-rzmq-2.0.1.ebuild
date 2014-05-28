# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

USE_RUBY="ruby19 ruby20"
RUBY_FAKEGEM_RECIPE_DOC=""
RUBY_FAKEGEM_RECIPE_TEST=""

inherit ruby-fakegem

DESCRIPTION="FFI bindings for ZeroMQ so the library can be used under JRuby and other FFI-compliant ruby runtimes"
HOMEPAGE="https://github.com/chuckremes/ffi-rzmq"
SRC_URI="https://github.com/chuckremes/${PN}/archive/release-${PV}.tar.gz -> ${P}.tar.gz"
LICENSE="MIT"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RUBY_S="${PN}-release-${PV}"

ruby_add_rdepend "dev-ruby/ffi-rzmq-core"
