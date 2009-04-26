# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-chemistry/cns/cns-1.2-r1.ebuild,v 1.2 2008/01/10 04:43:03 dberkholz Exp $

inherit eutils fortran toolchain-funcs

MY_PN="${PN}_solve"
MY_P="${MY_PN}_${PV}"

DESCRIPTION="Crystallography and NMR System"
HOMEPAGE="http://cns.csb.yale.edu/"
SRC_URI="${MY_P}_all.tar.gz
	 http://gentoo.j-schmitz.net/private-overlay/distfiles/${CATEGORY}/${PN}/1.2-aria.patch.bz2"
RESTRICT="fetch"
LICENSE="cns"
SLOT="0"
KEYWORDS="~x86"
IUSE="aria"
RDEPEND="|| ( app-shells/tcsh app-shells/csh )
	!app-text/dos2unix
	aria? ( sci-chemistry/aria )"
DEPEND="${RDEPEND}"
S="${WORKDIR}/${MY_P}"

FORTRAN="g77 gfortran ifc"

pkg_nofetch() {
	einfo "Fill out the form at http://cns.csb.yale.edu/cns_request/"
	einfo "and place these files:"
	einfo ${A}
	einfo "in ${DISTDIR}."
}

src_unpack() {
	unpack ${A}
	cd "${S}"

	# The length of time must be at least 10, not 9
	# http://gcc.gnu.org/ml/fortran/2006-02/msg00198.html
	epatch "${FILESDIR}"/1.1-time-length-10.patch

	epatch "${FILESDIR}"/1.2-allow-unknown-architectures.patch

	if use aria; then
		epatch "${FILESDIR}"/1.2-aria.patch.bz2
	fi

	# Set up location for the build directory
	# Uses obsolete `sort` syntax, so we set _POSIX2_VERSION
	sed -i \
		-e "s:_CNSsolve_location_:${S}:g" \
		-e "17 s:\(.*\):\1\nsetenv _POSIX2_VERSION 199209:g" \
		"${S}"/cns_solve_env
	sed -i \
		-e "s:_CNSsolve_location_:${S}:g" \
		-e "17 s:\(.*\):\1\nexport _POSIX2_VERSION; _POSIX2_VERSION=199209:g" \
		"${S}"/.cns_solve_env_sh
}

src_compile() {
	local GLOBALS
	local MALIGN=
	if [[ ${FORTRANC} = g77 ]]; then
		GLOBALS="-fno-globals"
		MALIGN='\$(CNS_MALIGN_I86)'
	fi

	# make install really means build, since it's expected to be used in-place
	emake \
		CC="$(tc-getCC)" \
		F77="${FORTRANC}" \
		LD="${FORTRANC}" \
		CCFLAGS="${CFLAGS} -DCNS_ARCH_TYPE_\$(CNS_ARCH_TYPE) \$(EXT_CCFLAGS)" \
		F77OPT="${FFLAGS:- -O2} ${MALIGN}" \
		F77STD="${GLOBALS}" \
		g77install \
		|| die "emake failed"
}

src_test() {
	# We need to force on g77 manually, because we can't get aliases working
	# when we source in a -c
	einfo "Running tests ..."
	sh -c \
		"export CNS_G77=ON; source .cns_solve_env_sh; make run_tests" \
		|| die "tests failed"
	einfo "Displaying test results ..."
	cat "${S}"/*_g77/test/*.diff-test
}

src_install() {
	# Install to locations resembling FHS
	sed -i \
		-e "s:${S}:usr:g" \
		-e "s:^\(setenv CNS_SOLVE.*\):\1\nsetenv CNS_ROOT usr:g" \
		-e "s:^\(setenv CNS_SOLVE.*\):\1\nsetenv CNS_DATA \$CNS_ROOT/share/data:g" \
		-e "s:^\(setenv CNS_SOLVE.*\):\1\nsetenv CNS_DOC \$CNS_ROOT/share/doc/${PF}:g" \
		-e "s:CNS_MODULE \$CNS_SOLVE/modules:CNS_MODULE \$CNS_DATA/modules:g" \
		-e "s:\$CNS_LIB:\$CNS_DATA:g" \
		-e "s:CNS_HELPLIB \$CNS_SOLVE/helplib:CNS_HELPLIB \$CNS_DATA/helplib:g" \
		-e "s:\$CNS_SOLVE/bin/cns_info:\$CNS_DATA/bin/cns_info:g" \
		"${S}"/cns_solve_env
	# I don't entirely understand why the sh version requires a leading /
	# for CNS_SOLVE and CNS_ROOT, but it does
	sed -i \
		-e "s:${S}:/usr:g" \
		-e "s:^\(^[[:space:]]*CNS_SOLVE=.*\):\1\nexport CNS_ROOT=/usr:g" \
		-e "s:^\(^[[:space:]]*CNS_SOLVE=.*\):\1\nexport CNS_DATA=\$CNS_ROOT/share/data:g" \
		-e "s:^\(^[[:space:]]*CNS_SOLVE=.*\):\1\nexport CNS_DOC=\$CNS_ROOT/share/doc/${PF}:g" \
		-e "s:CNS_MODULE=\$CNS_SOLVE/modules:CNS_MODULE=\$CNS_DATA/modules:g" \
		-e "s:\$CNS_LIB:\$CNS_DATA:g" \
		-e "s:CNS_HELPLIB=\$CNS_SOLVE/helplib:CNS_HELPLIB=\$CNS_DATA/helplib:g" \
		-e "s:\$CNS_SOLVE/bin/cns_info:\$CNS_DATA/bin/cns_info:g" \
		"${S}"/.cns_solve_env_sh

	# Get rid of setup stuff we don't need in the installed script
	sed -i \
		-e "83,$ d" \
		-e "37,46 d" \
		"${S}"/cns_solve_env
	sed -i \
		-e "84,$ d" \
		-e "39,50 d" \
		"${S}"/.cns_solve_env_sh

	newbin "${S}"/*_g77/bin/cns_solve* cns_solve \
		|| die "install cns_solve failed"

	# Can be run by either cns_solve or cns
	dosym cns_solve /usr/bin/cns

	# Don't want to install this
	rm -f "${S}"/*_g77/utils/Makefile

	dobin "${S}"/*_g77/utils/* || die "install utils failed"

	sed -i \
		-e "s:\$CNS_SOLVE/doc/:\$CNS_SOLVE/share/doc/${PF}/:g" \
		"${S}"/bin/cns_web

	dobin "${S}"/bin/cns_{edit,header,transfer,web} || die "install bin failed"

	insinto /usr/share/cns
	doins -r "${S}"/libraries "${S}"/modules "${S}"/helplib
	doins "${S}"/bin/cns_info

	insinto /etc/profile.d
	newins "${S}"/cns_solve_env cns_solve_env.csh
	newins "${S}"/.cns_solve_env_sh cns_solve_env.sh

	dohtml \
		-A iq,cgi,csh,cv,def,fm,gif,hkl,inp,jpeg,lib,link,list,mask,mtf,param,pdb,pdf,pl,ps,sc,sca,sdb,seq,tbl,top \
		-f all_cns_info_template,omac,def \
		-r doc/html/*
}
