# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

# python 3+ requires dnspython with py3 support, see #484954
# PYTHON_COMPAT=( python2_7,3_2,3_3 )
PYTHON_COMPAT=( python2_7 )

inherit distutils-r1

DESCRIPTION="Python module for retrieving and parsing whois data for IPv4 and IPv6 addresses"
HOMEPAGE="https://github.com/secynic/ipwhois"
SRC_URI="https://github.com/secynic/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE=""

RESTRICT="test" # network-heavy test which provably fail in restricted environments

RDEPEND="dev-python/dnspython[${PYTHON_USEDEP}]
	dev-python/ipaddr[${PYTHON_USEDEP}]"
