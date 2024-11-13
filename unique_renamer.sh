> unique_usernames.txt

declare -A name_counts

while IFS= read -r line; do
  base_name="${line%%#*}"
  if [[ ${name_counts["$base_name"]+_} ]]; then
    new_name="${base_name}_${name_counts[$base_name]}"
    name_counts["$base_name"]=$((name_counts[$base_name]+1))
  else
    new_name="$base_name"
    name_counts["$base_name"]=1
  fi
  echo "$new_name" >> unique_usernames.txt
done < usernames.txt

echo "megvan"
