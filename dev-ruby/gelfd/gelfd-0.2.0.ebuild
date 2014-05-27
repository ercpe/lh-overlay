# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

USE_RUBY="ruby19 ruby20"

inherit ruby-fakegem

DESCRIPTION="A standalone server + library for handling GELF messages"
HOMEPAGE="https://github.com/lusis/gelfd"
SRC_URI="https://github.com/lusis/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
LICENSE="Apache-2.0"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
