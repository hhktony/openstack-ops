#!/usr/bin/env bash
#  Filename: clean.sh
#   Created: 2016-03-21 10:52:51
#      Desc: TODO (some description)
#    Author: xutao(Tony Xu), hhktony@gmail.com
#   Company: myself

function nova_clean()
{
    nova list | awk '{if($2!="ID" && $2!="") print $2}' | xargs nova delete
}
