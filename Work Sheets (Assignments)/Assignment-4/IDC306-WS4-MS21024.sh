#!/bin/bash

#fasta_file="$1"
echo "Question-1 :"

Question1 () {
    local sequences=()

    while IFS= read -r line; do
        if [[ "$line" != ">"* ]]; then
            sequence="$sequence$line"
        elif [ -n "$sequence" ]; then
            sequences+=("$sequence")
            sequence=""
        fi
    done < $1

    if [ -n "$sequence" ]; then
        sequences+=("$sequence")
    fi

    for sequence in "${sequences[@]}"; do
        echo "Sequence ((+) strand): $sequence"
        find_composition "$sequence"

        echo "ORFs found in (+) strand:"
        find_orfs "$sequence"

        complement_sequence=$(get_complement "$sequence")
        echo "(-) strand: $complement_sequence"

        echo "ORFs found in (-) strand:"
        find_orfs "$complement_sequence"

        echo
    done
}

find_composition() {
    local sequence="$1"
    local total_length=${#sequence}
    local count_A=$(grep -o 'A' <<<"$sequence" | wc -l)
    local count_T=$(grep -o 'T' <<<"$sequence" | wc -l)
    local count_G=$(grep -o 'G' <<<"$sequence" | wc -l)
    local count_C=$(grep -o 'C' <<<"$sequence" | wc -l)

    local percent_A=$((count_A * 100 / total_length))
    local percent_T=$((count_T * 100 / total_length))
    local percent_G=$((count_G * 100 / total_length))
    local percent_C=$((count_C * 100 / total_length))

    echo "Composition (in percentage):"
    echo "A: $percent_A%"
    echo "T: $percent_T%"
    echo "G: $percent_G%"
    echo "C: $percent_C%"
}

find_orfs() {
    local sequence="$1"
    local codon_length=3
    local min_orf_length=20
    local orf_count=0

    start_codon="ATG"
    stop_codons=("TAA" "TAG" "TGA")

    for ((i = 0; i < ${#sequence}; i+=codon_length)); do
        codon="${sequence:$i:$codon_length}"
        if [ "$codon" = "$start_codon" ]; then
            for ((j = i + min_orf_length; j < ${#sequence}; j+=codon_length)); do
                codon="${sequence:$j:$codon_length}"
                if [[ " ${stop_codons[@]} " =~ " $codon " ]]; then
                    ORF="${sequence:$i:$(($j - $i + codon_length))}"
                    echo "Found ORF: $ORF"
                    ((orf_count++))
                    break
                fi
            done
        fi
    done

    echo "Number of ORFs found: $orf_count"
}

get_complement() {
    local sequence="$1"
    echo "$sequence" | tr 'ATGC' 'TACG' | rev
}

Question1 fasta_file.txt
