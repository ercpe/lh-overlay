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


src_install(){
	python_version
	VER=9v2
	EXECUTABLE_TYPE=i386-intel8
	
	sed -e "s;EXECUTABLE_TYPE${VER}=xxx;EXECUTABLE_TYPE${VER}=$EXECUTABLE_TYPE;" \
    -e "s;MODINSTALL${VER}=xxx;MODINSTALL${VER}=\"/usr/lib/modeller${VER}\";" \
    modeller-9v2/bin/modscript > "${T}/mod9v2"
    exeinto /usr/lib/modeller9v2/bin/
    doexe "${T}/mod9v2"
    dosym /usr/lib/modeller9v2/bin/mod9v2 /usr/bin/mod9v2
    
    sed -e "s;@TOPDIR\@;\"/usr/lib/modeller${VER}\";" \
    -e "s;@EXETYPE\@;$EXECUTABLE_TYPE;" \
    modeller-9v2/bin/modpy.sh.in > "${T}/modpy.sh"
    doexe "${T}/modpy.sh"

	insinto /usr/lib/modeller9v2/bin/
	doins -r modeller-9v2/bin/{*top,modscript,lib,mod9v2_i386-intel8}
	exeinto /usr/lib/modeller9v2/bin/
	doexe modeller-9v2/bin/{modpy.sh.in,modslave.py,mod9v2_i386-intel8}
	
	exeinto /usr/lib/python${PYVER}/site-packages/
	doexe modeller-9v2/lib/i386-intel8/_modeller.so
	dosym /usr/lib/python2.5/site-packages/modeller /usr/lib/modeller9v2/modlib/modeller
	
	exeinto /usr/lib/modeller9v2/lib/i386-intel8/
	doexe modeller-9v2/lib/i386-intel8/{lib*,_modeller.so}
	exeinto /usr/lib/modeller9v2/lib/i386-intel8/python${PYVER}/
	doexe modeller-9v2/lib/i386-intel8/python2.5/_modeller.so
	dosym /usr/lib/modeller9v2/lib/i386-intel8/libmodeller.so.1 \
		  /usr/lib/modeller9v2/lib/i386-intel8/libmodeller.so
	insinto /usr/lib/modeller9v2/lib/i386-intel8/modlib/
	doins -r modeller-9v2/modlib/{*mat,*lib,*prob,*mdt,*bin,*de,*inp,*ini,modeller}
	insinto /usr/lib/modeller9v2/lib/
	doins -r modeller-9v2/src
	
	insinto /usr/share/doc/${PF}/
	doins -r modeller-9v2/examples
	dohtml modeller-9v2/doc/*
	dodoc modeller-9v2/{README,ChangeLog}
	
	echo 
	echo
	echo "License key, obtained from our academic license server at"
	echo "http://salilab.org/modeller/registration.html: "
	#read KEY_MODELLER
	
cat >> "${T}/config.py" << EOF
install_dir = /usr/lib/modeller9v2/
license = "${KEY_MODELLER}"
EOF
	insinto /usr/lib/python${PYVER}/site-packages/modeller
	doins "${T}/config.py"
}