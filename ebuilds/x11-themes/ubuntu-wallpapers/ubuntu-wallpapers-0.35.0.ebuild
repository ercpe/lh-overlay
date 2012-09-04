# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit distutils

DESCRIPTION="Ubuntu community wallpapers"
HOMEPAGE="https://launchpad.net/ubuntu/quantal/+source/ubuntu-wallpapers"
SRC_URI="https://launchpad.net/ubuntu/quantal/+source/${PN}/${PV}/+files/${PN}_${PV}.tar.gz"

SLOT="0"
LICENSE="CCPL-Attribution-ShareAlike-3.0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE=""
