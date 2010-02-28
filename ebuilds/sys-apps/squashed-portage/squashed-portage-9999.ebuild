EAPI="3"

inherit git prefix

EGIT_REPO_URI="file:///data/squashed-portage"

DESCRIPTION="Tools to handle squashed portagey"
HOMEPAGE="N/N"
SRC_URI=""

SLOT="0"
KEYWORDS="~amd64 ~x86"
LICENSE="GPL-3"
IUSE=""

RDEPEND=""
DEPEND="${RDEPEND}"

src_prepare() {
	eprefixify ${PN}*
}

src_install() {
	dodir /var/portage
	newinitd ${PN}.init ${PN} || die
	newconfd ${PN}.conf ${PN} || die
}
