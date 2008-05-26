# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils

DESCRIPTION="This is a Grub and a Splashutils boot screen theme with original size of Gentoo logo. Enjoy..."
HOMEPAGE="http://kde-look.org/content/show.php/show.php?content=49074"
SRC_URI="http://kde-look.org/CONTENT/content-files/49074-natural-gentoo-7.1.tar.gz"
IUSE="grub build"
LICENSE="freedist"
SLOT="0"
KEYWORDS="~x86"
DEPEND=">=media-gfx/splashutils-1.1.9.5
		grub? ( sys-boot/grub )"
RDEPEND=""
RESTRICT="binchecks strip mirror"

src_install() {
	dodir /boot
	insinto /
	doins -r natural_gentoo/etc
	grep boot /etc/mtab &>/dev/null
	if use grub;then
		if [[ $? != 0 ]]; then
			ewarn "You need to mount /boot for installing the grub splash."
			die
		fi
		insinto /
		doins -r natural_gentoo/boot
	fi
	if use build; then
		if [[ $? != 0 ]]; then
			ewarn "You need to mount /boot for installing the initramfs."
			die
		fi
		cd natural_gentoo/etc/splash/
		einfo "creating initramfs ;-) ..."
		for res in $(ls natural_gentoo/|grep x |sed 's/\.cfg//')
			do
				splash_geninitramfs natural_gentoo -r $res -g "${D}"boot/natural_gentoo-7.1-$res
			done
	fi
}
