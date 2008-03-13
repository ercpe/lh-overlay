# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit python

SLOT="0"
LICENSE="mgltools"
KEYWORDS="~x86"
DESCRIPTION="MGLTools is a software for visualization and analysis of molecular structures"
#SRC_URI="http://mgltools.scripps.edu/downloads/tars/releases/REL${PV}/${PN}_source_${PV}.tar.gz"
SRC_URI="http://mgltools.scripps.edu/downloads/tars/releases/REL1.5.0/${PN}_source_1.5.0.tar.gz"
HOMEPAGE="http://mgltools.scripps.edu/"
IUSE=""
RESTRICT="mirror"
DEPEND=">=dev-lang/python-2.4
		>=dev-lang/tk-8.4
		>=dev-lang/tcl-8.4
		>=dev-lang/swig-1.3.31
		virtual/glut
		"