#!/usr/bin/env bash

function get_os() {
  unameOut="$(uname -s)"
  case "${unameOut}" in
  Linux*)
    echo -n "linux"
    ;;
  Darwin*)
    echo -n "macos"
    ;;
  CYGWIN*)
    echo -n "cygwin"
    ;;
  MINGW*)
    echo -n "mingw"
    ;;
  *)
    echo "Cannot detect your operating system.  Exiting."
    exit 1
    ;;
  esac
}

os="$(get_os)"

function check_available() {
  which $1 >/dev/null
  if [ $? -ne 0 ]; then
    echo "**** ERROR needed program missing: $1"
    exit 1
  fi
}

check_available 'which'
check_available 'realpath'
check_available 'dirname'
check_available 'go'

bashver="${BASH_VERSION:0:1}"

if ! [[ "$bashver" =~ ^[4-9]$ ]]; then
  echo 'You need MOAR bash-fu!  Your version of `bash` is waaaay too old!  What are you running?  Commodore 64?'
  echo "Your bash version is: ${BASH_VERSION}"
  echo "Your need at least a bash version of 5 or higher"
  echo
  case "${os}" in
  linux)
    echo "Thank God, you're running Linux.  There's hope."
    echo "Use your package manager to upgrade bash."
    echo "If your Linux distribution can't get a recent version of bash, change distros."
    ;;
  macos)
    echo 'MacOS: likely `brew install bash` will be your friend.'
    ;;
  cygwin)
    echo "Uhhhh ... CygWin.  Not sure how to help here."
    ;;
  mingw)
    echo "Uhhhh ... MinGW.  Not sure how to help here."
    ;;
  *)
    echo "I have no idea."
    echo "Repent sins."
    ;;
  esac
  exit 1
fi

script_dir=$(dirname "$(realpath -e "$0")")
cwd="$(echo "$(pwd)")"
function cleanup() {
  cd "$cwd"
}
# Make sure that we get the user back to where they started
trap cleanup EXIT

# This is necessary because we reference things relative to the script directory
cd "$script_dir"

function usage() {
  echo "Usage: build.sh [-h|--help] [-c|--clean] [-C|--clean-all]"
  echo "                [-b|--build]"
  echo
  echo '    Build some graphics programming experiments.'
  echo
  echo "Arguments:"
  echo "  -h|--help               This help text"
  echo '  -c|--clean              Clean generated artifacts.'
  echo "  -b|--build              Build 'darth-management' using local tooling"
}

clean=0
build=0

while [[ $# -gt 0 ]]; do
  key="$1"

  case $key in
  -h | --help)
    usage
    exit 0
    ;;
  -c | --clean)
    clean=true
    shift
    ;;
  -b | --build)
    build=true
    shift
    ;;
  *)
    echo "ERROR: unknown argument $1"
    echo
    usage
    exit 1
    ;;
  esac
done


if [ "$clean" = true ]; then
  echo "Regular cleaning..."
	rm -fr ./color-wheel.vin
fi

if [ "$build" = true ]; then
    echo "Building..."
    set -x
    ~/projects/Odin/odin build color-wheel -debug -define:GL_DEBUG=false -collection:extra=/home/jim/projects/graphics-probe/extra
    set +x
fi
