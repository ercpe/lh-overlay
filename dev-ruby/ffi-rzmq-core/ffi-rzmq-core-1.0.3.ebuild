# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

USE_RUBY="ruby19"

inherit ruby-fakegem

DESCRIPTION="FFI wrapper around the zeromq libzmq API. Utilized by other libraries to provide more Ruby-like API"
HOMEPAGE="https://github.com/chuckremes/ffi-rzmq-core"
SRC_URI="https://github.com/chuckremes/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"
LICENSE="Apache-2.0"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

ruby_add_rdepend ">=dev-ruby/ffi-1.9"
