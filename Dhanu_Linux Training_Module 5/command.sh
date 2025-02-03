#!/bin/bash

error() {
	echo "$@" >> error.log
	echo "$@" >&2
}

recursive() {
	local direc="$1"
	local keyword="$2"
	find "$dir" -type f -print0 | while IFS= read -r -d $'\0' file; do
	if grep -q "$keyword" "$file"; then
		echo "Found '$keyword' in: 'file'"
	fi
	done
}

search(){
local file="$1"
local keyword="$2"
if grep -q "$keyword" <<< "$(< "$file" )"; then
echo "Found '$keyword' in: '$file'"
fi
}




display_help() {
cat << EOF
Usage: $0 [options]

Options:
  -d <directory>  Directory to search recursively.
  -k <keyword>    Keyword to search for.
  -f <file>       File to search directly.
  --help          Display this help menu.

Examples:
  $0 -d logs -k error      Recursively search 'logs' directory for 'error'.
  $0 -f script.sh -k TODO  Search 'script.sh' for 'TODO'.
  $0 --help             Display this help menu.
EOF
}

validate() {
  local file="$1"
  local keyword="$2"

  if [[ -z "$keyword" ]]; then
      error "Error: Keyword cannot be empty."
      return 1
  fi
  
  if [[ ! -d "$file" && ! -f "$file" ]]; then
      error "Error: '$file' is not a valid file or directory."
      return 1
  fi

  return 0
}



if [[ "$#" -eq 0 ]]; then  
  display_help
  exit 0
fi

if [[ "$@ " == *"--help"* ]]; then
    display_help
    exit 0
fi


while getopts ":d:k:f:" opt; do
  case "$opt" in
    d) directory="$OPTARG" ;;
    k) keyword="$OPTARG" ;;
    f) file="$OPTARG" ;;
    \?) error "Invalid option: -$OPTARG" ; exit 1 ;;
    :) error "Option -$OPTARG requires an argument." ; exit 1 ;;
  esac
done

if [[ -n "$directory" && -n "$keyword" ]]; then
    if validate "$directory" "$keyword"; then
        recursive "$directory" "$keyword"
    else
        exit 1
    fi
elif [[ -n "$file" && -n "$keyword" ]]; then
    if validate "$file" "$keyword"; then
        search "$file" "$keyword"
    else
        exit 1
    fi
else
  error "Error: Invalid arguments.  Use '--help' for usage instructions."
  exit 1
fi

exit 0
