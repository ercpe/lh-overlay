# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=1

inherit eutils autotools

MY_PV="2.1-${PV}"
MY_P="${PN}-${MY_PV}"

DESCRIPTION="Object-oriented libraries for the organisation of crystallographic data and the performance of crystallographic computation"
HOMEPAGE="http://www.ysbl.york.ac.uk/~cowtan/clipper/clipper.html"
# SRC_URI="http://gentoo.j-schmitz.net/portage/distfiles/ALL/${MY_P}-ac.tar.gz"
SRC_URI="http://www.ysbl.york.ac.uk/~cowtan/clipper/clipper-2.1-081118-ac.tar.gz"
LICENSE="LGPL-2.1"

SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE=""
RDEPEND=""
DEPEND="${RDEPEND}
	sci-libs/fftw:2.1
	|| ( sci-libs/ccp4-libs sci-chemistry/ccp4 )"

S="${WORKDIR}/${PN}-2.1"

src_unpack (){

	unpack ${A}

	epatch "${FILESDIR}"/${PV}-as-needed.patch
	epatch "${FILESDIR}"/${PV}-gcc-4.3.patch

	cd "${S}"

	ebegin "versioning libraries with -2 suffix"
	find . -name Makefile.am \
	| xargs sed -i \
	-e "s~\(lib[[:alnum:]_]*\)_la~\1_2_la~g" \
	-e "s~\(lib[[:alnum:]-]*\).la~\1-2.la~g" \
	-e "s~\(-lclipper[[:alnum:]-]*\)~\1-2~g" \
	|| die "sed to version libs with -2 failed"
	eend $?

	AT_M4DIR="config" eautoreconf

}

src_compile () {
	# Slot programs with a '-2' suffix
	econf \
	--enable-contrib \
	--enable-phs \
	--enable-mmdb \
	--with-mmdb=/usr \
	--enable-mmdbold \
	--enable-minimol \
	--enable-cif \
	--enable-ccp4 \
	--enable-cns \
	--program-suffix=-2 \
	|| die
	# We don't have a cctbx ebuild yet
	#               --enable-cctbx \
	# This is a GPL replacement for CCP4 libraries
	# http://www.bioxray.dk/~mok/node/100
	#               --enable-gpp4 \

	emake || die
}

src_install() {
	# Slot includes with a '-2' suffix
	emake \
	DESTDIR="${D}" \
	pkgincludedir=/usr/include/clipper-2 \
	install \
	|| die "emake install failed"

	# Use '-2' suffix in headers
	ebegin "changing headers to use -2 suffix"
	grep 'include.*clipper' -rl "${D}" \
	| xargs sed -i \
	-e "s~\(include.*clipper\)/~\1-2/~g" \
	|| die "sed to find -2 slotted headers failed"
	eend $?
}

