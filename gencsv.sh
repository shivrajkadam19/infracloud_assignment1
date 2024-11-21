#!/bin/bash
# Script to generate a CSV file with specified indices
start=$1
end=$2
output_file="inputFile"

# Validate input
if [[ -z "$start" || -z "$end" || "$start" -ge "$end" ]]; then
    echo "Usage: ./gencsv.sh <start_index> <end_index>"
    exit 1
fi

# Generate file
> "$output_file"
for ((i=start; i<=end; i++)); do
    echo "$i, $((RANDOM % 500))" >> "$output_file"
done
echo "File $output_file generated successfully."
