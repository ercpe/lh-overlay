# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils

DESCRIPTION="XPLOR-NIH is a structure determination program which builds on the X-PLOR program"
SRC_URI="x86? ( xplor-nih-${PV}-Linux_2.4_i686.tar.gz )
		 amd64? ( xplor-nih-${PV}-Linux_2.6_x86_64.tar.gz )
		 xplor-nih-${PV}-db.tar.gz"
HOMEPAGE="http://nmr.cit.nih.gov/xplor-nih/"
RESTRICT="fetch"
LICENSE="xplor"
SLOT="0"
KEYWORDS="-* ~x86 ~amd64"
IUSE=""
RDEPEND="X? ( x11-libs/libXdmcp
			  x11-libs/libXau
			  x11-libs/libX11 )"
DEPEND=""

S="${WORKDIR}"/xplor-nih-${PV}

src_compile(){
	einfo "Nothing to compile, it's binary!"
}

src_install(){
	local scriptFiles="xplor testDist seq2psf pdb2psf pyXplor tclXplor xplor_mpi\
					   targetRMSD calcTensor calcDaRh calcETensor domainDecompose mleFit"

	for binFile in $scriptFiles; do
		sed "s:__XPLOR_DIR__:/opt/xplor/:g" <bin/${binFile}.in > bin/${binFile}
	done

	insinto /opt/${PN}/
	doins -r *
	
	for binFile in $scriptFiles; do
		fperms 775 /opt/${PN}/bin/${binFile}
	done
	
	str=`./bin/xplor -sh-env`
for var in $exported; do
	    cmd="echo \$$var"
	    echo "$var=\""`eval $cmd`\"\;
	    echo "export $var"\;
	if [ $? -eq 0 ]; then
		eval $str
	else
		die "/bin/xplor -sh-env failed"
	fi
}

pkg_postinst(){
	python_mod_optimize /opt/${PN}/
}