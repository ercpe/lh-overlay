# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $
# inspired by peazip-1.8.2.ebuild - http://bugs.gentoo.org/show_bug.cgi?id=178716

inherit eutils

DESCRIPTION="Tux Commander - Fast and Small filemanager - VFS modules"
HOMEPAGE="http://tuxcmd.sourceforge.net/"
SRC_URI="mirror://sourceforge/tuxcmd/tuxcmd-modules-${PV}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 -*" # binary distribution, won't work on other arches (possible amd64 but not tested yet)
IUSE="gnome zip"

DEPEND=""
RDEPEND=">=app-misc/tuxcmd-bin-0.5.103
	 >=dev-libs/glib-2.4.0
	 gnome? ( >=gnome-base/gnome-vfs-2.8.0 )
	 zip? ( >=sys-devel/gcc-4.0.0 )"

S="${WORKDIR}/${P}"

src_compile() {
        cd "${WORKDIR}/tuxcmd-modules-${PV}"
	
	if use gnome; then
	    einfo "Making GNOME_VFS module"
	    ( cd gnome_vfs && emake || die "compilation failed" )
	fi

	if use zip; then
	    einfo "Making ZIP module"
	    ( cd zip && emake || die "compilation failed" )
	fi

}

src_install() {
        cd "${WORKDIR}/tuxcmd-modules-${PV}"

        dodir /opt/tuxcmd/plugins
        insinto /opt/tuxcmd/plugins	
	
	if use gnome; then
	    ( cd gnome_vfs && doins -r *.so || die "compilation failed" )
	fi

	if use zip; then
	    ( cd zip && doins -r *.so || die "compilation failed" )
	fi

}

