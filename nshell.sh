#!/usr/bin/env bash
#/ nShell eNgine shell scripting framework
#/ author: Jorge A. Medina.
#/ repository: https://github.com/mnothic/nshell
#/ license: BSD
#/ version: 0.1
#/ first version: 2013-10-24
#/ last modification: 2013-10-27
#/ ksh include form as . /path/to/nshell.sh
#/ bash include form as source /path/to/nshell.sh
#/ before include script set an alias soruce=.
#/ and it's work in bash and ksh
#/ comment standard per function
#/ 
#/ name:
#/ usage:
#/ desc:
#/ usage as:
#/ params:
#/ return:


#/ name: space_fill()
#/ usage: space_fill [total length expected] [value to space fill] [side left|right]
#/ desc: fill with left or right spaces to complete length expected. Remember "quotes in the call"
#/ example: foovar="$(space_fill 12 'string' left)"; echo "$foovar" 
#/ params: int len, string value, string <left|right>
#/ return: string with the spaces fill expected
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

#/ name: zero_fill()
#/ usage: zero_fill [total length expected] [value to zero fill]
#/ desc: fill with left zeroes to complete length expected.
#/ example: foovar=$(zero_fill 3 1)
#/ params: int len, int value
#/ return: string only digit with the length required
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

#/ name: timestamp()
#/ usage: timestamp
#/ desc: get standard timestamps
#/ usage as: my_ts=$(timestamp)
#/ params: none
#/ return: string with "+%Y-%m-%d %H:%M:%S"
timestamp()
{
    echo $(date "+%Y-%m-%d %H:%M:%S")
}

#/ name: get_date()
#/ usage: get_date
#/ desc: get standard no spaces get_date
#/ usage as: now=$(get_date)
#/ params: none
#/ return: string with "+%Y-%m-%d"
get_date()
{
    echo $(date "+%Y-%m-%d")
}

#/ name: usage()
#/ usage: usage <message help>
#/ desc: exit the script and display message
#/ usage as: usage <message>
#/ params: string
#/ return: exit or none
usage()
{
    echo "Usage: $0 $1"
    exit 1
}

#/ name: check_for_cli_args()
#/ usage: check_for_cli_args [args length expected] [exit message for usage display] [array args]
#/ desc: valides the args lengs required to works in the script calls
#/ usage as: check_for_cli_args 2 "<val_1> <val_2> $@"
#/ params: int argsc, string msg
#/ return: exit if fail or none.
check_for_cli_args()
{
    argsc=$1
    shift
    message=$1
    shift
    if [ $# -lt $argsc ] ; then
        usage $message
        exit 1
    fi
}

#/ name: continue_question()
#/ usage: continue_question
#/ desc: this function stop execution process and interact with executor for continue or not
#/ returns 0 to continue and 1 if not
#/ usage as: continue_question; [[ $? -eq 0 ]] && continue || exit 0
#/ params: none
#/ return: unsigned int
continue_question()
{
    while [ true ]
    do
        echo -e " Do you want continue? (y/n)? \c "
        read r
        case $r in
            y) return 0 ;;
            n) return 1 ;;
            *) echo "Use: s/n"
               sleep 1 ;;
        esac
        clear
    done
}

#/ name: require_user()
#/ usage: require_user user1 user2 ... userN
#/ desc: if the user who launches the script not be in the list stop the script
#/ usage as: requiere_user user ... userN
#/ params: string $@
#/ return: none or exit.
require_user()
{
    sw=0
    for user in $@; do
        id |awk '{print $1}'| grep $user > /dev/null 2>&1
        [[ $? -eq 0 ]] && sw=1
    done
    if [ $sw -eq 0 ]; then
        echo -e " para ejecutar este script, Ud. debe ser uno de estos usuarios ($@)."
        exit 1
    fi
}

#/ name: trim()
#/ usage: trim $string_to_trim
#/ desc: this trim white space both side of string
#/ usage as: clean_var=$(trim " hola mundo ") $clean_var="hola mundo"
#/ params: string
#/ return: string
trim()
{
    echo "$@" | sed -e 's/^ *//g' -e 's/ *$//g'
}

#/ name: rtrim()
#/ usage: rtrim $string_to_trim
#/ desc: this trim white space right side of string
#/ usage as: clean_var=$(rtrim " hola mundo ") $clean_var=" hola mundo"
#/ params: string
#/ return: string
rtrim()
{
    echo "$@" | sed 's/ *$//g'
}

#/ name: ltrim()
#/ usage: ltrim $string_to_trim
#/ desc: this trim white space left side of string
#/ usage as: clean_var=$(ltrim " hola mundo ") $clean_var="hola mundo "
#/ params: string
#/ return: string
ltrim()
{
    echo "$@" | sed 's/^ *//g'
}
