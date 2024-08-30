
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
# Heap sort can be classified as a variant of 

{.experimental: "codeReordering".}


# RECURSIVE IMPLEMENTATION
# The simplest version to implement.
# Uses additional space to store (log(n)) function stack frames.
proc recursive_heap_sort*(sequence: var seq[int]): void =
    let size = sequence.len
    if size < 2:
        return
    
    # Construct max heap.
    for i in countdown(size div 2 - 1, 0): # Last half will be sorted by the time half of the list is sorted.
        heapify(sequence, size, i)
    
    # Extract largest and restore heap.
    for i in countdown(size - 1, 0):
        swap(sequence[0], sequence[i])
        heapify(sequence, i, 0)

# Ensure heap property.
proc heapify(sequence: var seq[int], size: int, index: int): void =
    let left = 2 * index + 1
    let right = 2 * index + 2
    var largest = index
    
    if left < size and sequence[left] > sequence[largest]:
            largest = left
    if right < size and sequence[right] > sequence[largest]:
            largest = right
    if largest != index:
        swap(sequence[index], sequence[largest]) 
        heapify(sequence, size, largest)


# ITERATIVE IMPLEMENTATION
# Implementations that are iterative in nature tend to be faster than recursive implementations as they avoid allocating extra memory that is not needed.
proc iterative_heap_sort*(sequence: var seq[int]): void =
    let size = sequence.len
    if size < 2:
        return
    
    # Construct max heap.
    for i in 1 ..< size:
        var parent = (i - 1) div 2
        var j = i
        while sequence[j] > sequence[parent]:
            swap(sequence[j], sequence[parent])
            j = parent
            parent = (j - 1) div 2
    
    # Extract largest and restore heap.
    for i in countdown(size - 1, 1):
        swap(sequence[0], sequence[i])
        
        var j = 0
        while true:
            var child = 2 * j + 1
            
            if child < (i - 1) and sequence[child] < sequence[child + 1]:
                child += 1
            
            if child < i and sequence[j] < sequence[child]:
                swap(sequence[j], sequence[child])
            
            if child >= i:
                break
            j = child
