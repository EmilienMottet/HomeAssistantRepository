# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..12} )
DISTUTILS_USE_PEP517=setuptools
PYPI_NO_NORMALIZE=1
inherit distutils-r1 pypi

DESCRIPTION="Simple wrapper client for the Vilfo router API"
HOMEPAGE="https://github.com/mannew/vilfo-api-client-python https://pypi.org/project/vilfo-api-client/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm arm64 x86"
IUSE="test"
RESTRICT="!test? ( test )"

RDEPEND="dev-python/requests[${PYTHON_USEDEP}]
	dev-python/getmac[${PYTHON_USEDEP}]"
BDEPEND="
	test? (
		dev-python/pytest[${PYTHON_USEDEP}]
	)"

python_test() {
	py.test -v -v || die
}

src_prepare() {
	default
	echo -ne "\n[options.packages.find]\nexclude =\n    test\n    test.*\n" >> setup.cfg || die
}

distutils_enable_tests pytest
