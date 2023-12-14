#!/bin/bash

set -f

while IFS= read -r sentence; do
    specials=()
    read -ra parts <<< "$sentence"
    
    for part in "${parts[@]}"; do
        if [ "$part" == "#" ] || [ "$part" == "$" ] || [ "$part" == "*" ] || [ "$part" == "@" ]; then
            specials+=("$part")
        fi
    done
    
    ans=()
    j=0
    
    for ((i=${#parts[@]}-1; i>=0; i--)); do
        if [ "${parts[i]}" == "#" ] || [ "${parts[i]}" == "$" ] || [ "${parts[i]}" == "*" ] || [ "${parts[i]}" == "@" ]; then
            ans+=("${specials[j]}")
            j=$((j + 1))
        else
            ans+=("${parts[i]}")
        fi
    done
    
    while [ $j -lt ${#specials[@]} ]; do
        ans+=("${specials[j]}")
        ans+=" "
        j=$((j + 1))
    done
    
    echo "${ans[@]}"

done < "$1"

set +f