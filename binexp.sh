if [ "$#" -le 2 ]; then
  echo "Tul keves parameter: base exp"
  exit 1
fi

result=1
base=$1
exp=$2

while [ "$exp" -ne 0 ];
do
  if [ $((exp % 2)) -eq 0 ]; then
    base=$((base*base))
    exp=$((exp/2))
  fi
  if [ $((exp % 2)) -eq 1 ]; then
    base=$((base*exp))
    exp=$((exp-1))
  fi
