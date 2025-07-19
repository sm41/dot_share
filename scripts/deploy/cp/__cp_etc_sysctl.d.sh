#!/bin/bash
set -eu



# スクリプト自身の絶対パスを取得（シンボリックリンクにも対応）
SCRIPT_PATH="$(readlink -f "$0")"
SCRIPT_DIR="$(dirname "$SCRIPT_PATH")"

# スクリプトが属するGitリポジトリのトップレベルを取得
GIT_TOPLEVEL=$(git -C "$SCRIPT_DIR" rev-parse --show-toplevel 2>/dev/null)

if [ $? -ne 0 ]; then
  echo "このスクリプトは Git リポジトリの中にありません。"
  exit 1
fi


ROOT_DIR=/root
FHS_DIR=/etc
ORIGIN_DIR=/sysctl.d


while read target_file
do
  # sudo mkdir -p "${FHS_DIR}${ORIGIN_DIR}"

  # sudo cp  -b \
  echo \
    "${GIT_TOPLEVEL}${ROOT_DIR}${FHS_DIR}${ORIGIN_DIR}/${target_file}" \
    "${FHS_DIR}${ORIGIN_DIR}/${target_file#sample.*}"

done < <(find "${GIT_TOPLEVEL}${ROOT_DIR}${FHS_DIR}${ORIGIN_DIR}" -type f -printf '%f\n' | sort )