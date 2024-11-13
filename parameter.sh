x=$#
osszeg=0

for i in $(seq $x); 
do
osszeg=$(expr $osszeg + $1)
shift
shift
done

echo $osszeg
