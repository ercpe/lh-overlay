EGIT_REPO_URI="git://labs.ohloh.net/git/ohcount.git"

GEM_SRC="${WORKDIR}/${P}/pkg/${PN}-2.0.0"

inherit gems git eutils

DESCRIPTION="Ohcount is a source code line counter."
HOMEPAGE="http://labs.ohloh.net/ohcount"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE=""
SRC_URI=""

RDEPEND=">=dev-lang/ruby-1.8.6
  dev-libs/libpcre
  dev-ruby/diff-lcs"
DEPEND="${RDEPEND}
  dev-ruby/rake
  dev-ruby/rubygems
  >=dev-util/ragel-6.3"


src_compile() {
	rake || die "compilation failed."
}

src_install() {
	rake gem || die "building gem failed"
	gems_src_install
	dodoc ${S}/README
}
