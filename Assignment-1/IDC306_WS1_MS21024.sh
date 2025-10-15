echo Question-1 :
#!/bin/bash

echo "Hello World"

Name="Who?"
Password="Chipi chipi"

read -p "Enter username: " i
read -p "Enter password: " j
echo

if [[ $i == $Name ]]; then
 if [[ $j == $Password ]]; then
   echo "Login successful. Welcome, $Name!"
 else
   echo "Login failed. Invalid Password."
 fi
else
 if [[ $j == $Password ]]; then
   echo "Login failed. Invalid Username."
 else
   echo "Login failed. Invalid both Username & Password."
 fi
fi

echo Question-2 :

Name="Who?"
Password="joe"

attempts=0
max_attempts=3

while [ $attempts -lt $max_attempts ]; do
   
    read -p "Enter Username: " i
    read -p "Enter Password: " j
    echo

    if [[ "$i" = "$Name" ]] ; then
        if [[ "$j" = "$Password" ]]; then
            echo "Login successful! Welcome $Name!"
            break 
        else
            echo "Incorrect password. Please try again."
        fi
    else
        if [[ "$j" = "$Password" ]]; then
            echo "Incorrect username. Please try again."
        else
            echo "Both username & password are invalid. Please try again."
        fi
    fi
    
    attempts=$((attempts + 1)) 
    if [ $attempts -lt $max_attempts ]; then
        echo "You have $(($max_attempts - attempts)) attempts remaining."
    fi
done

if [ $attempts -ge $max_attempts ]; then
    echo "You have exceeded the maximum number of attempts. Access denied."
fi



echo Question-3 :

start=1
read -p "Enter the end number: " end

sum_even=0
sum_odd=0

for ((i=start; i<=end; i++)); do
    if ((i % 2 == 0)); then
        sum_even=$((sum_even + i))
    else
        sum_odd=$((sum_odd + i))
    fi
done

echo "The sum of even numbers from $start to $end: $sum_even"
echo "The sum of odd numbers from $start to $end: $sum_odd"

echo Question-4 :

fasta=$(<fasta.file.txt)
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



