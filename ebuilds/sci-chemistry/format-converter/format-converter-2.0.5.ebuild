# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

# inherit

DESCRIPTION="The CCPN external data format conversion program"
HOMEPAGE="http://www.ccpn.ac.uk/ccpn/software/ccpnmr-formatconverter/"
SRC_URI="http://www.bio.cam.ac.uk/ccpn/download/ccpnmr/format2.0.4.tar.gz"

LICENSE="LGPL-2"

SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE=""
RDEPEND="!sci-chemistry/ccpn"
DEPEND="${RDEPEND}"

S="${WORKDIR}"/ccpnmr
