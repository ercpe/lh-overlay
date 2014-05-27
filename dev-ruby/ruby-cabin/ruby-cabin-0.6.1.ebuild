# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

USE_RUBY="ruby19"

inherit ruby-fakegem

DESCRIPTION="Library for structured and contextual loggin"
HOMEPAGE="https://github.com/jordansissel/ruby-cabin"
SRC_URI="http://dev.gentoo.org/~ercpe/distfiles/${CATEGORY}/${PN}/${P}.tar.bz2"
LICENSE="Apache-2.0"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
