#!/bin.sh
echo $1 >g2u
iconv -f gb2312 -t UTF-8 -c g2u -o g2u1 && rm -f g2u && cat g2u1 && rm -f g2u1
