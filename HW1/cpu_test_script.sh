#!/bin/bash

# Sysbench CPU Test Script

# Parameters for Test 1
NUM_THREADS_1=1
CPU_MAX_PRIME_1=10000
MAX_TIME_1=10

# Parameters for Test 2
NUM_THREADS_2=4
CPU_MAX_PRIME_2=100000
MAX_TIME_2=30

# Run Test 1
for i in {1..5}
do
    echo "Running Test 1, iteration $i..."
    sysbench --test=cpu --num-threads=$NUM_THREADS_1 --cpu-max-prime=$CPU_MAX_PRIME_1 --max-time=$MAX_TIME_1 run
done

# Run Test 2
for i in {1..5}
do
    echo "Running Test 2, iteration $i..."
    sysbench --test=cpu --num-threads=$NUM_THREADS_2 --cpu-max-prime=$CPU_MAX_PRIME_2 --max-time=$MAX_TIME_2 run
done

echo "All tests completed."
