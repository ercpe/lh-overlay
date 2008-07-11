# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils flag-o-matic games

DESCRIPTION="Total conversion of the Cube engine, for team-oriented multiplayer fun"
HOMEPAGE="http://action.cubers.net/"
SRC_URI="mirror://sourceforge/actiongame/AssaultCube_v${PV}.tar.bz2"

LICENSE="ZLIB"
SLOT="0"
KEYWORDS="~x86"
IUSE="dedicated icon"
RESTRICT="mirror"
RDEPEND="virtual/opengl
	virtual/glu
	media-libs/libsdl
	media-libs/sdl-mixer
	media-libs/sdl-image
	media-libs/libpng"
DEPEND="${RDEPEND}
	icon? ( media-gfx/icoutils )"

basedir=${WORKDIR}/AssaultCube
S=${basedir}/source/src
dir=${GAMES_DATADIR}/${PN}

src_unpack() {
	unpack ${A}
	cd "${S}"

	edos2unix *.cpp

	local cube_datadir="${dir}/"

	# Sets shared directory - quick 'n' dirty
	sed -i \
		-e "s:char \*path(char \*s):char \*addfullpath(char \*s) {\n\tstatic char ret\[256\];\n\tif (s\[0\] == '/') { return s; }\n\tint slen = strlen(s);\n\tmemset(ret, 0x00, 256);\n\tmemcpy(ret, \"${cube_datadir}\", ${#cube_datadir});\n\tmemcpy(ret+${#cube_datadir}, s, slen);\n\treturn ret;\n}\n\nchar \*path(char \*s):" \
		-e "s:for(char \*t = s;:s = addfullpath(s);\nfor(char \*t = s;:" \
		tools.cpp || die "sed tools.cpp failed"

	sed -i \
		-e "s:SDL_Surface \*s = IMG_Load(texname);:texname = addfullpath(texname);\n\tSDL_Surface \*s = IMG_Load(texname);:" \
		-e "s:const char \*texname:char \*texname:" \
		rendergl.cpp || die "sed rendergl.cpp failed"

	sed -i \
		-e "s:extern char \*path(char \*s);:extern char \*addfullpath(char \*s);\nextern char \*path(char \*s);:" \
		tools.h || die "sed tools.h failed"

	sed -i \
		-e "s:packages/:${cube_datadir}packages/:" \
		*.cpp \
		|| die "fixing data path failed"

	if use icon ; then
		cd "${basedir}"
		icotool -x icon.ico || die
	fi
}

src_compile() {
	local targets="libenet client"
	use dedicated && targets="${targets} server"

	# Needs -j1 to compile
	emake -j1 ${targets} || die "emake failed"
}

src_install() {
	newgamesbin ac_client ${PN} || die
	if use dedicated ; then
		newgamesbin ac_server ${PN}-ded || die
	fi

	# Slightly non-standard licence
	dodoc *.txt "${basedir}"/source/{AUTHORS,LICENSE,*.txt} || die

	cd "${basedir}"
	insinto "${dir}"
	doins -r bot config packages || die "doins failed"
	dohtml -r docs

	if use icon ; then
		newicon "${basedir}"/icon_1_32x32x32.png ${PN}.png || die
	fi
	make_desktop_entry ${PN} "AssaultCube" ${PN}

	prepgamesdirs
}
