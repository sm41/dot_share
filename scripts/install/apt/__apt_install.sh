# !/bin/bash
set -eu


if [[ "$1" == "desktop" || "$1" == "server" ]] ; then
  type="apt_packages_${1}.txt"
else
  echo "Invalid argument"
  exit 1
fi

work_path="$(realpath $(dirname "$0"))"
input_file="$(find ${work_path}  -name ${type}   -not \( -path $0 \)  -type f  -printf "%f\n")"


# sudo apt-get update
# sudo apt-get upgrade

while read package_name
do
  [ -z "${package_name}" ] && continue
  [ "${package_name::1}" = "#" ] && continue

  echo "${package_name}"
  # sudo apt-get install --no-install-recommends ^"${package_name}"$

done < "${work_path}/${input_file}"