# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils toolchain-funcs python check-reqs

SLOT=""
LICENSE="CCPN license"
KEYWORDS="~x86"
DESCRIPTION="The Collaborative Computing Project for NMR is a public non-profit project serving the macromolecular NMR community"
SRC_URI="ftp://www.bio.cam.ac.uk/pub/ccpnmr/analysis1.0.15.tar.gz
		 examples? ( ftp://www.bio.cam.ac.uk/pub/ccpnmr/analysisTutorialData.tar.gz )"
HOMEPAGE="http://www.ccpn.ac.uk/ccpn"
IUSE="examples"
RESTRICT="mirror"
DEPEND="${RDEPEND}"
RDEPEND=">=dev-lang/python-2.4
		  virtual/glut
		  >=dev-lang/tcl-8.3
		  >=dev-lang/tk-8.3
		  dev-tcltk/tix
		  x11-apps/mesa-progs"

pkg_setup(){
	if use examples; then
	ewarn "The examples are about 523MB large."
	ewarn "Be sure you have enough space free!"
	epause 5
	CHECKREQS_DISK_USR="1024"
	CHECKREQS_DISK_VAR="1024"
	check_reqs
	fi
}

src_unpack(){
	unpack ${A}
	#epatch "${FILESDIR}/gentoo-CCPNPYTHONPATH.patch"
}

src_compile(){
	python_version
	cd ccpnmr/ccpnmr1.0/c
	
	echo "CC = "$(tc-getCC)>environment.txt

#This could be outsourced to the file dir
cat >> environment.txt << EOF
MALLOC_FLAG = -DDO_NOT_HAVE_MALLOC
FPIC_FLAG = -fPIC
XOR_FLAG = 
IGNORE_GL_FLAG = 
GL_FLAG = -DUSE_GL_FALSE
GLUT_NEED_INIT = -DNEED_GLUT_INIT
GLUT_NOT_IN_GL = 
GLUT_FLAG = \$(GLUT_NEED_INIT) \$(GLUT_NOT_IN_GL)
SHARED_FLAGS = -shared
MATH_LIB = -lm
X11_DIR = /usr/
X11_LIB = -lX11 -lXext
X11_INCLUDE_FLAGS = -I\$(X11_DIR)/include
X11_LIB_FLAGS = -L\$(X11_DIR)/lib
TCL_DIR = /usr
TCL_LIB = -ltcl8.4
TCL_INCLUDE_FLAGS = -I\$(TCL_DIR)/include
TCL_LIB_FLAGS = -L\$(TCL_DIR)/lib
TK_DIR = /usr
TK_LIB = -ltk8.4
TK_INCLUDE_FLAGS = -I\$(TK_DIR)/include
TK_LIB_FLAGS = -L\$(TK_DIR)/lib
PYTHON_DIR = /usr
PYTHON_INCLUDE_FLAGS = -I\$(PYTHON_DIR)/include/python${PYVER}
GL_DIR = /usr
GL_LIB = -lglut -lGLU -lGL
GL_INCLUDE_FLAGS = -I\$(GL_DIR)/include 
GL_LIB_FLAGS = -L\$(GL_DIR)/lib 
EOF
	echo "CFLAGS = "$CFLAGS" \$(MALLOC_FLAG) \$(FPIC_FLAG) \$(XOR_FLAG)">>environment.txt

	
	emake -j1
	emake -j1 links
}

src_install(){
	python_version
	
	IN_PATH=/usr/lib/python${PYVER}/site-packages/ccpnmr
	
	einfo "Creating launch wrapper"
#doesnt work with env.d, because portage uses the PYTHONPATH variable 
#and I couldn't manage renaming the variable inside ccpnmr correctly
# to CCPNPYTHONPATH. CCPNMR always breaks.

#cat >> "${T}"/20ccpnmr << EOF
#CCPNMR_TOP_DIR=${IN_PATH}
#PYTHONPATH=${IN_PATH}/ccpnmr1.0/python
#LD_LIBRARY_PATH=/usr/lib
#TCL_LIBRARY=/usr/lib/tcl8.4
#TK_LIBRARY=/usr/lib/tk8.4
#EOF
	
#	doenvd "${T}"/20ccpnmr || die "Failed to install env.d."

cat >> "${T}"/base << EOF
#!/bin/sh
export CCPNMR_TOP_DIR=${IN_PATH}
export PYTHONPATH=${IN_PATH}/ccpnmr1.0/python
export LD_LIBRARY_PATH=/usr/lib
export TCL_LIBRARY=/usr/lib/tcl8.4
export TK_LIBRARY=/usr/lib/tk8.4
EOF

	cat "${T}"/base > "${T}"/analysis
	echo "${python} -O -i \${CCPNMR_TOP_DIR}/ccpnmr1.0/python/ccpnmr/analysis/AnalysisGui.py \$1 \$2 \$3 \$4 \$5" >> "${T}"/analysis

	cat "${T}"/base > "${T}"/dataShifter
	echo "${python} -O \${PYTHONPATH}/ccpnmr/format/gui/DataShifter.py" >> "${T}"/dataShifter

	cat "${T}"/base > "${T}"/formatConverter
	echo "${python} -O \${PYTHONPATH}/ccpnmr/format/gui/FormatConverter.py \$1 \$2" >> "${T}"/formatConverter

	cat "${T}"/base > "${T}"/pipe2azara
	echo "${python} -O \${PYTHONPATH}/ccpnmr/analysis/NmrPipeData.py \$1 \$2 \$3" >> "${T}"/pipe2azara

#Perhaps the two Update wrapper shouldn't be.
	cat "${T}"/base > "${T}"/updateAll
	echo "${python} -O \${PYTHONPATH}/ccpnmr/update/UpdateAuto.py" >> "${T}"/updateAll

	cat "${T}"/base > "${T}"/updateCheck
	echo "${python} -O \${PYTHONPATH}/ccpnmr/update/UpdatePopup.py" >> "${T}"/updateCheck

	einfo "Installing wrapper"
	exeinto ${IN_PATH}/bin
#	doexe "${T}/{analysis,dataShifter,formatConverter,pipe2azara,updateAll,updateCheck}"
	doexe "${T}"/analysis || die "Failed to install wrapper."
	doexe "${T}"/dataShifter || die "Failed to install wrapper."
	doexe "${T}"/formatConverter || die "Failed to install wrapper."
	doexe "${T}"/pipe2azara || die "Failed to install wrapper."
	doexe "${T}"/updateAll || die "Failed to install wrapper."
	doexe "${T}"/updateCheck || die "Failed to install wrapper."
	
	for i in analysis dataShifter formatConverter pipe2azara
		do
			dosym ${IN_PATH}/bin/$i /usr/bin/$i
		done
	
	insinto ${IN_PATH}
	cd ccpnmr
	
	einfo "Installing main files"
	doins -r *
	

	einfo "Adjusting permissions"
#I do not know wether this is a must or not, but thats how the original install looks like
	local FILES="c/ccp/structure/StructUtil.so
				 c/ccp/structure/StructAtom.so
				 c/ccp/structure/StructBond.so
				 c/ccp/structure/StructStructure.so
				 c/ccpnmr/clouds/Midge.so
				 c/ccpnmr/clouds/Dynamics.so
				 c/ccpnmr/clouds/Bacus.so
				 c/ccpnmr/clouds/AtomCoord.so
				 c/ccpnmr/clouds/DistConstraintList.so
				 c/ccpnmr/clouds/DistConstraint.so
				 c/ccpnmr/clouds/CloudUtil.so
				 c/ccpnmr/clouds/DistForce.so
				 c/ccpnmr/clouds/AtomCoordList.so
				 c/ccpnmr/analysis/ContourFile.so
				 c/ccpnmr/analysis/ContourLevels.so
				 c/ccpnmr/analysis/SliceFile.so
				 c/ccpnmr/analysis/PeakList.so
				 c/ccpnmr/analysis/ContourStyle.so
				 c/ccpnmr/analysis/WinPeakList.so
				 c/memops/global/PdfHandler.so
				 c/memops/global/TkHandler.so
				 c/memops/global/FitMethod.so
				 c/memops/global/BlockFile.so
				 c/memops/global/MemCache.so
				 c/memops/global/StoreFile.so
				 c/memops/global/PsHandler.so
				 c/memops/global/StoreHandler.so
				 c/memops/global/GlHandler.so
				 doc/graphics/prev.gif
				 doc/graphics/up.gif
				 doc/graphics/next.gif
				 python/ccp/c/linkSharedObjs
				 python/ccpnmr/c/linkSharedObjs
				 python/ccpnmr/clouds/CloudsPopup.py
				 python/ccpnmr/clouds/HcloudsMdPopup.py
				 python/ccpnmr/clouds/PseudoResonances.py
				 python/ccpnmr/clouds/FilterCloudsPopup.py
				 python/ccpnmr/clouds/HydrogenDynamics.py
				 python/ccpnmr/clouds/FilterClouds.py
				 python/ccpnmr/clouds/Clouds.py
				 python/ccpnmr/clouds/MidgePopup.py
				 python/ccpnmr/clouds/NoeRelaxation.py
				 python/ccpnmr/clouds/FileIO.py
				 python/ccpnmr/clouds/BacusPopup.py
				 python/ccpnmr/clouds/ResonanceIdentification.py
				 python/ccpnmr/clouds/__init__.py
				 python/ccpnmr/clouds/_licenseInfo.py
				 python/memops/c/linkSharedObjs"
				 
	for FILE in ${FILES}
		do
			fperms 755 ${IN_PATH}/ccpnmr1.0/${FILE}
		done
		
# I do not know how to make this more simple, because the relative paths have to be kept.
	dodir /usr/share/doc/${PF}/html/
	cp -r --parents `find . -name doc` ${D}usr/share/doc/${PF}/html/
	pwd
	rm -rv `find ${D}usr/lib/ -name doc`
	
	if use examples; then
		insinto usr/share/${PF}
		doins -r ../analysisTutorialData
	fi
}

pkg_postrm() {
	python_version
	python_mod_cleanup ${ROOT}/usr/$(get_libdir)/python${PYVER}/site-packages/ccpnmr
}