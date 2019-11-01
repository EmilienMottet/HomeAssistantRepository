# Copyright 1999-2019 Gentoo Authors Andreas Billmeier b (at) edevau.net
# Distributed under the terms of the GNU General Public License v3.0

EAPI="7"

PYTHON_COMPAT=( python3_{5,6,7} )

inherit distutils-r1
MY_P=${PN/-/_}-${PV}

DESCRIPTION="A program to read from an Enphase Envoy on the local network"
HOMEPAGE="https://github.com/jesserizzo/envoy_reader https://pypi.org/project/envoy-reader/"
SRC_URI="mirror://pypi/${P:0:1}/${PN}/${MY_P}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE="test"

S=${WORKDIR}/${MY_P}

RDEPEND=">=dev-python/requests-2.22.0[${PYTHON_USEDEP}]
		 >=dev-python/requests-async-0.6.0[${PYTHON_USEDEP}]"
DEPEND="${REDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]
	test? (
		dev-python/nose[${PYTHON_USEDEP}]
		dev-python/pytest[${PYTHON_USEDEP}]
	)"

python_test() {
	nosetests --verbose || die
	py.test -v -v || die
}
