
# QUICK SORT
# Family: Partitioning
#
# In-place: YES
# Stable:   YES or NO
# Adaptive: NO
#
# Comparisons:
# Average: O(n * log(n))
# Best:    O(n) or O(n * log(n))
# Worst:   O(n^2)
#
# Swaps:
# Average: O(n * log(n))
# Best:    O(log(n))
# Worst:   O(n^2)
#
# Space:
# Average: O(log(n))
# Best:    O(log(n))
# Worst:   O(log(n))
#
# Description:
# Quick sort is an efficient comparison-based sorting algorithm.
# It works by selecting a "pivot" element from the list and partitioning the other elements on either side of the pivot depending on if they are smaller or larger than it.
# This process is recursively applied to the subarrays on either side of the pivot.
#

{.experimental: "codeReordering".}


# STANDARD IMPLEMENTATION
# Chooses the last element in the unsorted section as the pivot.
proc standard_quick_sort*(sequence: var seq[int]): void =

proc standard_quick_sort_sub*(sequence: var seq[int], start: int, stop: int): void {.inline.} =
    standard_helper(sequence, 0, sequence.len - 1)

proc standard_helper(sequence: var seq[int], low: int, high: int): void =
    if low < high:
        
        let pivot = standard_partition(sequence, low, high)
        
        standard_helper(sequence, low, pivot - 1)
        standard_helper(sequence, pivot + 1, high)

proc standard_partition(sequence: var seq[int], low: int, high: int): int {.inline.} =
    #let pivot = median_of_three_pivot(sequence, low, high) # No significant speedup on random data.
    let pivot = sequence[high]
    
    var i = low
    for j in low ..< high:
        if sequence[j] < pivot:
            swap(sequence[i], sequence[j])
            i += 1
    
    swap(sequence[i], sequence[high])
    return i


# MEDIAN OF THREE IMPLEMENTATION
# Chooses the last element in the unsorted section as the pivot.
proc median_quick_sort*(sequence: var seq[int]): void =
    median_helper(sequence, 0, sequence.len - 1)

proc median_helper(sequence: var seq[int], low: int, high: int): void =
    if low < high:
        
        let pivot = median_partition(sequence, low, high)
        
        median_helper(sequence, low, pivot - 1)
        median_helper(sequence, pivot + 1, high)

proc median_partition(sequence: var seq[int], low: int, high: int): int {.inline.} =
    let pivot = median_of_three_pivot(sequence, low, high)
    
    var i = low
    for j in low ..< high:
        if sequence[j] < pivot:
            swap(sequence[i], sequence[j])
            i += 1
    
    swap(sequence[i], sequence[high])
    return i

proc median_of_three_pivot(sequence: var seq[int], low: int, high: int): int {.inline.} =
    let middle = (low + high) div 2
    if sequence[middle] < sequence[low]:
        swap(sequence[low], sequence[middle])
    if sequence[high] < sequence[low]:
        swap(sequence[low], sequence[high])
    if sequence[middle] < sequence[high]:
        swap(sequence[middle], sequence[high])
    return sequence[high]
