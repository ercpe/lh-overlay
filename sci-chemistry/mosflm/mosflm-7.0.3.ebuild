# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit toolchain-funcs

MY_PV=${PV//./}

SLOT="0"
LICENSE="ccp4"
KEYWORDS="~x86"
DESCRIPTION="Mosflm is a program for integrating single crystal diffraction data from area detectors."
SRC_URI="http://www.mrc-lmb.cam.ac.uk/harry/${PN}/ver${MY_PV}/build-it-yourself/${PN}${MY_PV}.tgz"
HOMEPAGE="http://www.mrc-lmb.cam.ac.uk/harry/${PN}/"
IUSE=""
RESTRICT="mirror"
DEPEND=""
RDEPEND=""
FORTRAN="g77 gfortran"

S="${WORKDIR}"/${PN}${MY_PV}

pkg_setup(){
	[[ -n $CCP4 || -n $CLIB ]] || die "Please source /etc/profile first"
	#set corected HOSTTYPE
	# ncurses header
}

src_compile(){
	export CCP4_LIB_FILES='-lccp4f -lccp4c -lxdl_view -lccif -lmmdb'
#	export MOSROOT="${D}"/usr/lib/
#	export MOSHOME="${MOSROOT}"/mosflm
	export MOSROOT="${WORKDIR}"
	export MOSHOME="${S}"
	export DEBUG=""
	export AR_FLAGS=vru
	export DPS=${MOSHOME}
	export IND=${MOSHOME}/index
	export UTIL=${MOSHOME}/src/dps/util
	export JPG=${MOSHOME}/jpg

	case $(uname -m) in
		i386|i486|i586|i686)	export X11_LIBS=/usr/$(get_libdir) #X11
								export BYTES32OR64="-m32"
								echo "Ick bin ein berliner";;
		x86_64)					export X11_LIBS=/usr/$(get_libdir) #X11
								export BYTES32OR64="";;
	esac
# overwrite compilers...
	export F77="$(tc-getF77) ${BYTES32OR64} -Wall ${DEBUG}"
	export FCOMP="${F77}"
	export FC="${F77}"
	export CC="$(tc-getCC) ${BYTES32OR64}"
	export FLINK="${F77} -Wall ${DEBUG}"
#	export FFLAGS="-O0 -fno-second-underscore -fno-globals -w"
	export FFLAGS="-O0 -fno-second-underscore -w"
	export CFLAGS="-O0"
	export LFLAGS="-s -static -static-libgcc"
# temp dynamic linking
	export LFLAGS="-s"
#
#	. setup
#	export MOSFLAGS="-O -fno-second-underscore -fno-globals -w"
#	export MCFLAGS="-O0 -fno-second-underscore -fno-globals -w"
	export MOSFLAGS="-O -fno-second-underscore -w"
	export MCFLAGS="-O0 -fno-second-underscore -w"
#	export MOSLIBS="-L${CCP4_LIB} ${CCP4_LIB_FILES} -lncurses -L${X11_LIBS} -lXt -lSM -lICE -lX11 -ldl -lpthread -lg2c -lm"
	export MOSLIBS="-L${CCP4_LIB} ${CCP4_LIB_FILES} -lncurses -L${X11_LIBS} -lXt -lSM -lICE -lX11 -ldl -lpthread -lm"
#
# (3) CBF directories
#
	export CBFCFLAGS="-O0"
# DPS
	export VERBOSE="v"
	export UTILFLAGS="-O0 -Dlinux "
	export EXTRAFLAGS="-I${UTIL} "
	export STDCFLAGS=""

	emake
}