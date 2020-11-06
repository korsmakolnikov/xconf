#!/bin/sh

__usage='
rgs, rg for find and replace!

Usage:
rgs [--help|--dry] {match} {replace} {path}

Options:
  --help                        show this help
  --dry                         dry run
'

if [ $# -eq 0 ]
then
  echo "$__usage"
  exit 1
fi 
   
if [ $1 = "--help" ]
then
  echo "$__usage"
  exit 0
fi

path="."
match=$1
replace=$2

if [ $1 = "--dry" ]
then
  match=$2
  replace=$3

  if [ -z $4 ]
  then
    path=$4
  fi 
  echo "dry run matching $2"
  rg $match $path 
else
  match=$1
  replace=$2

  if [ -z $3 ]
  then
    path=$3
  fi 
  echo "rg --files-with-matches -N $match $path | xargs sed -i \"s/$match/$replace/g\""
  rg --files-with-matches -N $match $path | xargs sed -i "s/$match/$replace/g"
fi 
           


