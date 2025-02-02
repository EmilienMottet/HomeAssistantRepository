# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..12} )

inherit distutils-r1

DESCRIPTION="Abstract Syntax Tree for logilab packages"
HOMEPAGE="
	https://github.com/PyCQA/astroid/
	https://pypi.org/project/astroid/
"
SRC_URI="
	https://github.com/PyCQA/astroid/archive/v${PV}.tar.gz
		-> ${P}.gh.tar.gz
"

LICENSE="LGPL-2.1+"
SLOT="0"
KEYWORDS="amd64 arm arm64 x86"

# Version specified in pyproject.toml
RDEPEND="
	>=dev-python/lazy-object-proxy-1.4.0[${PYTHON_USEDEP}]
	$(python_gen_cond_dep '
		>=dev-python/typing-extensions-4.0.0[${PYTHON_USEDEP}]
	' 3.{8..10})
	<dev-python/wrapt-2[${PYTHON_USEDEP}]
"
BDEPEND="
	dev-python/setuptools-scm[${PYTHON_USEDEP}]
	test? (
		dev-python/numpy[${PYTHON_USEDEP}]
		dev-python/python-dateutil[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest

export SETUPTOOLS_SCM_PRETEND_VERSION=${PV}

python_test() {
	local EPYTEST_DESELECT=(
		# no clue why they're broken
		tests/test_modutils.py::GetModulePartTest::test_known_values_get_builtin_module_part
		tests/test_regrtest.py::NonRegressionTests::test_numpy_distutils
		tests/brain/test_regex.py::TestRegexBrain::test_regex_pattern_and_match_subscriptable
		# some problem with warnings (our options?)
		tests/test_decorators.py::TestDeprecationDecorators::test_deprecated_default_argument_values_one_arg
		tests/test_decorators.py::TestDeprecationDecorators::test_deprecated_default_argument_values_two_args
		tests/test_scoped_nodes.py::test_deprecation_of_doc_attribute
		# requires six bundled in urllib3, sigh
		tests/test_modutils.py::test_file_info_from_modpath__SixMetaPathImporter
	)

	# Faker causes sys.path_importer_cache keys to be overwritten
	# with PosixPaths
	epytest -p no:faker
}
