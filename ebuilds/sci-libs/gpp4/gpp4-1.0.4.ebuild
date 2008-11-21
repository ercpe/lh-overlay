# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

# inherit

DESCRIPTION="The ggp4 library is a special version of the CCP4 library"
HOMEPAGE="http://www.bioxray.dk/~mok/gpp4.php"
SRC_URI="ftp://ftp.bioxray.au.dk/pub/mok/src/gpp4-1.0.4.tar.gz"

LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE=""
RDEPEND=""
DEPEND="${RDEPEND}"


src_install(){

	emake DESTDIR="${D}" install || \
	die

}
