#!/bin/bash
THEME_NAME=

clean() {
  for file in $(grep -lr '^[ \t]*font\.family'); do
    sed -i '/^[ \t]*font\.family/d' ${file}
  done
}

patch() {
  for file in $(grep -lr 'font.pointSize'); do
    sed -i 's/^\([ \t]*\)\(font\.pointSize.*\)/\1\2\n\1font.family: config.fontFamily/g' ${file}
  done
  echo 'fontFamily=' >> theme.conf
}

change_name() {
  for file in $(grep -lir ${THEME_NAME}); do
    sed -i 's/\('"${THEME_NAME}"'\)/\1-font/g' ${file}
  done
}

echo 'Please back up theme file first unless you know what you are doing.'
sleep 1
THEME_NAME=$(sed -n 's/^Name=\(.*\)/\1/p' metadata.desktop)
echo 'Patching' ${THEME_NAME} '...'

checknames=$(grep -lri 'font\.family')

if [[ $checknames != 'patcher.sh' ]]; then
  echo 'This SDDM Theme already has (partial) changeable font support.'
  echo 'Do you still want to patch it? (y/N)'
  read answer
  case ${answer} in
    y|Y)
      clean
      ;;
    n|N|*)
      echo 'Aborting...'
      exit 100
      ;;
  esac
fi
patch
change_name
