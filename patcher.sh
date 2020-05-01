for file in $(grep -lr 'font.pointSize'); do
  sed -i 's/^\([ \t]*\)\(font\.pointSize.*\)/\1\2\n\1font.family: config.fontFamily/g' ${file}
done

echo 'fontFamily=Arial' >> theme.conf
