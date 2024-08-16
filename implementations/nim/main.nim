import std/random
import std/times
import std/strformat

import algorithms/bubble_sort

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
    
const algos = [
    ("Bubble sort", bubble_sorter)
]

proc test_all(): void =
    const length = 10_000
    const max = 1_000_000
    const seed = 1234567890
    
    const test_cycles = 10
    
    for algo_name, algo_function in algos.items():
        var total_time = 0.0
        for _ in 1 .. test_cycles:
            var sequence = make_seq(length, max, seed)
            let start = epochTime()
            algo_function(sequence)
            let stop = epochTime()
            assert is_sorted(sequence)
            total_time += stop - start
        let average_time = total_time / test_cycles
        
        echo &"{algo_name} took {average_time:.6f} seconds on average."

test_all()