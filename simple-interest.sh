#!/usr/bin/env bash
set -euo pipefail

read -r -p 'Principal amount: ' principal
read -r -p 'Annual rate of interest (%): ' rate
read -r -p 'Time period (years): ' time_period

validate_non_negative_number() {
  local value="$1"
  local label="$2"
  if [[ ! "$value" =~ ^[0-9]+([.][0-9]+)?$ ]]; then
    printf '%s must be a non-negative number.\n' "$label" >&2
    exit 1
  fi
}

validate_non_negative_number "$principal" 'Principal amount'
validate_non_negative_number "$rate" 'Rate of interest'
validate_non_negative_number "$time_period" 'Time period'

interest=$(awk -v principal="$principal" -v rate="$rate" -v time="$time_period" \
  'BEGIN { printf "%.2f", principal * rate * time / 100 }')
printf 'Simple interest: %s\n' "$interest"
