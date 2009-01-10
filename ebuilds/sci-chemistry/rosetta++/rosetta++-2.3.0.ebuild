# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils

EAPI="2"
DESCRIPTION="Prediction and design of protein structures, folding mechanisms, and protein-protein interactions"
HOMEPAGE="http://www.rosettacommons.org/"
SRC_URI="https://www.rosettacommons.org/software/academic/${PV}/${PN}_source-${PV}.tgz"
RESTRICT="fetch test"
LICENSE="rosetta++"
SLOT="0"
KEYWORDS="~x86"
IUSE="boinc opengl mpi debug doc icc profile test static"
RDEPEND="mpi? ( virtual/mpi )
		 boinc? ( sci-misc/boinc )"
DEPEND="${RDEPEND}
		>=dev-util/scons-0.96.1
		  doc? ( app-doc/doxygen )
		  icc? ( dev-lang/icc )
		  test? ( dev-libs/boost )"
MYCONF=""

S="${WORKDIR}/${PN}"


pkg_nofetch() {
	local my_url="http://depts.washington.edu/ventures/UW_Technology/Express_Licenses/rosetta.php"

	einfo "Please fill out the registration form at '${my_url}'."\
		  "Then download the file '${A}' manually and place it"\
		  "into '${DISTDIR}'. If you prefer to download"\
		  "'RosettaBundle-2.3.0.tgz' instead, then rename the unpacked"\
		  "file 'rosetta++_srouce-2.3.0.tgz' to '${A}'."
}

src_prepare() {
	epatch "${FILESDIR}/rosetta++-elliptic-msd.patch"
	epatch "${FILESDIR}/rosetta++-gl-graphics.patch"
	epatch "${FILESDIR}/rosetta++-setup-platforms.patch"
	epatch "${FILESDIR}/rosetta++-FileName-cc-ostream.patch"
	epatch "${FILESDIR}/rosetta++-PathName-cc-ostream.patch"
	epatch "${FILESDIR}/rosetta++-SConscript-src-use-clone.patch"
	epatch "${FILESDIR}/rosetta++-SConscript-src-2-use-clone.patch"
	epatch "${FILESDIR}/rosetta++-string-functions-cc.patch"
	epatch "${FILESDIR}/rosetta++-zipstream-ipp.patch"
	epatch "${FILESDIR}/rosetta++-DirectedSimAnnealer-cc.patch"
	epatch "${FILESDIR}/rosetta++-dna-cc.patch"
	epatch "${FILESDIR}/rosetta++-kin_id-h.patch"
	epatch "${FILESDIR}/rosetta++-dna_classes-h.patch"
	epatch "${FILESDIR}/rosetta++-loop_class-h.patch"
	epatch "${FILESDIR}/rosetta++-barcode_classes-h.patch"
	epatch "${FILESDIR}/rosetta++-packing_measures-cc.patch"
	epatch "${FILESDIR}/rosetta++-XUtilities-cc.patch"
	epatch "${FILESDIR}/rosetta++-marchingCubes-cc-missing-braces.patch.bz2"
	epatch "${FILESDIR}/rosetta++-options-settings.patch"
	epatch "${FILESDIR}/rosetta++-user-settings.patch"
	epatch "${FILESDIR}/rosetta++-atom_chem-h.patch"
	epatch "${FILESDIR}/rosetta++-packing_measures-h.patch"


	#UPSTREAM: as a default, scons doesnot consider any other 
	#		   path then /usr/bin:/bin, while Gentoo's policy
	#	       is to install foreign binaries below /opt
	if use icc; then
		local ufile="tools/build/user.settings"
		local upath="$( dirname $( which icc ))"
		test -n "${upath}" || die "intel icc compiler not found"

		ebegin "Setting icc path in ${ufile} to '${upath}'" \
		   && sed -e "s:/opt/intel/cc/10.1.018/bin:${upath}:g" \
			   "${ufile}" > "${ufile}.new" \
		   && rm "${ufile}" && mv "${ufile}.new" "${ufile}" \
		   && eend || die "could not edit ${ufile}"
	fi

	#UPSTREAM: source archive contains headers and sourcefiles marked as executable
	#		   (don't want to install executable headers by stripdebug feature)
	find "${S}" -name '*.h'  -exec chmod a-x {} ';'
	find "${S}" -name '*.hh' -exec chmod a-x {} ';'
	find "${S}" -name '*.cc' -exec chmod a-x {} ';'


	#UPSTREAM: "README" was obviously renamed to "README.rosetta++", but is
	#           still referenced as "README" 
	# 		 -> create a symlink, because else scons cat=doc fails
	if use doc; then
	   ln -s "${S}/README.rosetta++" "${S}/README" || die
	fi

	sed 's:fno-exceptions:fexceptions:g' -i tools/build/basic.settings || die
}



