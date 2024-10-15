
# INTRO SORT
# Family: Hybrid (Insertion, Selection, Partitioning)
#
# Description:
# A hybrid sorting algorithm that begins with quicksort and switches to heapsort when the recursion depth exceeds a certain limit or to insertion sort when the sublist is smaller than a certain limit.
#


{.experimental: "codeReordering".}

import std/math

import insertion_sort_impl
import heap_sort_impl


const INSERTION_LIMIT = 32 # Sublists smaller than this number in length use insertion sort.
const DEPTH_FACTOR = 2.0 # The factor to multiply the would-be heap height with to determine the maximum recursion depth before switching to heap sort.


# HELPER FUNCTIONS

# Calculate the depth limit for where to switch from quicksort to heapsort.
func depth_limit(size: int): int {.inline.} =
    return int(DEPTH_FACTOR * log2(float(size)))

# Partition around the pivot value. Place pivot as the last element in the sublist.
proc partition(sequence: var seq[int], lowest: int, highest: int): int {.inline.} =
    let pivot = sequence[highest]
    var i = lowest
    for j in lowest ..< highest:
        if sequence[j] < pivot:
            swap(sequence[i], sequence[j])
            i += 1
    swap(sequence[i], sequence[highest])
    return i

# Move the median of the first, middle and last element to the end.
proc move_median_of_three_to_end(sequence: var seq[int], lowest: int, highest: int): void {.inline.} =
    let middle = (lowest + highest) div 2
    if sequence[middle] < sequence[lowest]:
        swap(sequence[lowest], sequence[middle])
    if sequence[highest] < sequence[lowest]:
        swap(sequence[lowest], sequence[highest])
    if sequence[middle] < sequence[highest]:
        swap(sequence[middle], sequence[highest])


# STANDARD IMPLEMENTATION
proc standard_intro_sort*(sequence: var seq[int]): void =
    standard_intro_sort_sub(sequence, 0, sequence.len)

proc standard_intro_sort_sub*(sequence: var seq[int], start: int, stop: int): void {.inline.} =
    standard_helper(sequence, start, stop, depth_limit(stop - start))

proc standard_helper(sequence: var seq[int], start: int, stop: int, cutoff: int): void =    
    if stop - start < INSERTION_LIMIT:
        standard_insertion_sort_sub(sequence, start, stop)
    elif cutoff == 0:
        iterative_heap_sort_sub(sequence, start, stop)
    else:
        let pivot = partition(sequence, start, stop - 1)
        
        standard_helper(sequence, start, pivot, cutoff - 1)
        standard_helper(sequence, pivot + 1, stop, cutoff - 1)


# BINARY SEARCH IMPLEMENTATION
proc binary_intro_sort*(sequence: var seq[int]): void =
    binary_intro_sort_sub(sequence, 0, sequence.len)

proc binary_intro_sort_sub*(sequence: var seq[int], start: int, stop: int): void {.inline.} =
    binary_helper(sequence, start, stop, depth_limit(stop - start))

proc binary_helper(sequence: var seq[int], start: int, stop: int, cutoff: int): void =    
    if stop - start < INSERTION_LIMIT:
        binary_insertion_sort_sub(sequence, start, stop)
    elif cutoff == 0:
        iterative_heap_sort_sub(sequence, start, stop)
    else:        
        let pivot = partition(sequence, start, stop - 1)
        
        binary_helper(sequence, start, pivot, cutoff - 1)
        binary_helper(sequence, pivot + 1, stop, cutoff - 1)


# MEDIAN OF THREE IMPLEMENTATION
proc median_intro_sort*(sequence: var seq[int]): void =
    median_intro_sort_sub(sequence, 0, sequence.len)

proc median_intro_sort_sub*(sequence: var seq[int], start: int, stop: int): void {.inline.} =
    median_helper(sequence, start, stop, depth_limit(stop - start))

proc median_helper(sequence: var seq[int], start: int, stop: int, cutoff: int): void =    
    if stop - start < INSERTION_LIMIT:
        standard_insertion_sort_sub(sequence, start, stop)
    elif cutoff == 0:
        iterative_heap_sort_sub(sequence, start, stop)
    else:
        move_median_of_three_to_end(sequence, start, stop - 1)
        
        let pivot = partition(sequence, start, stop - 1)
        
        median_helper(sequence, start, pivot, cutoff - 1)
        median_helper(sequence, pivot + 1, stop, cutoff - 1)


# BINARY SEARCH MEDIAN OF THREE IMPLEMENTATION
proc binary_median_intro_sort*(sequence: var seq[int]): void =
    binary_median_intro_sort_sub(sequence, 0, sequence.len)

proc binary_median_intro_sort_sub*(sequence: var seq[int], start: int, stop: int): void {.inline.} =
    binary_median_helper(sequence, start, stop, depth_limit(stop - start))

proc binary_median_helper(sequence: var seq[int], start: int, stop: int, cutoff: int): void =    
    if stop - start < INSERTION_LIMIT:
        binary_insertion_sort_sub(sequence, start, stop)
    elif cutoff == 0:
        iterative_heap_sort_sub(sequence, start, stop)
    else:
        move_median_of_three_to_end(sequence, start, stop - 1)
        
        let pivot = partition(sequence, start, stop - 1)
        
        binary_median_helper(sequence, start, pivot, cutoff - 1)
        binary_median_helper(sequence, pivot + 1, stop, cutoff - 1)
