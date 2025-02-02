# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{9..11} )
inherit distutils-r1 pypi

DESCRIPTION="Alternative regular expression module to replace re"
HOMEPAGE="https://bitbucket.org/mrabarnett/mrab-regex"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 arm arm64 x86"
IUSE="doc"

PATCHES=(
	"${FILESDIR}/${PN}-2021.4.4-pypy3-fix-test_empty_array.patch"
	"${FILESDIR}/${PN}-2021.4.4-pypy3-fix-test_issue_18468.patch"
)

distutils_enable_tests unittest

python_test() {
	eunittest -s "${BUILD_DIR}"/lib
}

python_install_all() {
	use doc && local HTML_DOCS=( docs/Features.html )
	local DOCS=( README.rst docs/*.rst )

	distutils-r1_python_install_all
}

distutils_enable_tests pytest
