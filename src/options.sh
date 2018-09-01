# vim: filetype=sh

opt::dash_conversion_sed_args() {
   local readonly opts="$1"

   echo "$opts" \
      | grep -Eo '\-.*?(\s\s|$|<)' \
      | tr '<' ' ' \
      | awk '{ 
         if (length($1) > length($2)) {
            t=$2; $2=$1; $1=t;
         } 
         print $0 
      }' \
      | tr '-' ' ' \
      | awk '{ print "s/^\\-"$1"/"$2"/g;" }' \
      | xargs
}

opt::from_doc() {
   awk '{
      if ($1 ~ /ptions/) should_print=1;
      else if (should_print && NF == 0) exit;
      else if (should_print) print $0;
   }'
}

opt::remove_description() {
   sed -E 's/(\s\s.*$)//g'
}

opt::defaults() {
   echo "$1" | awk '{
      if ($NF ~ /\]$/) 
         print $1, substr($NF, 0, length($NF)-1)
   }'
}
