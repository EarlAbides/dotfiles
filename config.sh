#!/usr/bin/env zsh

# -----------------------------------------------------------------------------
# "THE BEER-WARE LICENSE" (Revision 42):
# <bonecrusher@covenofchaos.com>  wrote this file.  As long as  you retain this
# notice you can do whatever you want with this stuff.  If we meet some day and
# you think this stuff is worth it, you can buy me a beer in return.
#  > BoneCrusher <
# -----------------------------------------------------------------------------

mydir=${0:a:h}
config_dir=${mydir}/../scripts

[[ $1 ]] && { config_dir = $1 }

configs=(
    aliases
    git
    zsh
    iterm2
    istatmenus
)

for config in "${configs[@]}"
do
  if [[ -f ${config_dir}/configure_${config} ]]
  echo 'configuring' "${config}"
  ${mydir}/scripts/configure_${config} 
done
