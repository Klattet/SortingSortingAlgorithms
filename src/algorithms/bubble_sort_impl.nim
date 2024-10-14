
# BUBBLE SORT
# Family: Exchange
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
# Bubble sort is a simple comparison-based sorting algorithm.
# It works by repeatedly stepping through a list of elements, comparing adjacent pairs, and swapping them if they are in the wrong order.
# This process is repeated until the list is fully sorted.
#
# The name is in reference to how the elements seem to "bubble up to the top" of the list.
#


{.experimental: "codeReordering".}


# NAIVE IMPLEMENTATION
# The simplest version of the algorithm.
# It loops (n * (n - 1)) times every time.
proc naive_bubble_sort*(sequence: var seq[int]): void =
    naive_bubble_sort_sub(sequence, 0, sequence.len)

proc naive_bubble_sort_sub*(sequence: var seq[int], start: int, stop: int): void {.inline.} =
    for i in start ..< stop:
        for j in start + 1 ..< stop:
            if sequence[j - 1] > sequence[j]:
                swap(sequence[j - 1], sequence[j])


# STANDARD IMPLEMENTATION
# After every iteration of the list, the largest element in the unsorted section will bubble to the end.
# We can assume there is a sorted section at the end of the list that grows in size by 1 after every iteration.
# Thus unlike the naive implementation, we simply skip iterating over the sorted section.
# This effectively halves the number of comparisons, (n * (n - 1) / 2).
proc standard_bubble_sort*(sequence: var seq[int]): void =
    standard_bubble_sort_sub(sequence, 0, sequence.len)

proc standard_bubble_sort_sub(sequence: var seq[int], start: int, stop: int): void {.inline.} =
    for i in start ..< stop:
        for j in start + 1 ..< stop - i:
            if sequence[j - 1] > sequence[j]:
                swap(sequence[j - 1], sequence[j])


# OPTIMISED IMPLEMENTATION
# The only common optimisation to the standard implementation is to add a flag to check when the list happens to be sorted.
# This may or may not perform better than the standard implementation depending on the data in the list.
# For totally random data, if comparisons are cheap, the extra overhead may lead to worse performance.
# However, pointless comparsions are skipped for sorted or approximately sorted lists.
proc optimised_bubble_sort*(sequence: var seq[int]): void =
    optimised_bubble_sort_sub(sequence, 0, sequence.len)

proc optimised_bubble_sort_sub*(sequence: var seq[int], start: int, stop: int): void =
    for i in start ..< stop:
        var flag = true
        for j in start + 1 ..< stop - i:
            if sequence[j - 1] > sequence[j]:
                swap(sequence[j - 1],sequence[j])
                flag = false
        if flag:
            break
