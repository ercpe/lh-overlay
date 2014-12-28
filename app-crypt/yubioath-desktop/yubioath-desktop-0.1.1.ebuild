# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

PYTHON_COMPAT=( python2_7 )

inherit eutils distutils-r1 vcs-snapshot

DESCRIPTION="Crossplatform graphical user interface to generate one-time passwords."
HOMEPAGE="https://developers.yubico.com/yubioath-desktop/"
SRC_URI="https://github.com/Yubico/yubioath-desktop/archive/${P}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
KEYWORDS="~amd64" # missing x86 on dev-python/pyscard
SLOT="0"

IUSE=""

DEPEND="dev-python/pyscard[${PYTHON_USEDEP}]
		dev-python/pbkdf2[${PYTHON_USEDEP}]
		dev-python/pyside[${PYTHON_USEDEP}]
		sys-apps/pcsc-lite[${PYTHON_USEDEP}]"

src_prepare() {
	sed -i -e "s/if __name__.*/def launch_yubicoauthenticator():/g" yubicoauthenticator/ui_systray.py || die

	echo "#!/usr/bin/env python2" >> "${T}"/${PN}.py
	echo "from yubicoauthenticator.ui_systray import launch_yubicoauthenticator" >> "${T}"/${PN}.py
	echo "launch_yubicoauthenticator()" >> "${T}"/${PN}.py

	cat - > "${T}"/${PN}.py <<EOF
#!/usr/bin/env python2
from yubicoauthenticator.ui_systray import launch_yubicoauthenticator
launch_yubicoauthenticator()
EOF
}

python_install_all() {
	distutils-r1_python_install_all
	python_foreach_impl python_newexe "${T}"/${PN}.py ${PN}

	newicon yubicoauthenticator/yubioath-128.png ${PN}.png
	make_desktop_entry ${PN} "${PN}" ${PN}
}

pkg_postinst() {
	einfo "${PN} needs a running pcscd to run."
}