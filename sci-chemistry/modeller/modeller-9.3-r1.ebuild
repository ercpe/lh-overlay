# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils python

LICENSE="free of charge to academic non-profit"
KEYWORDS="x86"
DESCRIPTION="MODELLER is used for homology or comparative modeling of protein three-dimensional structures"
SRC_URI="http://salilab.org/modeller/9v3/modeller-9v3.tar.gz"
HOMEPAGE="http://salilab.org/modeller/"
IUSE=""
RESTRICT="mirror"
SLOT="0"

RDEPEND="${DEPEND}"
DEPEND=">=dev-lang/python-2.4"


src_install(){
	python_version
	
	VER=9v3
	EXECUTABLE_TYPE=i386-intel8
	IN_PATH=/usr/lib/modeller${VER}
	
	sed -e "s;EXECUTABLE_TYPE${VER}=xxx;EXECUTABLE_TYPE${VER}=$EXECUTABLE_TYPE;" \
    -e "s;MODINSTALL${VER}=xxx;MODINSTALL${VER}=\"${IN_PATH}\";" \
    modeller-${VER}/bin/modscript > "${T}/mod${VER}"
    exeinto ${IN_PATH}/bin/
    doexe "${T}/mod${VER}"
    dosym ${IN_PATH}/bin/mod${VER} /usr/bin/mod${VER}
    
    sed -e "s;@TOPDIR\@;\"${IN_PATH}\";" \
    -e "s;@EXETYPE\@;$EXECUTABLE_TYPE;" \
    modeller-${VER}/bin/modpy.sh.in > "${T}/modpy.sh"
    doexe "${T}/modpy.sh"

	insinto ${IN_PATH}/bin/
	doins -r modeller-${VER}/bin/{*top,modscript,lib,mod${VER}_i386-intel8}
	exeinto ${IN_PATH}/bin/
	doexe modeller-${VER}/bin/{modpy.sh.in,modslave.py,mod${VER}_i386-intel8}
	
	exeinto /usr/lib/python${PYVER}/site-packages/
	doexe modeller-${VER}/lib/i386-intel8/_modeller.so
	dosym ${IN_PATH}/modlib/modeller /usr/lib/python${PYVER}/site-packages/modeller 
	dosym ${IN_PATH}/lib/i386-intel8/_modeller.so\
		  /usr/lib/python${PYVER}/site-packages/_modeller.so
	
	exeinto ${IN_PATH}/lib/i386-intel8/
	doexe modeller-${VER}/lib/i386-intel8/{lib*,_modeller.so}
	exeinto ${IN_PATH}/lib/i386-intel8/python${PYVER}/
	doexe modeller-${VER}/lib/i386-intel8/python2.5/_modeller.so
	dosym ${IN_PATH}/lib/i386-intel8/libmodeller.so.1 \
		  ${IN_PATH}/lib/i386-intel8/libmodeller.so
	
	insinto ${IN_PATH}/modlib/
	doins -r modeller-${VER}/modlib/{*mat,*lib,*prob,*mdt,*bin,*de,*inp,*ini,modeller}

	insinto ${IN_PATH}/
	doins -r modeller-${VER}/src
	
	insinto /usr/share/${PN}/
	doins -r modeller-${VER}/examples
	dohtml modeller-${VER}/doc/*
	dodoc modeller-${VER}/{README,ChangeLog}
	
	cat >> "${T}/config.py" << EOF
install_dir = "${IN_PATH}/"
license = "YOURLICENSEKEY"
EOF

	insinto ${IN_PATH}/modlib/modeller/
	doins "${T}/config.py"
}

pkg_postinst(){
	#Adapted from BUG #127628
	einfo ""
	einfo " If you need to define your own residues"
	einfo " read the FAQ and edit the following files:"
	einfo ""
	einfo "    ${MY_D}/modlib/top_heav.lib"
	einfo "    ${MY_D}/modlib/radii.lib"
	einfo "    ${MY_D}/modlib/radii14.lib"
	einfo "    ${MY_D}/modlib/restyp.lib"
	einfo ""
	einfo "    Good Luck and Happy Modeling :D"
	einfo ""
	echo
	echo
	ewarn "Obtain a license Key from"
	ewarn "http://salilab.org/modeller/registration.html"
	ewarn "and change the adequate line in"
	ewarn "${IN_PATH}/modlib/modeller/config.py"
}