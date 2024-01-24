#!/bin/bash

# Sysbench File IO Test Script

# Parameters for Test 1
NUM_THREADS_1=4
FILE_TOTAL_SIZE_1=2G
FILE_TEST_MODE_1=rndwr

# Parameters for Test 2
NUM_THREADS_2=8
FILE_TOTAL_SIZE_2=5G
FILE_TEST_MODE_2=rndwr

# Function to run a sysbench fileio test
run_test () {
  local num_threads=$1
  local file_total_size=$2
  local file_test_mode=$3
  local iteration=$4

  echo "Running File IO Test: $iteration"
  echo "Number of threads: $num_threads"
  echo "Total file size: $file_total_size"
  echo "File test mode: $file_test_mode"

  # Prepare the file IO test
  sysbench --num-threads=$num_threads fileio --file-total-size=$file_total_size --file-test-mode=$file_test_mode prepare

  # Run the file IO test
  sysbench --num-threads=$num_threads fileio --file-total-size=$file_total_size --file-test-mode=$file_test_mode run

  # Cleanup after the file IO test
  sysbench --num-threads=$num_threads fileio --file-total-size=$file_total_size --file-test-mode=$file_test_mode cleanup
}

# Run Test 1 five times
for i in {1..5}; do
  run_test $NUM_THREADS_1 $FILE_TOTAL_SIZE_1 $FILE_TEST_MODE_1 "Test 1, Iteration $i"
done

# Run Test 2 five times
for i in {1..5}; do
  run_test $NUM_THREADS_2 $FILE_TOTAL_SIZE_2 $FILE_TEST_MODE_2 "Test 2, Iteration $i"
done

echo "All File IO tests completed."
