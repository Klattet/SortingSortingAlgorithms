
# INSERTION SORT
# Family: Insertion
#
# In-place: YES
# Stable:   YES
# Adaptive: YES
#
# Comparisons:
# Average: O(n^2)
# Best:    O(n)
# Worst:   O(n^2)
#
# Swaps:
# Average: O(n^2)
# Best:    O(1)
# Worst:   O(n^2)
#
# Space:
# Average: O(1)
# Best:    O(1)
# Worst:   O(1)
#
# Description:
# Insertion sort is a simple, comparison-based sorting algorithm.
# It builds a sorted portion of a list one element at a time.
# Starting with the first element as a sorted section, it iteratively takes the next element from the unsorted section and inserts it into the correct position within the sorted section.
# This process continues until the entire list is sorted.
#
# Despite having quadratic average time complexity, it is often preferred over other algorithms for small or approximately sorted lists because of its excellent practical performance in such cases.
#


# STANDARD IMPLEMENTATION
# The most common implementation.
proc standard_insertion_sort*(sequence: var seq[int]): void =
    for i in 1 ..< sequence.len:
        let key = sequence[i]
        
        # Move to correct position.
        var j = i
        while 0 < j and key < sequence[j - 1]:
            sequence[j] = sequence[j - 1]
            j -= 1
        sequence[j] = key


# BINARY SEARCH IMPLEMENTATION
# Unlike the standard implementation, this version avoids unnecessary comparisons by taking advantage of the fact that the section where elements get inserted is sorted.
# That means it is possible to use binary search to locate the correct position for the element.
proc binary_insertion_sort*(sequence: var seq[int]): void =
    for i in 1 ..< sequence.len:
        let key = sequence[i]
        
        # Binary search for destination.
        var low = 0
        var high = i
        while low < high:
            let middle = (low + high) div 2
            if key < sequence[middle]:
                high = middle
            else:
                low = middle + 1
        
        # Move to position.
        var j = i
        while low < j:
            sequence[j] = sequence[j - 1];
            j -= 1
        sequence[j] = key
