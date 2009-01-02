# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

NEED_PYTHON=2.4
PYTHON_MODNAME="ccpn"

inherit python toolchain-funcs check-reqs portability distutils eutils

SLOT="0"
LICENSE="CCPN LGPL-2.1"
KEYWORDS="~x86"
DESCRIPTION="The Collaborative Computing Project for NMR"
SRC_URI="http://www.bio.cam.ac.uk/ccpn/download/ccpnmr/analysis${PV}.tar.gz"
#		 examples? ( ftp://www.bio.cam.ac.uk/pub/ccpnmr/analysisTutorialData.tar.gz )"
HOMEPAGE="http://www.ccpn.ac.uk/ccpn"
IUSE="doc examples numpy opengl"
RESTRICT="mirror"
DEPEND="${RDEPEND}"
RDEPEND="virtual/glut
	 dev-tcltk/tix
	 numpy? ( dev-python/numpy )"

S="${WORKDIR}"/${PN}mr

pkg_setup(){
	python_tkinter_exists
	python_version

	if use examples; then
	ewarn "The examples are about 523MB large."
	ewarn "Sure you want to have them?"
	epause 5
	CHECKREQS_DISK_USR="1024"
	CHECKREQS_DISK_VAR="1024"
	check_reqs
	fi
}

src_unpack() {
	unpack ${A}

	epatch "${FILESDIR}"/missing-link.patch
}

src_compile(){

	cd ccpnmr2.0/c

	create_env || die "fail to create env"

	cp "${T}"/environment.txt . || die "fail to setup env"

	emake || die
	emake links || die
}

src_install(){

	local IN_PATH
	local GENTOO_SITEDIR
	local LIBDIR
	local FILES

	IN_PATH=$(python_get_sitedir)/${PN}
	GENTOO_SITEDIR=$(python_get_sitedir)
	LIBDIR=$(get_libdir)

	for wrapper in analysis dangle dataShifter formatConverter pipe2azara; do
		sed -e "s:GENTOO_SITEDIR:${GENTOO_SITEDIR}:g" \
		    -e "s:LIBDIR:${LIBDIR}:g" \
		    "${FILESDIR}"/${wrapper} > "${T}"/${wrapper} || die "Fail fix ${wrapper}"
		dobin "${T}"/${wrapper} || die "Failed to install ${wrapper}"
	done

## It doesn't work without src.
#	for wrapper in updateAll updateCheck; do
#		sed -e "s:GENTOO_SITEDIR:${GENTOO_SITEDIR}:g" \
#		    -e "s:LIBDIR:${LIBDIR}:g" \
#		    "${FILESDIR}"/${wrapper} > "${T}"/${wrapper} || die "Fail fix ${wrapper}"
#		dosbin "${T}"/${wrapper} || die "Failed to install ${wrapper}"
#	done

	use doc && treecopy $(find . -name doc) "${D}"usr/share/doc/${PF}/html/

	ebegin "Removing unneeded docs"
	find . -name doc -exec rm -rf '{}' \; 2> /dev/null
	eend

	insinto ${IN_PATH}

	ebegin "Installing main files"
#	insopts -v
	doins -r ccpnmr2.0/{data,model,python} || die "main files installation failed"
	eend


	einfo "Adjusting permissions"

	FILES="ccpnmr/c/ContourFile.so
		ccpnmr/c/ContourLevels.so
		ccpnmr/c/ContourStyle.so
		ccpnmr/c/PeakList.so
		ccpnmr/c/SliceFile.so
		ccpnmr/c/WinPeakList.so
		ccpnmr/c/AtomCoordList.so
		ccpnmr/c/AtomCoord.so
		ccpnmr/c/Bacus.so
		ccpnmr/c/CloudUtil.so
		ccpnmr/c/DistConstraintList.so
		ccpnmr/c/DistConstraint.so
		ccpnmr/c/DistForce.so
		ccpnmr/c/Dynamics.so
		ccpnmr/c/Midge.so
		ccp/c/StructAtom.so
		ccp/c/StructBond.so
		ccp/c/StructStructure.so
		ccp/c/StructUtil.so
		memops/c/BlockFile.so
		memops/c/FitMethod.so
		memops/c/GlHandler.so
		memops/c/MemCache.so
		memops/c/PdfHandler.so
		memops/c/PsHandler.so
		memops/c/ShapeFile.so
		memops/c/StoreFile.so
		memops/c/StoreHandler.so
		memops/c/TkHandler.so"

	for FILE in ${FILES}; do
		fperms 755 ${IN_PATH}/python/${FILE}
	done

	if use examples; then
		cd "${WORKDIR}"
		ebegin "Installing example files"
		insopts -v
		insinto /usr/share/${PF}/
		doins -r analysisTutorialData || die "tutorial data installation failed"
		eend
	fi
}

