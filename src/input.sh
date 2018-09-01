# vim: filetype=sh

in::escape() {
   local tmp=""
   IFS='\n'
   for i in $@; do
      tmp="$tmp $(echo "$i" | tr -s ' ' "$SPACE_REPRESENTATION")"
   done
   echo "$tmp"
}

in::expand_dashes() {
   awk '{ 
      for (i = 1; i <= NF; ++i) { 
         if ($i ~ /^\-[a-zA-Z]/) 
            $i=gensub(/(.)/, "-\\1 ", "g", substr($i, 2, length($i))) 
      } 
      print $0
   }' \
      | str::trim
}

in::extract_dashes() {
   awk -v doco="$1" '{ 
      for (i = 1; i <= NF; ++i) { 
         if ($i ~ /^\-/) {
            pos_arg_regex="\\"$i".*<"
               if (doco ~ pos_arg_regex)  {
                  opts=opts$i" "$(i+1)"\n"
                     $i=""
                     $(i+1)=""
               } else {
                  opts=opts$i" true\n"
                     $i=""
               }
         }
      }
   };
   { print $0; print opts; }'
}

in::without_command_name() {
   awk '{ $1=""; $2="\b"$2; print $0 }'
}

in::vars() {
   local readonly input="$1"
   local readonly match="$2"

   echo -e "$match\n$input" \
      | str::transpose
}
