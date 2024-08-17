import std/math

import ../swaps

proc insertion_sort(sequence: var seq[int], low: int, high: int): void =
    for i in low - 1 ..< high:     
        for j in countdown(i, 0):
            if sequence[j] <= sequence[j + 1]:
                break
            swap(sequence, j, j + 1)

proc heapify(sequence: var seq[int], low: int, high: int, index: int): void =
    let left = 2 * index - low + 1 + low
    let right = 2 * index - low + 2 + low
    
    var largest = index
    
    if left < high and sequence[left] > sequence[largest]:
            largest = left
    if right < high and sequence[right] > sequence[largest]:
            largest = right
    
    if largest != index:
        swap(sequence, index, largest) 
        heapify(sequence, low, high, largest)

proc heap_sort(sequence: var seq[int], low: int, high: int): void =
    for i in countdown(int(high / 2) - 1, low):
        heapify(sequence, low, high, i)
    
    for i in countdown(high, low):
        swap(sequence, low, i)
        
        heapify(sequence, low, i, low)

proc partition(sequence: var seq[int], low: int, high: int): int {.inline.} =    
    var i = low
    for j in low ..< high:
        if sequence[j] < sequence[high]:
            swap(sequence, i, j)
            i += 1
    
    swap(sequence, i, high)
    return i

proc sort_helper(sequence: var seq[int], max_depth: int, low: int, high: int): void =
    let size = high - low
    if size < 16:
        insertion_sort(sequence, low, high)
    elif max_depth == 0:
        heap_sort(sequence, low, high)
    else:
        let pivot = partition(sequence, low, high)
        
        sort_helper(sequence, max_depth - 1, low, pivot - 1)
        sort_helper(sequence, max_depth - 1, pivot + 1, high)

proc intro_sort*(sequence: var seq[int]): void =
    sort_helper(sequence, int(log2(float(sequence.len))) * 2, 0, sequence.len - 1)
    