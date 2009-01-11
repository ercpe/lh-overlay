# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit games eutils subversion

DESCRIPTION="VegaTrek is a Star Trek mod for vegastrike"
HOMEPAGE="http://wcuniverse.sourceforge.net/vegatrek/"
ESVN_REPO_URI="https://svn.wcjunction.com/vegatrek/trunk/"
ESVN_PROJECT="vegatrek"
ESVN_OPTIONS="--username username --password password"
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="stencil-buffer gtk no-sound sdl debug"

SRC_URI="mirror://sourceforge/vegastrike/vegastrike-source-0.5.0.tar.bz2"

RDEPEND="
	dev-lang/python
	virtual/opengl
	media-libs/jpeg
	media-libs/libpng
	dev-libs/expat
	media-libs/openal
	sdl? ( media-libs/libsdl )
	!no-sound? ( media-libs/libvorbis
				 media-libs/libogg
				 sdl? ( media-libs/sdl-mixer ) )
	virtual/glut 
	virtual/glu
	gtk? ( x11-libs/gtk+ )
	!games-rpg/vegastrike-ded "
DEPEND="${RDEPEND}
	dev-lang/perl
	>=sys-devel/autoconf-2.58"


pkg_setup() {
	games_pkg_setup
	einfo "If compiling fails for you on gl_globals.h, try to replace your"
	einfo "glext.h (usually found in /usr/include/GL/ with this one"
	einfo "http://oss.sgi.com/projects/ogl-sample/ABI/glext.h"
	einfo "remember to make backup of the original though"
}

src_unpack() {
        ewarn
        ewarn NOTICE!!!!!!
        ewarn
        ewarn "if this is your first time installing vegatrek then due to"
        ewarn "svn security issues, upon connecting to the svn repository," 
        ewarn "an certificate validation message will appear, hit the t key"
        ewarn "inorder accept it temporarily, note that unless you hit"
        ewarn "the p key which stands for permanently, you will have to"
        ewarn "undergo this validation everytime you install vegatrek"
        ewarn "to continue downloading the data hit either t or p."
        ewarn
        ewarn
        subversion_src_unpack
	
	mkdir "../data"
        mv -f * ../data
	cd "${WORKDIR}"
	unpack ${A}
        mv vegastrike-0.5.0/* ${S}
        rm -rf vegastrike-0.5.0
	cd "${S}"
        mv -f ../data .
	rm -rf ${S}/data/bin/*
        rm data/uninstall.*
        #complete missing files
        if [ ! -f data/communications/privtomilitia.xml ]; then
           cp data/communications/privtofederation.xml data/communications/privtomilitia.xml
        fi
        if [ ! -f data/communications/privtomerchant.xml ]; then
           cp data/communications/privtofederation.xml data/communications/privtomerchant.xml
        fi
	#esvn_clean "${S}"

	# Sort out directory references

	sed -i \
		-e "s!/usr/games/vegatrek!${GAMES_DATADIR}/vegatrek!" \
		-e "s!/usr/local/bin!${GAMES_BINDIR}!" \
		launcher/saveinterface.cpp \
		|| die "sed launcher/saveinterface.cpp failed"
	sed -i \
		"s!/usr/local/share/vegatrek!${GAMES_DATADIR}/vegatrek!" \
		src/common/common.cpp \
		|| die "sed src/common/common.cpp failed"
	sed -i \
		"s!/usr/share/local/vegatrek!${GAMES_DATADIR}/vegatrek!" \
		src/vsfilesystem.cpp \
		|| die "sed src/filesys.cpp failed"
	sed -i \
		-e '/^SUBDIRS =/s:tools::' \
		Makefile.am \
		|| die "sed Makefile.am failed"
        if [ $(cat data/vegastrike.config | grep The_Duel.mission | wc -l) = 1]; then
            sed -i "s/The_Duel.mission/explore_universe.mission/g" data/vegastrike.config
        fi
	./bootstrap-sh
}

src_compile() {
	cd ${S}/vegatrek
	local conf_opts="${conf_opts} --disable-dependency-tracking"

	if use debug; then
		conf_opts="${conf_opts} --enable-debug"
	else
		conf_opts="${conf_opts} --enable-release=2"
	fi

	if ! use gtk; then
		conf_opts="${conf_opts} --disable-gtk"
	fi

	CONFIGURE_OPTIONS="
		$(use_enable stencil-buffer) 
		$(use_enable sdl) 
		$(use_enable !no-sound sound) 
		${conf_opts}"		

	egamesconf $CONFIGURE_OPTIONS \
	    || die "egamesconf failed"

	# it causes corruptions
	filter-flags -ffast-math

	# Let's optimize, removing also broken -ffast-math
	if ! use debug; then
		sed -i -e "s:-ffast-math:${CXXFLAGS}:g" Makefile \
		    || die "sed of CXXFLAGS failed"
	fi

	emake || die "emake failed"
}

src_install() {
       cd ${S}

	cat >> "${T}"/vtinstall <<- EOF
	#!/bin/sh
	mkdir ~/$(cat ${GAMES_BINDIR}/Version.txt)
	cp setup.config ~/$(cat ${GAMES_BINDIR}/Version.txt)
	cp vegastrike.config ~/$(cat ${GAMES_BINDIR}/Version.txt)
	cp -r $(cat ${GAMES_BINDIR}/Version.txt)/* ~/$(cat ${GAMES_BINDIR}/Version.txt)
	#${GAMES_BINDIR}/vssetup
	vssetup
	echo "If you wish to have your own music edit ~/.vegastrike/*.m3u"
	echo "Each playlist represents a place or situation in Vega Strike"
	exit 0
	EOF

        mv vegastrike vegatrek 
	dogamesbin vegatrek \
	     || die "Creation of vegatrek failed"
	if [ $(ls /usr/games/bin/ | grep vegaserver | wc -l) = '0' ]; then
	    dogamesbin vegaserver \
		     || die "Creation of vegaserver failed"
        fi
	if [ $(ls /usr/games/bin/ | grep mesher | wc -l) = '0' ]; then
	    dogamesbin mesher \
		     || die "Creation of mesher failed"
        fi
        if [ $(ls /usr/games/bin/ | grep vtinstall | wc -l) = '0' ]; then
	    dogamesbin vtinstall \
		     || die "Creation of vtinstall failed"
        fi
	cp vtinstall data/bin || die "cp failed"

	doicon  "${S}/data/vslogo.xpm"
	make_desktop_entry "vegatrek" "VegaTrek" "vslogo" "games" "/usr/share/games/vegatrek/data"

        dodir "${GAMES_DATADIR}/${PN}"
        insinto "${GAMES_DATADIR}/${PN}"
	doins -r data/ || die "data install failed"
	prepgamesdirs
}

pkg_postinst() {
	games_pkg_postinst
	elog "run vsinstall to setup your Account,"
	elog "or run vssetup to set up Vega Strike."
	elog "to start Vega Strike Server run vegaserver."
        elog "please run vtinstall before first run."
}


