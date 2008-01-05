
inherit eutils

SLOT="0"
LICENSE="as-is"
KEYWORDS="~x86 ~amd64"
DESCRIPTION="Simple bash-based backup script"
SRC_URI="http://gentoo.j-schmitz.net/portage/distfiles/app-admin/simple-backup/${P}.tar.bz2"
HOMEPAGE="http://wiki.j-schmitz.net/wiki/Private_Portage_Overlay/app-admin/simple-backup"
IUSE=""
RESTRICT="primaryuri"

src_install(){
	exeinto /usr/lib/simple-backup
	doexe simple-backup.sh
	
	insinto /etc/
	doins simple-backup.conf

	insinto /etc/simple-backup/
	doins .sample.conf

	dosym /usr/lib/simple-backup/simple-backup.sh /usr/bin/simple-backup

	einfo "Remember to copy the sample file /etc/simple-backup/.sample.conf and adjust it for your needs!";
}
