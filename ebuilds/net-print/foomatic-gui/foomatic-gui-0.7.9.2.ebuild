# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-print/foomatic-gui/foomatic-gui-0.7.5.ebuild,v 1.3 2006/06/13 14:53:11 gustavoz Exp $

inherit distutils

DESCRIPTION="GNOME interface for configuring the Foomatic printer filter system"
HOMEPAGE="http://freshmeat.net/projects/foomatic-gui/"
SRC_URI="mirror://debian/pool/main/f/${PN}/${PN}_${PV}.tar.gz"
LICENSE="GPL-2"
SLOT=0
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE=""

RDEPEND=">=dev-lang/python-2.2.2
	>=dev-python/gnome-python-extras-2.10.0
	>=dev-python/pyxml-0.8
	dev-python/ipy
	net-print/foomatic-db-engine"

S=${WORKDIR}/${PN}.dist
