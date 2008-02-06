# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils python

SLOT=""
LICENSE="free of charge to academic non-profit"
KEYWORDS="x86"
DESCRIPTION="MODELLER is used for homology or comparative modeling of protein three-dimensional structures"
SRC_URI="http://salilab.org/modeller/9v3/modeller-9v3.tar.gz"
HOMEPAGE="http://salilab.org/modeller/"
IUSE=""
RESTRICT="mirror"

RDEPEND="${DEPEND}"
DEPEND=">=dev-lang/python-2.4"


src_install(){
	python_version
	
	VER=9v3
	EXECUTABLE_TYPE=i386-intel8
	
	sed -e "s;EXECUTABLE_TYPE${VER}=xxx;EXECUTABLE_TYPE${VER}=$EXECUTABLE_TYPE;" \
    -e "s;MODINSTALL${VER}=xxx;MODINSTALL${VER}=\"/usr/lib/modeller${VER}\";" \
    modeller-${VER}/bin/modscript > "${T}/mod${VER}"
    exeinto /usr/lib/modeller${VER}/bin/
    doexe "${T}/mod${VER}"
    dosym /usr/lib/modeller${VER}/bin/mod${VER} /usr/bin/mod${VER}
    
    sed -e "s;@TOPDIR\@;\"/usr/lib/modeller${VER}\";" \
    -e "s;@EXETYPE\@;$EXECUTABLE_TYPE;" \
    modeller-${VER}/bin/modpy.sh.in > "${T}/modpy.sh"
    doexe "${T}/modpy.sh"

	insinto /usr/lib/modeller${VER}/bin/
	doins -r modeller-${VER}/bin/{*top,modscript,lib,mod${VER}_i386-intel8}
	exeinto /usr/lib/modeller${VER}/bin/
	doexe modeller-${VER}/bin/{modpy.sh.in,modslave.py,mod${VER}_i386-intel8}
	
	exeinto /usr/lib/python${PYVER}/site-packages/
	doexe modeller-${VER}/lib/i386-intel8/_modeller.so
	dosym /usr/lib/modeller${VER}/modlib/modeller /usr/lib/python${PYVER}/site-packages/modeller 
	dosym /usr/lib/modeller${VER}/lib/i386-intel8/_modeller.so\
		  /usr/lib/python${PYVER}/site-packages/_modeller.so
	
	exeinto /usr/lib/modeller${VER}/lib/i386-intel8/
	doexe modeller-${VER}/lib/i386-intel8/{lib*,_modeller.so}
	exeinto /usr/lib/modeller${VER}/lib/i386-intel8/python${PYVER}/
	doexe modeller-${VER}/lib/i386-intel8/python2.5/_modeller.so
	dosym /usr/lib/modeller${VER}/lib/i386-intel8/libmodeller.so.1 \
		  /usr/lib/modeller${VER}/lib/i386-intel8/libmodeller.so
	
	insinto /usr/lib/modeller${VER}/modlib/
	doins -r modeller-${VER}/modlib/{*mat,*lib,*prob,*mdt,*bin,*de,*inp,*ini,modeller}

	insinto /usr/lib/modeller${VER}/
	doins -r modeller-${VER}/src
	
	insinto /usr/share/${PN}/
	doins -r modeller-${VER}/examples
	dohtml modeller-${VER}/doc/*
	dodoc modeller-${VER}/{README,ChangeLog}
	
	cat >> "${T}/config.py" << EOF
install_dir = "/usr/lib/modeller${VER}/"
license = YOURLICENSEKEY
EOF

	insinto /usr/lib/modeller${VER}/modlib/modeller/
	doins "${T}/config.py"
}

pkg_postinst(){
	ewarn ""
	ewarn " If you need to define your own residues"
	ewarn " read the FAQ and edit the following files:"
	ewarn ""
	ewarn "    ${MY_D}/modlib/top_heav.lib"
	ewarn "    ${MY_D}/modlib/radii.lib"
	ewarn "    ${MY_D}/modlib/radii14.lib"
	ewarn "    ${MY_D}/modlib/restyp.lib"
	ewarn ""
	ewarn "    Good Luck and Happy Modeling :D"
	ewarn ""
	

	einfo "Obtain a license Key from"
	einfo "http://salilab.org/modeller/registration.html"
	einfo "and change the adequate line in"
	einfo "/usr/lib/modeller${VER}/modlib/modeller/config.py"
}