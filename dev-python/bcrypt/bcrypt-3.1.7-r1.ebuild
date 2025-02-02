# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..12} )
DISTUTILS_USE_PEP517=setuptools
inherit distutils-r1 pypi
DESCRIPTION="Modern password hashing for software and servers"
HOMEPAGE="https://github.com/pyca/bcrypt/ https://pypi.org/project/bcrypt/"

SLOT="0"
LICENSE="Apache-2.0"
KEYWORDS="amd64 arm arm64 x86"
IUSE="test"
RESTRICT="!test? ( test )"

COMMON_DEPEND="
	>=dev-python/cffi-1.1[${PYTHON_USEDEP}]
	>=dev-python/six-1.4.1[${PYTHON_USEDEP}]"
DEPEND="${COMMON_DEPEND}
	test? ( >=dev-python/pytest-3.2.1[${PYTHON_USEDEP}] )"
RDEPEND="${COMMON_DEPEND}"

python_test() {
	esetup.py test
}

distutils_enable_tests pytest
