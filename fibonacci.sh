if [ "$#" -eq 0 ]; then
  echo "Tul keves parameter"
  exit 1
fi

n="$1"

if [ "$n" -eq 1 ]; then
  echo "0"
  exit 0
fi

if [ "$n" -eq 2 ]; then
  echo "1"
  exit 0
fi

a=0
b=1
temp=3

while [ "$temp" -lt "$n" ] || [ "$temp" -eq "$n" ]; do
  c=$((a+b))
  a=$b
  b=$c
  temp=$((temp+1))
done

echo "Fibonacci szam: $c"
