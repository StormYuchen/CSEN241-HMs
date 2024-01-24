#!/bin/bash

# Sysbench Memory Test Script

# Parameters for Test 1
MEMORY_BLOCK_SIZE_1=1M
TIME_1=30

# Parameters for Test 2
MEMORY_BLOCK_SIZE_2=512K
TIME_2=30

# Function to run a sysbench memory test
run_memory_test () {
  local block_size=$1
  local time=$2
  local iteration=$3

  echo "Running Memory Test: $iteration"
  echo "Memory block size: $block_size"
  echo "Test duration: $time seconds"

  # Run the memory test
  sysbench memory --memory-block-size=$block_size --time=$time run
}

# Run Test 1 five times
for i in {1..5}; do
  run_memory_test $MEMORY_BLOCK_SIZE_1 $TIME_1 "Test 1, Iteration $i"
done

# Run Test 2 five times
for i in {1..5}; do
  run_memory_test $MEMORY_BLOCK_SIZE_2 $TIME_2 "Test 2, Iteration $i"
done

echo "All Memory tests completed."
