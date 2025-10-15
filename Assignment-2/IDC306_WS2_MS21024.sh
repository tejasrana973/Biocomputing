#!/bin/bash

echo "Question-1 :"
addition() {
    echo "Enter the first number:"
    read num1
    echo "Enter the second number:"
    read num2
    result=$(echo "$num1 + $num2" | bc)
    echo "Result of $num1 + $num2 = $result"
}

subtraction() {
    echo "Enter the first number:"
    read num1
    echo "Enter the second number:"
    read num2
    result=$(echo "$num1 - $num2" | bc)
    echo "Result of $num1 - $num2 = $result"
}

echo "Welcome to the calculator program!"
echo "Choose an operation:"
echo "1. Addition"
echo "2. Subtraction"
echo "3. Quit"
    
read choice
    
case $choice in
    1) addition ;;
    2) subtraction ;;
    3) echo "Exiting the calculator program."; exit ;;
    *) echo "Invalid choice. Please enter 1, 2, or 3." ;;
esac


echo "Question-2 :"

is_palindrome() {
    local string="$1"
    local length=${#string}
    local reversed_string=""
    
    for (( i=length-1; i>=0; i-- )); do
        reversed_string="${reversed_string}${string:$i:1}"
    done
    
    if [ "$string" = "$reversed_string" ]; then
        echo "The string '$string' is a palindrome."
    else
        echo "The string '$string' is not a palindrome."
    fi
}

read -p "Enter a string: " input_string
is_palindrome "$input_string"


echo "Question-3 :"

#fasta=$(<fasta.file.txt)
while IFS= read -r line; do
    if [[ $line == ">"* ]]; then
        echo "$line"
    else
        complement=""
        for (( i=0; i<${#line}; i++ )); do
            char="${line:$i:1}"
            case $char in
                A) complement+="T" ;;
                T) complement+="A" ;;
                G) complement+="C" ;;
                C) complement+="G" ;;
                *) complement+="$char" ;;
            esac
        done
        echo $complement
    fi
done < "$1"

printf "\n"
echo "Question-4 :"

fasta_file="$1"
sequence=""
while read -r line
do
    if [[ "$line" != ">"* ]]; then
        sequence="$sequence$line"
    fi
done < "$fasta_file"

sequence=$(echo "$sequence" | tr -d '\n')

start_codons=("ATG" "GTG")
stop_codons=("TAG" "TAA" "TGA")

k=0
for (( i = 0; i < ${#sequence}; i+=1 )); do
    codon="${sequence:$i:3}"
    if [[ " ${start_codons[@]} " =~ " $codon " ]]; then
        for (( j = i+3; j < ${#sequence}; j+=1 )); do
            codon="${sequence:$j:3}"
            if [[ " ${stop_codons[@]} " =~ " $codon " ]]; then
                ORF="${sequence:$i:$(($j-$i+3))}"
                echo "Found ORF: $ORF"
                ((k++))
                break
            fi
        done
    fi
done
echo 'Number of ORFs found: ' $k












