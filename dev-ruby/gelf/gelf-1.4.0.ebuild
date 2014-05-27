# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

USE_RUBY="ruby19 ruby20"

inherit ruby-fakegem

DESCRIPTION="Ruby GELF library (Graylog2 Extended Log Format)"
HOMEPAGE="https://github.com/Graylog2/gelf-rb http://www.graylog2.org/"
SRC_URI="https://github.com/Graylog2/gelf-rb/archive/v${PV}.tar.gz -> ${P}.tar.gz"
LICENSE="BSD"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RUBY_S="${PN}-rb-${PV}"