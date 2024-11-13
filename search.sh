nev="$1"
found=0

while IFS= read -r -d '' file; do
  if grep -iq "$nev" "$file"; then
    found=1
    top=$(basename "$(dirname "$(dirname "$file")")")
    sub=$(basename "$(dirname "$file")")
    filename=$(basename "$file")

    echo "Top: $top"
    echo "Sub: $sub"
    echo "File: $filename"
    echo ""
  fi
done < <(find root -type f -not -name "*.*" -print0)

if [ "$found" -eq 0 ]; then
  echo "Not found"
fi
