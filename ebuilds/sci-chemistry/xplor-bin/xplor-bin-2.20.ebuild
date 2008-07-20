# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils python

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

pkg_setup(){
	if use x86; then
		MY_VER="Linux_2.4_i686"
	else
		MY_VER="Linux_2.6_x86_64"
	fi
}
src_compile(){
	einfo "Nothing to compile, it's binary!"
}

src_install(){
#	einfo "Running /bin/sh configure"
#	/bin/sh configure

	einfo "Correcting PATH"
	local scriptFiles="xplor testDist seq2psf pdb2psf pyXplor tclXplor xplor_mpi\
					   targetRMSD calcTensor calcDaRh calcETensor domainDecompose mleFit"

	exeinto /opt/${PN}/bin
	for binFile in $scriptFiles; do
		sed "s:__XPLOR_DIR__:/opt/${PN}/:g" -i bin/${binFile}.in
		newexe bin/${binFile}.in ${binFile}
	done
	doexe bin/{echo,findXcookie,mkdirhier}

	exeinto /opt/${PN}/bin."${MY_VER}"
	doexe bin."${MY_VER}"/*


	insinto /opt/${PN}/
	doins -r arch databases dataconversion helplib nmrlib python tcl test toppar xtal_info xtallib

	insinto /usr/share/${P}/
	doins -r eginput tutorial

	dodoc Changes README* References

#	for binFile in $scriptFiles; do
#		fperms 775 /opt/${PN}/bin/${binFile}
#	done

	#str=$(/bin/sh ./bin/xplor -sh-env)


#	if [ $? -eq 0 ]; then
#		die #eval $str
#	else
#		die "/bin/xplor -sh-env failed"
#	fi

}

pkg_postinst(){
	python_mod_optimize /opt/${PN}/bin.Linux_2.4_i686
	python_mod_optimize /opt/${PN}/python
}
