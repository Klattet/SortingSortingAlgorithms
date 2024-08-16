import std/random
import std/times
import std/strformat

import algorithms/bubble_sort
import algorithms/insertion_sort

const algos = [
    ("Insertion sort", insertion_sorter),
    ("Bubble sort", bubble_sorter),
]

# HELPER FUNCTIONS
proc make_seq(length: int, max: int, seed: int): seq[int] =
    randomize(seed)
    
    var sequence: seq[int] = @[]
    
    for _ in 1 .. length:
        sequence.add(rand(max))
    
    return sequence

func is_sorted(sequence: seq[int]): bool =
    for i in 0 ..< sequence.len - 1:
        if sequence[i] > sequence[i + 1]:
            return false
    return true


# TESTING
proc test_all(): void =
    const length = 10_000
    const max = 100_000
    const seed = 1234567890
    
    const test_cycles = 10
    
    echo &"Testing all algorithms {test_cycles} times each."
    echo &"Sequence length: {length}"
    echo &"Max random int size: {max}"
    echo &"Random seed {seed}\n"
    
    echo "Generating random sequence."
    let random_sequence = make_seq(length, max, seed)
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
                if not is_sorted(sequence):
                    echo &"\"{algo_name}\" did not sort correctly.\n{$sequence}"
                    assert false
                else:
                    echo &"\"{algo_name}\" sorted correctly."
                    
        let average_time = total_time / test_cycles
        
        echo &"\"{algo_name}\" took {average_time:.6f} seconds on average.\n"
        
when isMainModule:
    test_all()