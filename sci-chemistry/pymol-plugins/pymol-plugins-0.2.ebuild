# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils python

DESCRIPTION="Plugins for PyMOL (a USER-SPONSORED molecular visualization system on an OPEN-SOURCE foundation)"
SRC_URI="autodock? ( http://www.mpibpc.mpg.de/groups/grubmueller/start/people/dseelig/autodock.py )
		 cealign? ( http://www.pymolwiki.org/images/5/58/Cealign-0.8-RBS.tar.bz2 )
		 colorama? ( http://www.pymolwiki.org/images/b/b7/Colorama-0.1.0.tar.bz2 )
		 divscore? ( http://shoichetlab.compbio.ucsf.edu/~raha/research/ramm.tar.gz )
		 dynmap? ( http://www.giacomobastianelli.com/Files/DYNMAP_v1.0.tar.gz )
		 emovie? ( http://www.weizmann.ac.il/ISPC/eMovie_package.zip )
		 helicheck? ( http://www.pymolwiki.org/images/6/6e/Helicity_check-1.0.tar.bz2 )
		 promol? ( http://ase-web.rit.edu/~ez-viz/ProMOL.zip )
		 rendering? ( http://www-personal.umich.edu/~mlerner/PyMOL/rendering.py )
		 resicolor? ( http://www.pymolwiki.org/images/6/6c/Resicolor-0.1.tar.bz2 )
		 rtools? ( http://www.rubor.de/anlagen/rTools_0.7.2.zip )"
HOMEPAGE="http://wiki.j-schmitz.net/wiki/Private_Portage_Overlay"
RESTRICT="mirror"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="apbs autodock cealign colorama divscore dynmap emovie helicheck promol rendering resicolor rtools"

python_version

RDEPEND="app-portage/gentoolkit
		 apbs? ( dev-libs/maloc
				 sci-chemistry/apbs
				 sci-chemistry/pdb2pqr )
		 autodock? ( sci-chemistry/autodock )
		 divscore? ( sys-apps/util-linux
				sci-chemistry/openbabel )
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

	if use divscore ; then
		unpack ramm.tar.gz
	fi

	if use dynmap; then
		unpack DYNMAP_v1.0.tar.gz
		if [[ "${PYVER}" == "2.5" ]] ; then
			epatch "${FILESDIR}"/dynmap-1.0-python2.5.patch || die "epatch dynmap-python2.5.patch failed"
		else
			epatch "${FILESDIR}"/dynmap-1.0.patch || die "epatch dynmap-1.0.patch failed"
		fi
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
		sed -e "s:./modules:/usr/lib/python${PYVER}/site-packages:g" -i ProMOL_302.py
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
		if [[ "${PYVER}" == "2.5" ]] ; then
			epatch "${FILESDIR}"/rtools-0.7.2-python2.5.patch
		else
			epatch "${FILESDIR}"/rtools-0.7.2.patch
		fi
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
	cat >> "${T}"/20apbs <<- EOF
	APBS_BINARY="/usr/bin/apbs"
	APBS_PSIZE="/usr/share/apbs-0.5.1/tools/manip/psize.py"
	EOF
	doenvd "${T}"/20apbs
	fi

	if use autodock;then
		insinto /usr/lib/python${PYVER}/site-packages/pmg_tk/startup/
		doins "${WORKDIR}"/autodock.py
	fi

	if use cealign; then
		cd cealign-0.8-RBS
		exeinto /usr/lib/python${PYVER}/site-packages/

		if use amd64 ; then
			doexe build/lib.linux-x86_64-${PYVER}/ccealign.so
		elif use x86 ; then
			doexe build/lib.linux-x86-${PYVER}/ccealign.so
		fi

		insinto /usr/lib/python${PYVER}/site-packages/cealign
		doins qkabsch.py cealign.py
		dodoc PYMOLRC CHANGES doc/cealign.pdf
		cd ..
	fi

	if use colorama;then
		insinto /usr/lib/python${PYVER}/site-packages/pmg_tk/startup/
		doins colorama.py
	fi

	if use divscore ; then
		insinto /usr/lib/python${PYVER}/site-packages/pmg_tk/startup/
		doins -r "${WORKDIR}"/ramm/ "${WORKDIR}"/ramm.py
	fi

	if use dynmap; then
		insinto /usr/lib/dynmap/
		doins -r "${WORKDIR}"/DYNMAP_v1.0/*
		dosym /usr/lib/dynmap/DYN-MAP /usr/bin/DYN-MAP
	fi

	if use emovie;then
		insinto /usr/lib/python${PYVER}/site-packages/pmg_tk/startup/
		doins -r "${WORKDIR}"/emovie/eMovie.py
	fi

	if use helicheck;then
		insinto /usr/lib/python${PYVER}/site-packages/pmg_tk/startup/
		doins helicity_check.py
	fi

	if use promol;then
		insinto /usr/lib/python${PYVER}/site-packages/pmg_tk/startup/
		doins -r "${WORKDIR}"/promol/*
	fi

	if use rendering;then
		insinto /usr/lib/python${PYVER}/site-packages/pmg_tk/startup/
		doins "${WORKDIR}"/rendering.py
	fi
	if use resicolor;then
		insinto /usr/lib/python${PYVER}/site-packages/pmg_tk/startup/
		doins "${WORKDIR}"/resicolor.py
	fi

	if use rtools;then
		cd rTools
		insinto /usr/lib/python${PYVER}/site-packages/pmg_tk/startup/
		doins -r protscale/ scripts/ *.py scripts.lst
		dodoc LICENSE.TXT rtools_doku.rtf
		cd ..
	fi
}

pkg_postinst(){
	if use cealign;then
		einfo "remeber to add"
		einfo "run /usr/lib/python${PYVER}/site-packages/cealign/qkabsch.py"
		einfo "run /usr/lib/python${PYVER}/site-packages/cealign/cealign.py"
		einfo "to your ~/.pymolrc file"
		einfo ""
	fi
	if use divscore ; then
		einfo "------DivScore: A Plugin for PyMOL by Kaushik Raha------"
		einfo "(http://shoichetlab.compbio.ucsf.edu/~raha/research/divscore.html)"
		einfo ""
		einfo "-->For disulfide linking the program Disulphide (written by Andrew Wollacott)"
		einfo "   is needed. For crosslinking feature of DivScore plugin to function Disulphide"
		einfo '   should reside in the $HOME/bin/ (maybe $PATH) directory.'
		einfo ""
		einfo "-->DivScore will ask you a few questions to initialize its path."
		einfo "   You have to provide the path for your AMBER distribution and DivCon distribution."
		einfo "   DivScore will store the initialization information for future use in ~/.rahamol"
	fi
}

pkg_postrm() {
	python_version
	python_mod_cleanup "${ROOT}"/usr/$(get_libdir)/python${PYVER}/site-packages/pmg_tk/startup/
}
