str::transpose() {
  cat | awk '
  {
      for (i=1; i<=NF; i++)  {
          a[NR,i] = $i
      }
  }
  NF>p { p = NF }
  END {
      for(j=1; j<=p; j++) {
          str=a[1,j]
          for(i=2; i<=NR; i++){
              str=str" "a[i,j];S
          }
          print str
      }
  }'
}

str::column() {
  cat | column -t
}

str::trim() {
  awk '$1=$1'
}

str::remove_blank_lines() {
  awk 'NF'
}
