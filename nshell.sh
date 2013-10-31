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
#/ 
#/ comment standard per function:
#/ name:
#/ usage:
#/ desc:
#/ usage as:
#/ params:
#/ return:


#/ name: space_fill()
#/ usage: space_fill [total length expected] [value to space fill] [side left|right]
#/ desc: fill with left or right spaces to complete length expected. Remember "quotes in the call"
#/ example: foovar="$(space_fill 12 left 'string' )"; echo "$foovar" 
#/ params: int len, string <left|right>, string value
#/ return: string with the spaces fill expected
space_fill()
{
    len=$1
    shift
    side=$1
    shift
    value="$@"
    len=$(expr $len - ${#value})
    spaces=''
    x=0             
    while [ $x -lt $len ]
    do
        spaces="$spaces "
        x=$(expr $x + 1)
    done
    side=$(lower $side)
    if [[ $side == 'left' ]]; then
        echo "${spaces}${value}"
    else
        echo "${value}${spaces}"
    fi
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
    x=0         
    while [ $x -lt $len ]
    do
        zeroes=${zeroes}'0'
        x=$(expr $x + 1)
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
    [[ $# -lt $argsc ]] && usage $message
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

lower()
{
    echo "$@" | tr '[:upper:]' '[:lower:]'
}

upper()
{
    echo "$@" | tr '[:lower:]' '[:upper:]'
}

#/ name: file_exist()
#/ usage: file_exist [file_path]
#/ desc: check if exist file passed as param.
#/ usage as: call as $() shell exec
#/ params: string
#/ return: string
file_exist()
{
	[[ -f $1 ]] && echo 'YES' || echo 'NOT'
}

#: checks if proc passed as argument runs.
#: returns string
#: call as $() shell exec
running()
{
	ret=$(ps auxw |grep -i "$1" |grep -v grep|wc -l |tr -d ' ')
	[[ $ret -gt 0 ]] && echo 'YES' || echo 'NOT'
}

#:
#: find string in a file both passed as argument.
#: returns string
#: call as $() shell exec
find_string_in_file()
{
	if [[ -f $2 ]]; then
		grep -v "^#" $2 | grep -i "$1" > /dev/null 2>&1 
		[[ $? -eq 0 ]] && echo 'YES' || echo 'NOT'
	else
		echo 'NOT'
	fi
}

get_os_name()
{
    echo $(uname -s)
}

get_color()
{
    case "$1" in
        "black")
            color="\033[0;30m" 
            ;;
        "red")
            color="\033[0;31m"
            ;;
        "green")
            color="\033[0;32m"
            ;;
        "yellow")
            color="\033[0;33m"
            ;;
        "blue")
            color="\033[0;34m"
            ;;
        "magenta")
            color="\033[0;35m"
            ;;
        "cyan")
            color="\033[0;36m"  
            ;;
        "white")
            color="\033[0;37m" 
            ;;
        *)
            color="\033[0m"
            ;;
    esac
    echo $color
}

color_string()
{
    color=$(get_color $1)
    no_color=$(get_color none)
    str=$2
    if [[ $(get_os_name) == 'Linux' ]]; then
        echo -e "${color}${str}${no_color}"
    else
        echo "${color}${str}${no_color}" 
    fi
}
