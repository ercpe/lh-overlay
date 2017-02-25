# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python2_7 python3_4 )

inherit distutils-r1 user

DESCRIPTION="A mail content scanner for postfix written in python"
HOMEPAGE="http://fuglu.org/"
SRC_URI="https://github.com/gryphius/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE="clamav database spamassassin test"

CDEPEND="dev-python/beautifulsoup:4[${PYTHON_USEDEP}]
		!dev-python/filemagic[${PYTHON_USEDEP}]
		dev-python/python-magic[${PYTHON_USEDEP}]
		dev-python/rarfile[${PYTHON_USEDEP}]
		$(python_gen_cond_dep 'dev-python/ipaddress[${PYTHON_USEDEP}]' python2_7)
		$(python_gen_cond_dep 'dev-python/ipaddr[${PYTHON_USEDEP}]' python3_4)
		>=dev-python/pyspf-2.0.12[${PYTHON_USEDEP}]
		database? ( dev-python/sqlalchemy[${PYTHON_USEDEP}] )"

DEPEND="${CDEPEND}
		dev-python/setuptools[${PYTHON_USEDEP}]
		test? (
			dev-python/nose[${PYTHON_USEDEP}]
			dev-python/lxml[${PYTHON_USEDEP}]
			dev-python/sqlalchemy[${PYTHON_USEDEP}]
		)"

RDEPEND="${CDEPEND}
	clamav? ( app-antivirus/clamav )
	spamassassin? ( mail-filter/spamassassin )"

S="${WORKDIR}/${P}/${PN}"

python_test() {
	nosetests tests/unit/ || die "Test failed with ${EPYTHON}"
}

src_install() {
	distutils-r1_src_install

	dodir /etc/fuglu
	dodir /usr/share/${PN}
	dodir /var/log/${PN}
	dodir /var/tmp/${PN}

	mv "${D}"/etc/fuglu/* "${D}"/usr/share/${PN} || die
	sed -i -e "s#^tempdir=.*#tempdir=/var/tmp/${PN}#g" "${D}"/usr/share/${PN}/${PN}.conf.dist || die
	sed -i -e "s#^debugfile=.*#debugfile=/var/log/${PN}/debug.log#g" "${D}"/usr/share/${PN}/${PN}.conf.dist || die
	sed -i -r 's/(user|group)=.*/\1=fuglu/g' "${D}"/usr/share/${PN}/${PN}.conf.dist || die

	fperms 0700 /var/tmp/${PN}
	fowners ${PN}:${PN} /var/log/${PN}
	fowners ${PN}:${PN} /var/tmp/${PN}

	newinitd "${FILESDIR}"/${PN}.initd ${PN}
	newconfd "${FILESDIR}"/${PN}.confd ${PN}
}

pkg_setup() {
	enewuser ${PN}
}

pkg_postinst() {
	einfo "Upstreams default configuration has been installed into /usr/share/${PN}."
	einfo "Before you can use ${PN}, you have to copy it to /etc/${PN} and remove the .dist extension"
}
