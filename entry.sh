#!/bin/sh -e
DIR=$(dirname "$0")

cd ${DIR}

test() {

    pytest --cov=cartpole --cov-report term-missing --pep8 ##--cov-fail-under 80

}

test_e2e() {

    pip install -e .
    cartpole --help

}

_codecov() {

    codecov

}

build() {

    python setup.py sdist bdist_wheel

}

publish() {

    twine upload --skip-existing dist/*

}

release(){

    bumpversion --tag --commit --message "[skip ci] Update version \{current_version\} --> \{new_version\}" patch
    gitchangelog > CHANGELOG.md

}

docs() {

   sphinx-build -d docs/build/doctrees source docs/build/html
}

# Main options
case "$1" in
  test)
        shift
        test "$@"
        exit $?
        ;;
  test_e2e)
        shift
        test_e2e "$@"
        exit $?
        ;;
  codecov)
        shift
        _codecov "$@"
        exit $?
        ;;
  build)
        shift
        build "$@"
        exit $?
        ;;
  release)
        shift
        release "$@"
        exit $?
        ;;
  publish)
        shift
        publish "$@"
        exit $?
        ;;
  docs)
        shift
        docs "$@"
        exit $?
        ;;
  *)
        echo "Usage: $0 {test|test_e2e|codecov|build|release|publish|docs}"
        exit 1
esac
