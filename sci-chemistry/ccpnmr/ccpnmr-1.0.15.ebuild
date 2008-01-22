# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils toolchain-funcs

SLOT=""
LICENSE="CCPN license"
KEYWORDS="~x86"
DESCRIPTION="The Collaborative Computing Project for NMR is a public non-profit project serving the macromolecular NMR community"
SRC_URI="ftp://www.bio.cam.ac.uk/pub/ccpnmr/analysis1.0.15.tar.gz"
HOMEPAGE="http://www.ccpn.ac.uk/ccpn"
IUSE=""
RESTRICT="mirror"
DEPEND="${RDEPEND}"
RDEPEND=">=dev-lang/python-2.4
		  virtual/glut
		  >=dev-lang/tcl-8.3
		  >=dev-lang/tk-8.3
		  dev-tcltk/tix
		  x11-apps/mesa-progs"



src_compile(){
	export CCPNMR_TOP_DIR=${WORKDIR}/ccpnmr
	cd $CCPNMR_TOP_DIR/ccpnmr1.0/c
#	echo "CC = "$(tc-getCC)>enviroment.txt
#	echo "CFLAGS = "$CFLAGS>>enviroment.txt
cat >> enviroment.txt << EOF
MALLOC_FLAG = -DDO_NOT_HAVE_MALLOC
FPIC_FLAG = -fPIC
XOR_FLAG = 
IGNORE_GL_FLAG = 
GL_FLAG = -DUSE_GL_FALSE = 
#need to distinguish between glut and openglut
SHARED_FLAGS = -shared
MATH_LIB = -lm
X11_DIR = /usr
TCL_LIB = -ltcl8.4
TCL_INCLUDE_FLAGS = -I$(TCL_DIR)/include
TCL_LIB_FLAGS = -L$(TCL_DIR)/lib
TK_LIB = -ltk8.4
TK_INCLUDE_FLAGS = -I$(TK_DIR)/include
TK_LIB_FLAGS = -L$(TK_DIR)/lib
PYTHON_INCLUDE_FLAGS = -I$(PYTHON_DIR)/include/python2.4
GL_LIB = -lglut -lGLU -lGL
GL_INCLUDE_FLAGS = -I$(GL_DIR)/include
GL_LIB_FLAGS = -L$(GL_DIR)/lib
EOF
	cat enviroment.txt
	#make V=1

#	python installCode.py analysis
}