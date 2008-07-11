# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/lastfmplayer/lastfmplayer-1.4.2.58240-r1.ebuild,v 1.3 2008/06/27 05:40:44 beandog Exp $

inherit eutils multilib qt4

MY_P="${P/lastfmplayer/lastfm}.dfsg"

DESCRIPTION="The player allows you to listen to last.fm radio streams"
HOMEPAGE="http://www.last.fm/help/player"
SRC_URI="mirror://debian/pool/main/l/lastfm/lastfm_${PV}.dfsg.orig.tar.gz
	mirror://debian/pool/main/l/lastfm/lastfm_${PV}.dfsg-3.diff.gz"
#http://cdn.last.fm/client/src/${MY_P}.src.tar.bz2

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~amd64"
IUSE=""
RESTRICT="mirror"

RDEPEND="$(qt4_min_version 4.2)
	media-libs/libsamplerate
	sci-libs/fftw
	media-libs/libmad
	>=media-libs/libgpod-0.5.2
	media-libs/alsa-lib"
DEPEND="${RDEPEND}
	app-arch/sharutils"

S="${WORKDIR}/${MY_P}"

src_unpack() {
	unpack ${A}
	epatch lastfm_${PV}.dfsg-3.diff
	cd "${S}"
	for i in $(< debian/patches/series); do
		epatch debian/patches/$i
	done
}

src_compile() {
	./configure
	emake || die "emake failed"
	cd i18n; lrelease *.ts
}

src_install() {
	# Docs
	dodoc ChangeLog README debian/README.Debian-source
	doman debian/lastfm.1

	# Copied from debian/rules
	uudecode -o - debian/icons.tar.gz.uu | tar -xzf -
	uudecode -o - debian/trayicons22.tar.gz.uu | tar -xzf -
	insinto /usr/share
	doins -r icons
	insinto /usr/share/lastfm/icons
	doins user_*.png

	sed -i -e "s,/usr/lib,/usr/$(get_libdir),g" debian/lastfm.install
	# make directories
	for i in $(<debian/lastfm.install); do [ ${i:0:1} == / ] && dodir $i; done
	# debian installation
	sed -i -e "s:^:mv :" -e 's: /:${D}/:' debian/lastfm.install
	bash debian/lastfm.install

	# copied..
	mv "${D}"/usr/bin/last{.,}fm
	rm -f "${D}"/usr/share/lastfm/icons/{*profile24,systray_mac}.png
}

pkg_postinst() {
	elog "To use the Last.fm player with a mozilla based browser:"
	elog " 1. Go to about:config in the browser"
	elog " 2. Right-click on the page"
	elog " 3. Select New and then String"
	elog " 4. For the name: network.protocol-handler.app.lastfm"
	elog " 5. For the value: /usr/bin/lastfm"
	elog
	elog "If you experience awkward fonts or widgets, try running qtconfig."
}
