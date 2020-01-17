#!/usr/bin/env zsh

#let script exit if a command fails
set -o errexit 
#let script exit if an unsed variable is used
set -o nounset


function print_info {
    info=$(brew info $1 | sed -n 2p)
    echo "* $1 -- $info"  
}


# only show lines after
# sed -n '/^==> New Formulae$/ { :a; n; p; ba; }' 

# remove all lines after ==> 
# sed -n '/^==>/q;p' 

all_formulas=$(cat)
new_formulas=$(echo $all_formulas | sed -n '/^==> New Formulae$/ { :a; n; p; ba; }'  | sed -n '/^==>/q;p' )
updated_formulas=$(echo $all_formulas | sed -n '/^==> Updated Formulae$/ { :a; n; p; ba; }'  | sed -n '/^==>/q;p' )
deleted_formulas=$(echo $all_formulas | sed -n '/^==> Deleted Formulae$/ { :a; n; p; ba; }'  | sed -n '/^==>/q;p')


echo "# New Formulae"
while IFS= read -r line; do
	print_info $line
done <<< "$new_formulas"
echo ""

echo "# Updated Formulae"
while IFS= read -r line; do
	print_info $line
done <<< "$updated_formulas"
echo ""

echo "# Deleted Formulae"
while IFS= read -r line; do
    echo "* $line"
done <<< "$deleted_formulas"
echo ""
