EAPI="3"

inherit git multilib prefix

EGIT_REPO_URI="https://repos.j-schmitz.net/git/pub/squashed-portage.git"

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
	eprefixify *
	sed -e "s:GENTOOLIBDIR:$(get_libdir):g" -i get-squashed-portage
}

src_install() {
	dodir /var/portage
	keepdir /var/portage
	newinitd ${PN}.init ${PN} || die
	newconfd ${PN}.conf ${PN} || die
	dobin get-squashed-portage || die
}
