#!/bin/bash

echo "Question-1 : The number of ORFs found is given in the Question-2 Part-B Answer!"

echo "Question-2 Part-A :"

function Count_ATGC () {
    fasta=$(<$1)
    fasta_len=${#fasta}
    dna_count=0
    printf "DNA number: 1 \n"
    
    for ((i = 0; i < fasta_len; i++)); do
    char="${fasta:i:1}"
    if [[ $char == ">" ]]; then
      dna_count=$((dna_count + 1))
      if [ $dna_count -gt 1  ]; then
      printf "  A_count = $A, T_count = $T, G_count $G, C_count = $C \n"
      
      printf "DNA number: $((dna_count)) \n"
      fi
    fi
    if [[ "${fasta:i:4}" == "mRNA" ]]; then
      A=-1
      T=0
      G=0
      C=0
    fi
    if [ "${fasta:i:1}" == "A" ]; then
      A=$((A + 1))
    fi
    if [ "${fasta:i:1}" == "T" ]; then
      T=$((T + 1))
    fi
    if [ "${fasta:i:1}" == "G" ]; then
      G=$((G + 1))
    fi
    if [ "${fasta:i:1}" == "C" ]; then
      C=$((C + 1))
    fi
    done
    printf "  A_count = $A, T_count = $T, G_count $G, C_count = $C \n"
    printf "Final dna_count = $dna_count \n"
}

Count_ATGC fasta_file.txt

echo "Question-2 Part-B :"


function Codons () {
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

}

Codons fasta_file.txt
