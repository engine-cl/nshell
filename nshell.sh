#!/usr/bin/env bash
#: nShell eNgine shell scripting framework
#: author: Jorge A. Medina.
#: license: BSD
#: version: 0.1
#: first version: 2013-10-24
#: last modification: 2013-10-24
#:
#:
#:
#: comment standard per function
#: 
#: name:
#: usage:
#: desc:
#: usage as:
#: params:
#: return:


#: name: space_fill()
#: usage: space_fill [total length expected] [value to space fill] [side left|right]
#: desc: fill with left or right spaces to complete length expected. Remember "quotes in the call"
#: example: foovar="$(space_fill 12 'string' left)"; echo "$foovar" 
#: params: int len, string value, string <left|right>
#: return: string with the spaces fill expected
space_fill()
{
    value=$2
    side=$3
    len=$(expr $1 - ${#value})
    spaces=''
    for i in $(seq $len)
    do
        spaces=${spaces}' '
    done
    declare $side="$spaces"
    echo "${left}${value}${right}"
}

#: name: zero_fill()
#: usage: zero_fill [total length expected] [value to zero fill]
#: desc: fill with left zeroes to complete length expected.
#: example: foovar=$(zero_fill 3 1)
#: params: int len, int value
#: return: string only digit with the length required
zero_fill()
{
    value=$2
    len=$(expr $1 - ${#value})
    zeroes=''
    for i in $(seq $len)
    do
        zeroes=${zeroes}'0'
    done
    echo "${zeroes}${value}"
}

#: name: timestamp()
#: usage: timestamp
#: desc: get standard timestamps
#: usage as: my_ts=$(timestamp)
#: params: none
#: return: string with "+%Y-%m-%d %H:%M:%S"
timestamp()
{
    echo $(date "+%Y-%m-%d %H:%M:%S")
}

#: name: get_date()
#: usage: get_date
#: desc: get standard no spaces get_date
#: usage as: now=$(get_date)
#: params: none
#: return: string with "+%Y-%m-%d"
get_date()
{
    echo $(date "+%Y-%m-%d")
}

#: name: usage()
#: usage: 
#: desc:
#: usage as:
#: params:
#: return:
usage()
{
    echo "Usage: $0 $1"
    exit 1
}

#: name: check_for_cli_args()
#: usage: check_for_cli_args [args length expected] [exit message for usage display] 
#: desc: valides the args lengs required to works in the script calls
#: usage as: check_for_cli_args 2 "<val_1> <val_2"
#: params: int argsc, string msg
#: return: exit if fail or none.
check_for_cli_args()
{
    argsc=$1
    message=$2
    if [ $# -lt $argsc ] ; then
        usage $message
        exit 1
    fi
}
