# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

USE_RUBY="ruby19"

inherit ruby-fakegem

DESCRIPTION="A Ruby command-line application framework"
HOMEPAGE="https://github.com/mdub/clamp"
SRC_URI="https://github.com/mdub/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
LICENSE="BSD"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="${DEPEND}"
