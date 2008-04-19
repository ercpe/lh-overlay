# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils python

MY_PV="${PV/./v}"
MY_PN="${PN%-bin}"
LICENSE="MODELLER"
KEYWORDS="~amd64 ~x86"
DESCRIPTION="Protein structure modeling by satisfaction of spatial restraints"
SRC_URI="http://salilab.org/${MY_PN}/${MY_PV}/${MY_PN}-${MY_PV}.tar.gz"
HOMEPAGE="http://salilab.org/${MY_PN}/"
IUSE=""
RESTRICT="mirror"
SLOT="0"

RDEPEND=">=dev-lang/python-2.4
		 >=dev-lang/swig-1.3"
DEPEND=""

S="${MY_PN}-${MY_PV}"

src_unpack(){
	unpack ${A}
	epatch "${FILESDIR}"/${MY_PV}-setup.patch
}

src_compile(){
	cd "${S}"/src/swig
	swig -python -keyword -nodefaultctor -nodefaultdtor -noproxy modeller.i
	python setup.py build
}

src_install(){
	python_version

	IN_PATH=/opt/${MY_PN}${MY_PV}

	case ${ARCH} in
		x86)	EXECUTABLE_TYPE="i386-intel8";;
		amd64)	EXECUTABLE_TYPE="x86_64-intel8";;
		*)		ewarn "Your arch "${ARCH}" does not appear supported at this time."||\
				die "Unsupported Arch";;
	esac

	sed -e "s:EXECUTABLE_TYPE${MY_PV}=xxx:EXECUTABLE_TYPE${MY_PV}=${EXECUTABLE_TYPE}:g" \
		-e "s:MODINSTALL${MY_PV}=xxx:MODINSTALL${MY_PV}=\"${IN_PATH}\":g" \
		"${S}"/bin/modscript > "${T}/mod${MY_PV}"
	exeinto ${IN_PATH}/bin/
	doexe "${T}/mod${MY_PV}"
	dosym ${IN_PATH}/bin/mod${MY_PV} /opt/bin/mod${MY_PV}

	sed -e "s;@TOPDIR\@;\"${IN_PATH}\";" \
		-e "s;@EXETYPE\@;$EXECUTABLE_TYPE;" \
		"${S}"/bin/modpy.sh.in > "${T}/modpy.sh"
	doexe "${T}/modpy.sh"

	insinto ${IN_PATH}/bin/
	doins -r "${S}"/bin/{lib,*top}
	exeinto ${IN_PATH}/bin/
	doexe "${S}"/bin/{modslave.py,mod${MY_PV}_${EXECUTABLE_TYPE}}

#	exeinto /usr/$(get_libdir)/python${PYVER}/site-packages/
#	doexe "${S}"/lib/${EXECUTABLE_TYPE}/_modeller.so
	cd "${S}"/src/swig
	python setup.py install --prefix="${D}"/usr
	cd -
#	dosym ${IN_PATH}/modlib/modeller /usr/$(get_libdir)/python${PYVER}/site-packages/modeller
	dosym /usr/$(get_libdir)/python${PYVER}/site-packages/_modeller.so \
		  ${IN_PATH}/lib/${EXECUTABLE_TYPE}/_modeller.so

	exeinto ${IN_PATH}/lib/${EXECUTABLE_TYPE}/
	doexe "${S}"/lib/${EXECUTABLE_TYPE}/lib*
#	exeinto ${IN_PATH}/lib/${EXECUTABLE_TYPE}/python${PYVER}/
#	doexe "${S}"/lib/${EXECUTABLE_TYPE}/python2.5/_modeller.so
	dosym libmodeller.so.2 ${IN_PATH}/lib/${EXECUTABLE_TYPE}/libmodeller.so

	insinto ${IN_PATH}/modlib/
	doins -r "${S}"/modlib/{*mat,*lib,*prob,*mdt,*bin,*de,*inp,*ini,modeller}

#	insinto ${IN_PATH}/
#	doins -r "${S}"/src

	insinto /usr/share/${PN}/
	doins -r "${S}"/examples
	dohtml "${S}"/doc/*
	dodoc "${S}"/{README,ChangeLog}

	cat >> "${T}/config.py" <<- EOF
	install_dir = "${IN_PATH}/"
	license = "YOURLICENSEKEY"
	EOF

	insinto ${IN_PATH}/modlib/modeller/
	doins "${T}/config.py"
}

pkg_postinst(){
	#Adapted from BUG #127628
	einfo ""
	einfo " If you need to define your own residues"
	einfo " read the FAQ and edit the following files:"
	einfo ""
	einfo "    ${MY_D}/modlib/top_heav.lib"
	einfo "    ${MY_D}/modlib/radii.lib"
	einfo "    ${MY_D}/modlib/radii14.lib"
	einfo "    ${MY_D}/modlib/restyp.lib"
	einfo ""
	einfo "    Good Luck and Happy Modeling :D"
	einfo ""
	echo
	echo
	ewarn "Obtain a license Key from"
	ewarn "http://salilab.org/modeller/registration.html"
	ewarn "and change the appropriate line in"
	ewarn "${IN_PATH}/modlib/modeller/config.py"
}
