# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils toolchain-funcs python check-reqs portability

SLOT="0"
LICENSE="CCPN"
KEYWORDS="~x86"
DESCRIPTION="The Collaborative Computing Project for NMR"
SRC_URI="ftp://www.bio.cam.ac.uk/pub/ccpnmr/analysis1.0.15.tar.gz
		 examples? ( ftp://www.bio.cam.ac.uk/pub/ccpnmr/analysisTutorialData.tar.gz )"
HOMEPAGE="http://www.ccpn.ac.uk/ccpn"
IUSE="examples"
RESTRICT="mirror"
DEPEND="${RDEPEND}"
RDEPEND=">=dev-lang/python-2.4
		  virtual/glut
		  dev-tcltk/tix"

S="${WORKDIR}/${PN}"

pkg_setup(){
	if ! built_with_use dev-lang/python tk; then
	eerror "Please reemerge dev-lang/python with 'tk' support or ccpnmr will"
	eerror "not work. In order to fix this, execute the following:"
	eerror "echo \"dev-lang/python tk\" >> /etc/portage/package.use"
	eerror "and reemerge dev-lang/python before emerging ccpnmr."
	die "requires dev-lang/python with use-flag 'tk'!!"
	fi

	if use examples; then
	ewarn "The examples are about 523MB large."
	ewarn "Sure you want to have them?"
	epause 5
	CHECKREQS_DISK_USR="1024"
	CHECKREQS_DISK_VAR="1024"
	check_reqs
	fi
}

src_compile(){
	tk_ver="$(best_version dev-lang/tk | cut -d- -f3 | cut -d. -f1,2)"
	python_version
	cd ccpnmr1.0/c

	cat >> environment.txt <<- EOF
	CC = $(tc-getCC)
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
	TCL_LIB = -ltcl$tk_ver
	TCL_INCLUDE_FLAGS = -I\$(TCL_DIR)/include
	TCL_LIB_FLAGS = -L\$(TCL_DIR)/$(get_libdir)
	TK_DIR = /usr
	TK_LIB = -ltk$tk_ver
	TK_INCLUDE_FLAGS = -I\$(TK_DIR)/include
	TK_LIB_FLAGS = -L\$(TK_DIR)/$(get_libdir)
	PYTHON_DIR = /usr
	PYTHON_INCLUDE_FLAGS = -I\$(PYTHON_DIR)/include/python${PYVER}
	GL_DIR = /usr
	GL_LIB = -lglut -lGLU -lGL
	GL_INCLUDE_FLAGS = -I\$(GL_DIR)/include
	GL_LIB_FLAGS = -L\$(GL_DIR)/$(get_libdir)
	CFLAGS = $CFLAGS \$(MALLOC_FLAG) \$(FPIC_FLAG) \$(XOR_FLAG)
	EOF

	emake
	emake links
}

src_install(){

	IN_PATH=/usr/$(get_libdir)/python${PYVER}/site-packages/ccpnmr

	cat >> "${T}"/20ccpnmr <<- EOF
	export CCPNMR_TOP_DIR=${IN_PATH}
	EOF

	doenvd "${T}"/20ccpnmr

	einfo "Creating launch wrapper"

	cat >> "${T}"/base <<- EOF
	#!/bin/sh
	export CCPNMR_TOP_DIR=${IN_PATH}
	export PYTHONPATH=${IN_PATH}/ccpnmr1.0/python
	export LD_LIBRARY_PATH=/usr/$(get_libdir)
	export TCL_LIBRARY=/usr/$(get_libdir)/tcl$tk_ver
	export TK_LIBRARY=/usr/$(get_libdir)/tk$tk_ver
	EOF

	insinto /usr/share/${PF}/
	newins "${T}"/base ccpnmr-base

	echo "source /usr/share/${PF}/ccpnmr-base" > "${T}"/analysis
	echo "${python} -O -i \${CCPNMR_TOP_DIR}/ccpnmr1.0/python/ccpnmr/analysis/AnalysisGui.py \$1 \$2 \$3 \$4 \$5" >> "${T}"/analysis

	echo "source /usr/share/${PF}/ccpnmr-base" > "${T}"/dataShifter
	echo "${python} -O \${PYTHONPATH}/ccpnmr/format/gui/DataShifter.py" >> "${T}"/dataShifter

	echo "source /usr/share/${PF}/ccpnmr-base" > "${T}"/formatConverter
	echo "${python} -O \${PYTHONPATH}/ccpnmr/format/gui/FormatConverter.py \$1 \$2" >> "${T}"/formatConverter

	echo "source /usr/share/${PF}/ccpnmr-base" > "${T}"/pipe2azara
	echo "${python} -O \${PYTHONPATH}/ccpnmr/analysis/NmrPipeData.py \$1 \$2 \$3" >> "${T}"/pipe2azara

#Perhaps the two update wrapper shouldn't be.
	echo "source /usr/share/${PF}/ccpnmr-base" > "${T}"/updateAll
	echo "${python} -O \${PYTHONPATH}/ccpnmr/update/UpdateAuto.py" >> "${T}"/updateAll

	echo "source /usr/share/${PF}/ccpnmr-base" > "${T}"/updateCheck
	echo "${python} -O \${PYTHONPATH}/ccpnmr/update/UpdatePopup.py" >> "${T}"/updateCheck

	einfo "Installing wrapper"
	exeinto ${IN_PATH}/bin
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
#	cd ccpnmr

	einfo "Installing main files"
	insopts -v
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
				 c/memops/global/GlHandler.so"

	for FILE in ${FILES}
		do
			fperms 755 ${IN_PATH}/ccpnmr1.0/${FILE}
		done

	rm "${D}"${IN_PATH}/{INSTALL,README,installCode.py}

	treecopy `find . -name doc` "${D}"usr/share/doc/${PF}/html/
	rm -r `find "${D}"usr/lib/ -name doc`

	if use examples; then
		cd "${WORKDIR}"
		einfo "Installing example files"
		insopts -v
		insinto /usr/share/${PF}/
		doins -r analysisTutorialData
	fi
}

pkg_postinst(){
	python_mod_optimize "${ROOT}"/usr/$(get_libdir)/python${PYVER}/site-packages/ccpnmr
}

pkg_postrm() {
	python_mod_cleanup "${ROOT}"/usr/$(get_libdir)/python${PYVER}/site-packages/ccpnmr
}