#!/usr/bin/env bash
# download assert.sh
# 
. ./nshell.sh
. ./assert.sh

assert "space_fill"
assert "zero_fill"
assert "timestamp" ""
assert "get_date" "d{4}-d{2}-d{2}"
assert "usage hola" "Usage: hola"
assert_raises "usage hola" 1
assert "check_for_cli_args 2 $@" 0 
assert "require_user user" 1
assert "exit_message TDD" "TDD"
assert_raises "exit_message TDD" 1
assert "trim ' hola '" "hola"
assert "rtrim ' hola '" " hola"
assert "ltrim ' hola '" "hola "
assert "lower LOWER" "lower"
assert "upper upper" "UPPER"
assert "file_exist ./assert.sh" "YES"
assert "running $0" "YES"
assert "iam_running test_nshell.sh" "NOT"
assert "get_os_name" "Linux"
assert "find_string_in_file trim nshell.sh" "YES"
assert "continue_question" " Do you want continue? (y/n)? " "y"
assert_raises "continue_question" 0 "y"
assert_raises "continue_question" 1 "n"
#assert "get_color red" "\033[0;31m"
assert "color_string red hola" "\033[0;31mhola\033[0m"


assert_end
