# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/gegl/gegl-0.0.20.ebuild,v 1.4 2008/10/08 09:29:02 hanno Exp $

inherit eutils

DESCRIPTION="A graph based image processing framework"
HOMEPAGE="http://www.gegl.org/"
SRC_URI="ftp://ftp.gimp.org/pub/${PN}/0.0/${P}.tar.bz2"

LICENSE="|| ( GPL-3 LGPL-3 )"
SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE="cairo debug doc ffmpeg gtk jpeg mmx openexr sdl sse svg"

DEPEND=">=media-libs/babl-0.0.20
	>=dev-libs/glib-2.18.0
	media-libs/libpng
	cairo? ( x11-libs/cairo )
	doc? ( app-text/asciidoc
		>=dev-lang/lua-5.1.0
		app-text/enscript
		media-gfx/graphviz )
	ffmpeg? ( >=media-video/ffmpeg-0.4.9_p20080326 )
	gtk? ( >=x11-libs/gtk+-2.8.6
		x11-libs/pango )
	jpeg? ( media-libs/jpeg )
	openexr? ( media-libs/openexr )
	sdl? ( media-libs/libsdl )
	svg? ( >=gnome-base/librsvg-2.14.0 )"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/gegl-18-configure-ac.patch" || die
	epatch "${FILESDIR}/gegl-0.0.18-newffmpeg.diff" || die
}

src_compile() {
	econf $(use_enable debug) \
		$(use_enable cairo) \
		$(use_enable doc) \
		$(use_enable doc asciidoc) \
		$(use_enable doc enscript) \
		$(use_enable doc graphviz) \
		$(use_enable doc workshop) \
		$(use_enable ffmpeg) \
		$(use_enable gtk) \
		$(use_enable gtk pango) \
		$(use_with jpeg libjpeg) \
		$(use_enable mmx) \
		$(use_enable openexr) \
		$(use_enable sdl) \
		$(use_enable sse) \
		$(use_enable svg) \
		|| die "econf failed"
	env GEGL_SWAP="${WORKDIR}" emake || die "emake failed"
}

src_install() {
	# emake install doesn't install anything
	einstall || die "einstall failed"
	find "${D}" -name '*.la' -delete
	dodoc ChangeLog INSTALL README NEWS || die "dodoc failed"

	# don't know why einstall omits this?!
	insinto "/usr/include/${PN}-0.0/${PN}/buffer/"
	doins "${WORKDIR}/${P}/${PN}"/buffer/*.h || die "doins buffer failed"
	insinto "/usr/include/${PN}-0.0/${PN}/module/"
	doins "${WORKDIR}/${P}/${PN}"/module/*.h || die "doins module failed"
}
