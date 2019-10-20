#!/usr/bin/env bash

# This script will create both *.zip and *.tar.gz for platform binaries, below.
platforms=(
  "linux/amd64"
  "darwin/amd64"
  "windows/amd64"
)

SRC=$1
DEST=$2
NAME=$3
VERSION=$4

i=0
for arg in "SRC" "DEST" "NAME" "VERSION"; do
  (( i++ ))
  if [ -z "${!arg}" ]; then
    echo "error: missing arg #$i: ${arg}"
    echo "Usage xbuild SRC DEST APPNAME VERSION"
    exit 1
  fi
done

fixpath() {
  echo "$1" | sed 's,//*,/,g' | sed 's,/$,,g'
}

for platform in "${platforms[@]}"; do
  split=(${platform//\// })
  GOOS=${split[0]}
  GOARCH=${split[1]}

  pkgname="${NAME}-${GOOS}-${GOARCH}-${VERSION}"
  filename="${pkgname}"

  if [ "${GOOS}" = "windows" ]; then
    filename+=".exe"
  fi

  zipfile="${pkgname}.zip"
  zippath=$(fixpath "${DEST}")/"${zipfile}"

  tarfile="${pkgname}.tar.gz"
  tarpath=$(fixpath "${DEST}")/"${tarfile}"

  set -e
  tmpdir=$(mktemp -d)
  env GOOS="${GOOS}" GOARCH="${GOARCH}" go build -o "${tmpdir}/${filename}" "${SRC}"
  mkdir -p "$DEST"
  zip -j "${zippath}" "${tmpdir}/${filename}" >/dev/null
  tar -czf "${tarpath}" -C "${tmpdir}" .
  rm -rf "${tmpdir}" 2&1>/dev/null
  set +e
done

