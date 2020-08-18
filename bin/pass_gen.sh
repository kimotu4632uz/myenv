#!/bin/bash -e

while getopts 'anl:s:h' OPT; do
  case $OPT in
    a) alonly=true ;;
    n) numonly=true ;;
    l) length=$OPTARG ;;
    s) set=$OPTARG ;;
    h) echo "Usage: pass_gen [-a] [-n] [-s string_set] [-l length]"; exit 0 ;;
    *) exit 1 ;;
  esac
done

alonly="${alonly:-false}"
numonly="${numonly:-false}"
length="${length:-10}"

if "$alonly"; then
  cat /dev/urandom | tr -dc '[:alpha:]' | fold -w $length | head -1
elif "$numonly"; then
  cat /dev/urandom | tr -dc '[:digit:]' | fold -w $length | head -1
elif [ "$set" != "" ]; then
  cat /dev/urandom | tr -dc "$set" | fold -w $length | head -1
else
  cat /dev/urandom | tr -dc '[:graph:]' | fold -w $length | head -1
fi