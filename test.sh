#!/bin/bash

# Function to convert 12-hour format to 24-hour format
convert_to_24_hour() {
    local time=$1
    if [[ $time =~ ^([0-1]?[0-9]|12):([0-5][0-9]) ([AP]M)$ ]]; then
        local hour=${BASH_REMATCH[1]}
        local minute=${BASH_REMATCH[2]}
        local period=${BASH_REMATCH[3]}
        if [[ $period == "PM" && $hour -ne 12 ]]; then
            hour=$((hour + 12))
        elif [[ $period == "AM" && $hour -eq 12 ]]; then
            hour=0
        fi
        printf "%02d:%02d\n" $hour $minute
    else
        echo "Invalid 12-hour format"
    fi
}

# Function to convert 24-hour format to 12-hour format
convert_to_12_hour() {
    local time=$1
    if [[ $time =~ ^([01]?[0-9]|2[0-3]):([0-5][0-9])$ ]]; then
        local hour=${BASH_REMATCH[1]}
        local minute=${BASH_REMATCH[2]}
        if [[ $hour -eq 0 ]]; then
            printf "12:%s AM\n" $minute
        elif [[ $hour -lt 12 ]]; then
            printf "%02d:%s AM\n" $hour $minute
        elif [[ $hour -eq 12 ]]; then
            printf "12:%s PM\n" $minute
        else
            printf "%02d:%s PM\n" $((hour - 12)) $minute
        fi
    else
        echo "Invalid 24-hour format"
    fi
}

# Main script logic
read -p "Enter time (12-hour format, e.g., 02:30 PM or 24-hour format, e.g., 14:30): " input_time

# Check format and convert accordingly
if [[ $input_time =~ ^([0-1]?[0-9]|12):([0-5][0-9]) ([AP]M)$ ]]; then
    echo "Converting from 12-hour format to 24-hour format:"
    convert_to_24_hour "$input_time"
elif [[ $input_time =~ ^([01]?[0-9]|2[0-3]):([0-5][0-9])$ ]]; then
    echo "Converting from 24-hour format to 12-hour format:"
    convert_to_12_hour "$input_time"
else
    echo "Invalid time format. Please enter a valid time."
fi

