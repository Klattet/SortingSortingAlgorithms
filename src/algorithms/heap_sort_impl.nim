
# HEAP SORT
# Family: Selection
#
# In-place: YES
# Stable:   NO
# Adaptive: NO
#
# Comparisons:
# Average: O(n * log(n))
# Best:    O(n * log(n))
# Worst:   O(n * log(n))
#
# Swaps:
# Average: O(n * log(n))
# Best:    O(n * log(n))
# Worst:   O(n * log(n))
#
# Space:
# Average: O(1) or O(log(n))
# Best:    O(1) or O(log(n))
# Worst:   O(1) or O(log(n))
#
# Description:
# Heap sort is an efficient sorting algorithm that works by converting a list into a max heap.
# The largest element is repeatedly "extracted" and swapped with the last element in the unsorted section, thereby placing it in its correct sorted position.
# The heap property is then restored in the unsorted section to find the next largest element.
# This process continues until the list is sorted.
#
# Although heap sort is generally slower than competitors like quick sort, it is still one of the fastest known sorting algorithms.
# It is often perferred over quick sort because of its consistent time complexity regardless of the shape of the data, avoiding quick sort's worst case.
#


{.experimental: "codeReordering".}


# RECURSIVE IMPLEMENTATION
# The simplest version to implement.
# Uses additional space to store (log(n)) function stack frames.
proc recursive_heap_sort*(sequence: var seq[int]): void =
    recursive_heap_sort_sub(sequence, 0, sequence.len)

proc recursive_heap_sort_sub*(sequence: var seq[int], start: int, stop: int): void {.inline.} =
    if stop - start < 2:
        return
    
    # Construct max heap.
    for i in countdown(stop div 2, start): # The last half will only consist of children.
        recursive_sift_down(sequence, start, stop, i)
    
    # Extract largest and restore heap.
    for i in countdown(stop - 1, start):
        swap(sequence[start], sequence[i])
        recursive_sift_down(sequence, start, i, start)

proc recursive_sift_down(sequence: var seq[int], start: int, stop: int, index: int): void =
    var largest = index
    
    let right = 2 * (index - start) + 2 + start
    if right < stop:
        if sequence[right] > sequence[largest]:
            largest = right
        let left = right - 1
        if sequence[left] > sequence[largest]:
            largest = left
    else:
        let left = right - 1
        if left < stop and sequence[left] > sequence[largest]:
            largest = left
    
    if largest != index:
        swap(sequence[index], sequence[largest])
        recursive_sift_down(sequence, start, stop, largest)


# ITERATIVE IMPLEMENTATION
# Implementations that are iterative in nature tend to be faster than recursive implementations as they avoid allocating extra memory that is not needed.
proc iterative_heap_sort*(sequence: var seq[int]): void =
    iterative_heap_sort_sub(sequence, 0, sequence.len)

proc iterative_heap_sort_sub*(sequence: var seq[int], start: int, stop: int): void {.inline.} =
    if stop - start < 2:
        return
    
    # Construct max heap.
    for i in countdown(stop div 2, start): # The last half will only consist of children.
        iterative_sift_down(sequence, start, stop, i)
    
    # Extract largest and restore heap.
    for i in countdown(stop - 1, 1):
        swap(sequence[start], sequence[i])
        iterative_sift_down(sequence, start, i ,start)

proc iterative_sift_down(sequence: var seq[int], start: int, stop: int, index: int): void {.inline.} =
    var index = index
    while true:
        var largest = index
        
        let right = 2 * (index - start) + 2 + start
        if right < stop:
            if sequence[right] > sequence[largest]:
                largest = right
            let left = right - 1
            if sequence[left] > sequence[largest]:
                largest = left
        else:
            let left = right - 1
            if left < stop and sequence[left] > sequence[largest]:
                largest = left
        
        if largest == index:
            break
        swap(sequence[index], sequence[largest])
        index = largest
