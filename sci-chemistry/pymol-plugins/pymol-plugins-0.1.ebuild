inherit eutils

DESCRIPTION="Plugins for PyMOL (a USER-SPONSORED molecular visualization system on an OPEN-SOURCE foundation)"
SRC_URI="cealign? ( http://www.pymolwiki.org/images/5/58/Cealign-0.8-RBS.tar.bz2 )
		 rendering? ( http://www-personal.umich.edu/~mlerner/PyMOL/rendering.py )
		 autodock? ( http://www.mpibpc.mpg.de/groups/grubmueller/start/people/dseelig/autodock.py )
		 promol? ( http://ase-web.rit.edu/~ez-viz/ProMOL.zip )
		 emovie? ( http://www.weizmann.ac.il/ISPC/eMovie_package.zip )
		 rtools? ( http://www.rubor.de/anlagen/rTools_0.7.2.zip )"
HOMEPAGE="http://wiki.j-schmitz.net/wiki/Private_Portage_Overlay"
RESTRICT="primaryuri"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE="cealign apbs rendering resicolor autodock promol helicheck emovie dynmap rtools colorama"

RDEPEND="app-portage/gentoolkit
		 cealign? ( dev-python/numpy
					=dev-lang/python-2.4* )
		 apbs? ( dev-libs/maloc
				 sci-chemistry/apbs
				 sci-chemistry/pdb2pqr )
		 autodock? ( sci-chemistry/autodock )
		 helicheck? ( sci-visualization/gnuplot )
		 >sci-chemistry/pymol-0.93"
DEPEND="${RDEPEND}"

src_unpack(){
	if use cealign;then
		unpack Cealign-0.8-RBS.tar.bz2
	fi
	if use rendering;then
		cp ${DISTDIR}/rendering.py ${WORKDIR}
	fi
	if use autodock;then
		cp ${DISTDIR}/autodock.py ${WORKDIR}
	fi
	if use promol;then
		mkdir promol
		cd promol
		unpack ProMOL.zip
	# Sorry for this ugly thing, but I can't figure out how to set it relative.
		sed -i 's/.\/modules/\/usr\/lib\/python2.4\/site-packages/g' ProMOL_302.py
		cd ..
	fi
	if use emovie;then
		mkdir emovie
		cd emovie
		unpack eMovie_package.zip
		cd ..
	fi
	if use rtools;then
		unpack rTools_0.7.2.zip
		cd rTools
		for i in `find .`
		do
        	if [[ -f $i ]
	        then
    	            sed  -i 's/.$//' $
        	fi
		done
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
	if use cealign; then
		cd cealign-0.8-RBS
		exeinto /usr/lib/python2.4/site-packages/
		doexe build/lib.linux-i686-2.4/ccealign.so
		insinto /usr/lib/python2.4/site-packages/cealign
		doins qkabsch.py cealign.py
		dodoc PYMOLRC CHANGES doc/cealign.pdf
		cd ..
	fi
	if use rendering;then
		insinto /usr/lib/python2.4/site-packages/pmg_tk/startup/
		doins ${WORKDIR}/rendering.py
	fi
	if use resicolor;then
		insinto /usr/lib/python2.4/site-packages/pmg_tk/startup/
		doins ${FILESDIR}/resicolor.py
	fi
	if use autodock;then
		insinto /usr/lib/python2.4/site-packages/pmg_tk/startup/
        doins ${WORKDIR}/autodock.py
	fi
	if use promol;then
		insinto /usr/lib/python2.4/site-packages/pmg_tk/startup/
		doins -r ${WORKDIR}/promol/*
	fi
	if use helicheck;then
		insinto /usr/lib/python2.4/site-packages/pmg_tk/startup/
		doins ${FILESDIR}/helicity_check.py
	fi
	if use emovie;then
		insinto /usr/lib/python2.4/site-packages/pmg_tk/startup/
		doins -r ${WORKDIR}/emovie/eMovie.py
	fi
	if use rtools;then
		cd rTools
		insinto /usr/lib/python2.4/site-packages/pmg_tk/startup/
		doins -r protscale/ scripts/ *.py scripts.lst
		dodoc LICENSE.TXT rtools_doku.rtf
		cd ..
	fi
	if use colorama;then
		insinto /usr/lib/python2.4/site-packages/pmg_tk/startup/
        doins ${FILESDIR}/colorama.py
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
        remove_python_bytecodes
}

remove_python_bytecodes() {
		#equery -q files pymol-plugins|grep pyc|xargs rm
        local d="${ROOT}/usr/$(get_libdir)/python2.4/site-packages/pmg_tk/startup/"
        [ -d "${d}" ] || return
        find "${d}" -type d -print0 | \
        while read -d $'\0' d ; do
                cd "${d}"
                rm -fv *.pyc *.pyo
        done
}