src_configure() {
	local myextras=""
	local mymode=""
	local mycxx=""

	
	#UPSTREAM: do not use "valgrind" as a synonym for dynamic linking
	! use static  && myextras=$(my_list_append "${myextras}" "shared")
	
	use boinc  && myextras="boinc"
	use opengl && myextras=$(my_list_append "${myextras}" "graphics")
	use mpi    && myextras=$(my_list_append "${myextras}" "mpi")

	#FIXME: uncertain if a newly invented use flag is appropriate
	use icc && mycxx="cxx=icc"

	test -n "${myextras}" && myextras="extras=${myextras}"

	if use debug; then
		mymode="debug"
	elif use profile; then
		mymode="profile"
	else
		mymode="release"
	fi


	#Bug: scons issues a __warning__ about -l not yet being 
	#	  supported, but then simply aborts. 
	MAKEOPTS=$(my_filter_option "${MAKEOPTS}" "--load-average[=0-9.]*")
	MAKEOPTS=$(my_filter_option "${MAKEOPTS}" "-l[0-9.]*")
	#	  ... add a filter for any other insane make flag here

	einfo "MAKEOPTS had been filtered for '-l' and  '--load-average':"\
		  "MAKEOPTS='${MAKEOPTS}'"
	MYCONF="${MAKEOPTS} mode=${mymode} ${myextras} ${mycxx}"
}

src_compile() {
	#UPSTREAM: scons script returns ok even after a RuntimeError was raised.
	#	       The exception handler in toplevel SConstruct file is probably 
	# 		   incomplete
	einfo "running 'scons ${MYCONF}' ..."
	scons ${MYCONF} || die "scons ${MYCONF} failed"

	#Workaround: see if at least one rosetta executable exists
	#		     problem: executable name is rosetta.release||rosetta.debug 
	#					  rosetta.gcc || ...
	local myfiles=$(ls -l "${S}"/bin/rosetta* 2>/dev/null | wc -l)
	test ${myfiles} -eq 0 && die "scons ${MYCONF} failed"

	if use doc; then
		einfo "running 'scons ${MYCONF} cat=doc' ..."
		scons ${MYCONF} cat=doc || die "scons failed to build documentation"
		#UPSTREAM: rosetta doxygen source documentation make is broken
		#scons  doc || die "scons failed to build documentation"
	fi
}

src_test() {
	#UPSTREAM: 1. multiple library naming issues (libutil_release.a vs libutil.a)
	#		   2. undefined symbol main, if these naming issues are fixed
	#		      manually
	#		   3. boost dependency for test target only ...
	#scons testing
	#scons ${MYCONF} cat=test || die "scons ${MYCONF} cat=test failed"
	elog "The rosetta++ test target is still completely broken"
}

src_install() {
	#install executable(s)
	dobin bin/* || die "could not install rosetta program files"

	#UPSTREAM: there is a complete doxy-generated source documentation,
	#		   but not yet compilable via scons
	if use doc; then
	   dohtml build/doc/rosetta++/docs/* || die "could not install docs"
	fi
}

my_filter_option() {
	local value="$1"
	local exp="$2"
	local result=`echo ${value} | sed -e s/${exp}//g`
	echo "${result}"
	return 0;
}

my_list_append() {
	local old_value="$1"
	local new_value="$2"
	test -n "${old_value}" && old_value="${old_value},"
	echo "${old_value}${new_value}"
	return 0;
}


