#!/bin/sh
cp -ra ../autobuild .
find autobuild -type f|awk '{print "'\''"$0"'\''"}'|xargs ls -t |tail -n 364|awk '{print "'\''"$0"'\''"}'|xargs rm 
