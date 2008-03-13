# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils python

DESCRIPTION="Plugins for PyMOL (a USER-SPONSORED molecular visualization system on an OPEN-SOURCE foundation)"
SRC_URI="autodock? ( http://www.mpibpc.mpg.de/groups/grubmueller/start/people/dseelig/autodock.py )
		 cealign? ( http://www.pymolwiki.org/images/5/58/Cealign-0.8-RBS.tar.bz2 )
		 colorama? ( http://www.pymolwiki.org/images/b/b7/Colorama-0.1.0.tar.bz2 )
		 dynmap? ( http://www.giacomobastianelli.com/Files/DYNMAP_v1.0.tar.gz )
		 emovie? ( http://www.weizmann.ac.il/ISPC/eMovie_package.zip )
		 helicheck? ( http://www.pymolwiki.org/images/6/6e/Helicity_check-1.0.tar.bz2 )
		 promol? ( http://ase-web.rit.edu/~ez-viz/ProMOL.zip )
		 rendering? ( http://www-personal.umich.edu/~mlerner/PyMOL/rendering.py )
		 resicolor? ( http://www.pymolwiki.org/images/6/6c/Resicolor-0.1.tar.bz2 )
		 rtools? ( http://www.rubor.de/anlagen/rTools_0.7.2.zip )"
HOMEPAGE="http://wiki.j-schmitz.net/wiki/Private_Portage_Overlay"
RESTRICT="primaryuri"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="apbs autodock cealign colorama dynmap emovie helicheck promol rendering resicolor rtools"

RDEPEND="app-portage/gentoolkit
		 apbs? ( dev-libs/maloc
				 sci-chemistry/apbs
				 sci-chemistry/pdb2pqr )
		 autodock? ( sci-chemistry/autodock )
		 cealign? ( dev-python/numpy
					=dev-lang/python-2.4* )
		 dynmap? ( >=sci-biology/biopython-1.43
		 		   >=dev-python/cheetah-2.0
				   >=sci-chemistry/gromacs-3.3.1
				   sci-chemistry/msms-bin )
		 helicheck? ( sci-visualization/gnuplot )
		 >sci-chemistry/pymol-0.99"
DEPEND="${RDEPEND}"

src_unpack(){

	if use autodock;then
		cp "${DISTDIR}"/autodock.py "${WORKDIR}"
	fi

	if use cealign;then
		unpack Cealign-0.8-RBS.tar.bz2
	fi

	if use colorama; then
		unpack Colorama-0.1.0.tar.bz2
	fi

	if use dynmap; then
		unpack DYNMAP_v1.0.tar.gz
		epatch "${FILESDIR}"/dynmap-1.0.patch
	fi

	if use emovie;then
		mkdir emovie
		cd emovie
		unpack eMovie_package.zip
		cd ..
	fi

	if use helicheck; then
		unpack Helicity_check-1.0.tar.bz2
	fi

	if use promol;then
		mkdir promol
		cd promol
		unpack ProMOL.zip
	# Sorry for this ugly thing, but I can't figure out how to set it relative.
		sed -i 's:./modules:/usr/lib/python2.4/site-packages:g' ProMOL_302.py
		cd ..
	fi

	if use rendering;then
		cp "${DISTDIR}"/rendering.py "${WORKDIR}"
	fi

	if use resicolor; then
		unpack Resicolor-0.1.tar.bz2
	fi

	if use rtools;then
		unpack rTools_0.7.2.zip
		cd rTools
		edos2unix color_protscale.py
		epatch "${FILESDIR}"/rtools-0.7.2.patch
	fi
}

src_compile(){
	if use cealign; then
		cd cealign-0.8-RBS
		python setup.py build
	fi
}

src_install() {
#Could be directly implied into the apbs ebuild
	if use apbs; then
	cat >> "${T}/20apbs" <<- EOF
	APBS_BINARY="/usr/bin/apbs"
	APBS_PSIZE="/usr/share/apbs-0.5.1-r1/tools/manip/psize.py"
	EOF
	doenvd "${T}/20apbs"
	fi

	if use autodock;then
		insinto /usr/lib/python2.4/site-packages/pmg_tk/startup/
		doins "${WORKDIR}"/autodock.py
	fi

	if use cealign; then
		cd cealign-0.8-RBS
		exeinto /usr/lib/python2.4/site-packages/
		doexe build/lib.linux-i686-2.4/ccealign.so
		insinto /usr/lib/python2.4/site-packages/cealign
		doins qkabsch.py cealign.py
		dodoc PYMOLRC CHANGES doc/cealign.pdf
		cd ..
	fi

	if use colorama;then
		insinto /usr/lib/python2.4/site-packages/pmg_tk/startup/
		doins colorama.py
	fi

	if use dynmap; then
		insinto /usr/lib/dynmap/
		doins -r "${WORKDIR}"/DYNMAP_v1.0/*
		fperms 775 /usr/lib/dynmap/DYN-MAP
		dosym /usr/lib/dynmap/DYN-MAP /usr/bin/DYN-MAP
	fi

	if use emovie;then
		insinto /usr/lib/python2.4/site-packages/pmg_tk/startup/
		doins -r "${WORKDIR}"/emovie/eMovie.py
	fi

	if use helicheck;then
		insinto /usr/lib/python2.4/site-packages/pmg_tk/startup/
		doins helicity_check.py
	fi

	if use promol;then
		insinto /usr/lib/python2.4/site-packages/pmg_tk/startup/
		doins -r "${WORKDIR}"/promol/*
	fi

	if use rendering;then
		insinto /usr/lib/python2.4/site-packages/pmg_tk/startup/
		doins "${WORKDIR}"/rendering.py
	fi

	if use resicolor;then
		insinto /usr/lib/python2.4/site-packages/pmg_tk/startup/
		doins "${WORKDIR}"/resicolor.py
	fi

	if use rtools;then
		cd rTools
		insinto /usr/lib/python2.4/site-packages/pmg_tk/startup/
		doins -r protscale/ scripts/ *.py scripts.lst
		dodoc LICENSE.TXT rtools_doku.rtf
		cd ..
	fi
}

pkg_postinst(){
	if use cealign;then
		einfo "remeber to add"
		einfo "run /usr/lib/python2.4/site-packages/cealign/qkabsch.py"
		einfo "run /usr/lib/python2.4/site-packages/cealign/cealign.py"
		einfo "to your ~/.pymolrc file"
	fi
}

pkg_postrm() {
	python_version
	python_mod_cleanup "${ROOT}"/usr/$(get_libdir)/python${PYVER}/site-packages/pmg_tk/startup/
}
