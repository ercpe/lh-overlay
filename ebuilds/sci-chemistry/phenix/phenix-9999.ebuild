# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit check-reqs

MY_P="phenix-installer-1.3b"

SLOT="0"
LICENSE="phenix"
KEYWORDS="~x86 ~amd64"
DESCRIPTION="Python-based Hierarchical ENvironment for Integrated Xtallography"
SRC_URI="x86? ( ${MY_P}-rc6-intel-linux-2.6.tar )
		 amd64? ( ${MY_P}-rc6-intel-linux-2.6-x86_64.tar )"
HOMEPAGE="http://www.phenix-online.org/"
IUSE=""
RESTRICT="fetch"

pkg_nofetch(){
	einfo "Register here and get a valid download paswort"
	einfo "http://www.phenix-online.org/phenix_request"
	einfo "and place ${A} in ${DISTDIR}"
}
src_compile(){
	echo hello world
	cd ${MY_P}
	./install --source --nproc=2 --debug --force-compile --prefix="${D}"/usr/lib/phenix/
}