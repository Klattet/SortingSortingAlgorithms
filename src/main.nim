import std/random
import std/times
import std/strformat
import std/algorithm

import algorithms/bubble_sort_impl
import algorithms/heap_sort_impl
import algorithms/insertion_sort_impl
import algorithms/intro_sort_impl
import algorithms/quick_sort_impl

const algos = [
    #("Naive bubble sort", naive_bubble_sort),
    #("Standard bubble sort", standard_bubble_sort),
    #("Optimised bubble sort", optimised_bubble_sort),
    
    #("Recursive heap sort", recursive_heap_sort),
    #("Iterative heap sort", iterative_heap_sort),
    
    #("Standard insertion sort", standard_insertion_sort),
    #("Binary insertion sort", binary_insertion_sort),
    
    ("Standard intro sort", standard_intro_sort),
    ("Binary intro sort", binary_intro_sort),
    ("Median of three intro sort", median_intro_sort),
    ("Binary search median of three intro sort", binary_median_intro_sort),
    
    #("Standard quick sort", standard_quick_sort),
    #("Median of three quick sort", median_quick_sort),
]

proc test_all(): void =
    const length = 10_000_000
    const max = 100_000_000
    const test_cycles = 1
    
    #const seed = 1234567890
    randomize()
    let seed = rand(1_000_000)
    
    echo &"Testing all algorithms {test_cycles} times each."
    echo &"Sequence length: {length}"
    echo &"Max random int size: {max}"
    echo &"Random seed {seed}\n"
    
    echo "Generating random sequence."
    randomize(seed)
    var random_sequence: seq[int] = @[]
    for _ in 1 .. length:
        random_sequence.add(rand(max))
    
    let control_sequence = sorted(random_sequence)
    echo "Finished generating random sequence.\n"
    
    for algo_name, algo_function in algos.items():
        echo &"Sorting using \"{algo_name}\""
    
        var total_time = 0.0
        for i in 1 .. test_cycles:
            var sequence = random_sequence
            let start = epochTime()
            algo_function(sequence)
            let stop = epochTime()
            total_time += stop - start
            
            if i == 1:
                echo &"Checking if \"{algo_name}\" sorted correctly the first time."
                if sequence != control_sequence:
                    echo &"{$sequence}\n\"{algo_name}\" did not sort correctly."
                    return
                else:
                    echo &"\"{algo_name}\" sorted correctly."
                    
        let average_time = total_time / test_cycles
        
        echo &"\"{algo_name}\" took {average_time:.6f} seconds on average.\n"
        
when isMainModule:
    test_all()