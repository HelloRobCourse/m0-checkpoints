#!/bin/bash
# Quit on error.
set -e

DESIRED_RESULT=46

# Build command.
g++ mathler.cpp -o mathler

# Check the result.
result=$(./mathler)

echo "Code generated result: $result"
echo "Running checks..."
echo

# Check if result contains an equals sign
if [[ "$result" != *"="* ]]; then
  echo "Error: Output does not contain an equation."
  exit 1
fi

# Variable to keep track of passed or failed tests.
FAIL=0

# Split the output into equation part and result part
equation=$(echo $result | cut -d'=' -f1)
expected_result=$(echo $result | cut -d'=' -f2)

# Check if the equation part has exactly 8 characters
if [ ${#equation} -ne 8 ]; then
  echo "Error: The equation has ${#equation} characters, but should have exactly 8."
  FAIL=1
fi

# Check if the equation part has exactly 8 characters
if [ "$expected_result" -ne "$DESIRED_RESULT" ]; then
  echo "Error: The result of the equation is $expected_result, but should be $DESIRED_RESULT."
  FAIL=1
fi

# Calculate real result
real_result=$(($equation))

# Compare the results
if [ "$real_result" -ne "$expected_result" ]; then
    echo "Error: The result of the equation is $equation=$real_result, but the code prints $expected_result."
    FAIL=1
fi

echo
if [ $FAIL -eq 1 ]; then
    echo "Mathler failed :( Try again!"
    exit 1
else
    echo "Mathler test succeeded!"
fi
