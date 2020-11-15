# usage: ./date.sh day-of-month month year
# example: ./date.sh 31 10 2020
# 
MONTH=$2
DAY=$1
YEAR=$3
for (( day=1; day<=$DAY; day++ ))
do
# pad day to have leading zero
  paddedDay=$(printf "%02d" $day)
# download html page and extract relevant line 
  TEXT=$(curl -s "https://www.proplanta.de/wetter/tübingen_rueckblick_${paddedDay}-${MONTH}-${YEAR}_wetter.html" | grep Temperatur -A 3  | head -n 2 | tail -n 1)
# extract temperature from line
  TEMP=$(echo ${TEXT:300} | sed 's/.*SCHRIFT_FORMULAR_WERTE_MITTE..\([^ ]*\).*/\1/')
# echo in csv format for imnport into sheet
  echo "$day-$MONTH-$YEAR;$TEMP"
done
# TEXT=$(curl -s "https://www.proplanta.de/wetter/tübingen_rueckblick_${DAY}-${MONTH}-${YEAR}_wetter.html" | grep Temperatur -A 3  | head -n 2 | tail -n 1)
# TEMP=$(echo ${TEXT:300} | sed 's/.*SCHRIFT_FORMULAR_WERTE_MITTE..\([^ ]*\).*/\1/')
# echo "$DAY-$MONTH-$YEAR;$TEMP"
