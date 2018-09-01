# vim: filetype=sh

out::usage_vars() {
   local readonly usage="$1"
   echo "$usage" \
      | grep -Eo "[$rv2]+" \
      | grep -v "<"
}

out::match_vars() {
   local readonly input="$1"
   local readonly match="$2"

   echo -e "$match\n$input" \
      | mtx::transpose
}

out::options_defaults() {
   local readonly opts="$1"

   echo "$opts" \
      | grep -Eo "\-\-[${rv}]*"

   echo "$opts" \
      | grep -Eo "\-\-[${rv}]*"
}

out::add_equal_sign_plus_hacks() {
   awk -v sr="$SPACE_REPRESENTATION" '{ 
      if ($2 == "") 
         $2="false"
      else if (index($1, "|") != 0) 
         $1=$2
      if ($2 == $1) 
         $2="true"
      if ($2 ~ sr)
         $2="\""gensub(sr," ","g",$2)"\""
      print $1"="$2";" 
   }'
}

out::remove_strange_chars() {
   sed -E 's/(<|>|\-\-)//g'
}

out::maximize_options() {
   local readonly opts="$1"
   local readonly sed_args="$(opt::dash_conversion_sed_args "$opts")"
   sed "$sed_args"
}

out::echo() {
   echo "echo -e \"$1\""
}
