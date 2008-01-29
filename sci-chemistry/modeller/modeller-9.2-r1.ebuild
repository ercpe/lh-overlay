# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils python

SLOT=""
LICENSE="free of charge to academic non-profit"
KEYWORDS="x86"
DESCRIPTION="MODELLER is used for homology or comparative modeling of protein three-dimensional structures"
SRC_URI="http://salilab.org/modeller/9v2/modeller-9v2.tar.gz"
HOMEPAGE="http://salilab.org/modeller/"
IUSE=""
RESTRICT="mirror"

RDEPEND="${DEPEND}"
DEPEND=">=dev-lang/python-2.4"


src_compile(){
	cd modeller-9v2/src/swig
	swig -python -keyword -nodefaultctor -nodefaultdtor -noproxy modeller.i
	python setup.py -L ../../lib/i386-intel8 -I ../include/i386-intel8 build
}