create_env() {

	tk_ver="$(best_version dev-lang/tk | cut -d- -f3 | cut -d. -f1,2)"

	cat >> "${T}"/environment.txt <<- EOF
		CC = $(tc-getCC)
		MALLOC_FLAG = -DDO_NOT_HAVE_MALLOC
		FPIC_FLAG = -fPIC
		SHARED_FLAGS = -shared
		MATH_LIB = -lm
		X11_DIR = /usr
		X11_LIB = -lX11 -lXext
		X11_INCLUDE_FLAGS = -I\$(X11_DIR)/include
		X11_LIB_FLAGS = -L\$(X11_DIR)/lib
		TCL_DIR = /usr
		TCL_LIB = -ltcl${tk_ver}
		TCL_INCLUDE_FLAGS = -I\$(TCL_DIR)/include
		TCL_LIB_FLAGS = -L\$(TCL_DIR)/$(get_libdir)
		TK_DIR = /usr
		TK_LIB = -ltk${tk_ver}
		TK_INCLUDE_FLAGS = -I\$(TK_DIR)/include
		TK_LIB_FLAGS = -L\$(TK_DIR)/$(get_libdir)
		PYTHON_DIR = /usr
		PYTHON_INCLUDE_FLAGS = -I\$(PYTHON_DIR)/include/python${PYVER}
		CFLAGS = ${CFLAGS} \$(MALLOC_FLAG) \$(FPIC_FLAG) -g
	EOF

	if use opengl; then
		cat >> "${T}"/environment.txt <<- EOF
			IGNORE_GL_FLAG =
			# special GL flag, should have either USE_GL_TRUE or USE_GL_FALSE
			# (-D means this gets defined by the compiler so can be checked in source code)
			# (this relates to glXCreateContext() call in ccpnmr/global/gl_handler.c)
			# if have problems with USE_GL_TRUE then try GL_FALSE, or vice versa
			# use below for Linux?
			#GL_FLAG = -DUSE_GL_FALSE
			# use below for everything else?
			#GL_FLAG = -DUSE_GL_TRUE
			GL_FLAG = -DUSE_GL_FALSE
			#freeglut with normal glut w/o Needs check!
			GLUT_NEED_INIT = -DNEED_GLUT_INIT
			GLUT_NOT_IN_GL =
			GLUT_FLAG = \$(GLUT_NEED_INIT) \$(GLUT_NOT_IN_GL)
			GL_DIR = /usr
			GL_LIB = -lglut -lGLU -lGL
			GL_INCLUDE_FLAGS = -I\$(GL_DIR)/include
			GL_LIB_FLAGS = -L\$(GL_DIR)/$(get_libdir)
		EOF
	else
		cat >> "${T}"/environment.txt <<- EOF
			IGNORE_GL_FLAG = -DIGNORE_GL
			# special GL flag, should have either USE_GL_TRUE or USE_GL_FALSE
			# (-D means this gets defined by the compiler so can be checked in source code)
			# (this relates to glXCreateContext() call in ccpnmr/global/gl_handler.c)
			# if have problems with USE_GL_TRUE then try GL_FALSE, or vice versa
			# use below for Linux?
			#GL_FLAG = -DUSE_GL_FALSE
			# use below for everything else?
			#GL_FLAG = -DUSE_GL_TRUE
			GL_FLAG = -DUSE_GL_FALSE
			#freeglut with normal glut w/o Needs check!
			GLUT_NEED_INIT =
			GLUT_NOT_IN_GL =
			GLUT_FLAG = \$(GLUT_NEED_INIT) \$(GLUT_NOT_IN_GL)
		EOF
	fi

}

