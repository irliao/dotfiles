#!/bin/bash

# Stocks price info from Yahoo Finance

# specify which stocks you want to monitor here
stocks=('INTU' 'AAPL' 'GOOGL' 'AMZN')

# this function is to shuffle the elements of an array in bash
shuffle() {
   local i tmp size max rand
   for ((i=size-1; i>0; i--)); do
      size=${#stocks[*]}
      max=$(( 32768 / size * size ))
      rand=$(( RANDOM ))
      while (( rand >= max )); do 
        rand=$(( RANDOM )); 
      done
      rand=$(( rand % (i+1) ))
      tmp=${stocks[i]} stocks[i]=${stocks[rand]} stocks[rand]=$tmp
   done
}
shuffle

s='http://download.finance.yahoo.com/d/quotes.csv?s=stock_symbol&f=l1'

n=${#stocks[*]}
# n=$((n-1))

for (( c=1; c<=n; c++ ))
do
	echo -n "${stocks[$c]}"; echo -n ":"; curl -s echo "${s/stock_symbol/${stocks[$c]}}"

   # experimental: also log to disk
   # echo -n $(date) >> stock_history.txt;  echo -n "  " >> stock_history.txt; echo -n ${stock[$c]} >> stock_history.txt; echo -n ":" >> stock_history.txt; curl -s echo ${s/stock_symbol/${stocks[$c]}} >> stock_history.txt

done
