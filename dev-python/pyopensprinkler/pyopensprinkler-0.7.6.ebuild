# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{9..11} )
DISTUTILS_USE_PEP517=setuptools
inherit distutils-r1 pypi

DESCRIPTION="Python module for OpenSprinker API"
HOMEPAGE="https://github.com/vinteo/py-opensprinkler https://pypi.org/project/pyopensprinkler/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm arm64 x86"
IUSE="test"
RESTRICT="!test? ( test )"

DOCS="README.md"

RDEPEND="~dev-python/aiohttp-3.8.4[${PYTHON_USEDEP}]
        ~dev-python/backoff-2.2.1[${PYTHON_USEDEP}]"
BDEPEND="
        dev-python/pytest-runner[${PYTHON_USEDEP}]
        test? (
                dev-vcs/pre-commit[${PYTHON_USEDEP}]
                dev-python/pytest[${PYTHON_USEDEP}]
                dev-python/pytest-asyncio[${PYTHON_USEDEP}]
                dev-python/pytest-cov[${PYTHON_USEDEP}]
       )"

python_test() {
	py.test -v -v || die
}

distutils_enable_tests pytest