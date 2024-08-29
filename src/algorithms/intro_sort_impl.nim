import std/math

const INSERTION_LIMIT = 32
const DEPTH_FACTOR = 2.0

func depth_limit(size: int): int {.inline.} =
    return int(DEPTH_FACTOR * log2(float(size)))

proc insertion_sort(sequence: var seq[int], start: int, stop: int): void =
    for i in start + 1 ..< stop:
        let key = sequence[i]
        
        var j = i
        while 0 < j and key < sequence[j - 1]:
            sequence[j] = sequence[j - 1]
            j -= 1
        sequence[j] = key

proc binary_insertion_sort(sequence: var seq[int], start: int, stop: int): void =
    for i in start + 1 ..< stop:
        let key = sequence[i]
        
        var low = start
        var high = i
        while low < high:
            let middle = (low + high) div 2
            if key < sequence[middle]:
                high = middle
            else:
                low = middle + 1
        
        var j = i
        while low < j:
            sequence[j] = sequence[j - 1];
            j -= 1
        sequence[j] = key

proc heapify(sequence: var seq[int], start: int, stop: int, index: int): void =
    let left = 2 * (index - start) + 1 + start
    let right = 2 * (index - start) + 2 + start
    
    var largest = index
    
    if left < stop and sequence[left] > sequence[largest]:
            largest = left
    if right < stop and sequence[right] > sequence[largest]:
            largest = right
    
    if largest != index:
        swap(sequence[index], sequence[largest]) 
        heapify(sequence, start, stop, largest)

proc heap_sort(sequence: var seq[int], start: int, stop: int): void {.inline.} =
    for i in countdown(stop, start):
        heapify(sequence, start, stop, i)
    
    for i in countdown(stop - 1, start):
        swap(sequence[start], sequence[i])
        heapify(sequence, start, i, start)

proc median_of_three_pivot(sequence: var seq[int], low: int, high: int): int {.inline.} =
    let middle = (low + high) div 2
    if sequence[middle] < sequence[low]:
        swap(sequence[low], sequence[middle])
    if sequence[high] < sequence[low]:
        swap(sequence[low], sequence[high])
    if sequence[middle] < sequence[high]:
        swap(sequence[middle], sequence[high])
    return sequence[high]

proc partition(sequence: var seq[int], low: int, high: int): int {.inline.} =
    #let pivot = median_of_three_pivot(sequence, low, high)
    let pivot = sequence[high]
    var i = low
    for j in low ..< high:
        if sequence[j] < pivot:
            swap(sequence[i], sequence[j])
            i += 1
    swap(sequence[i], sequence[high])
    return i

proc sort_helper(sequence: var seq[int], start: int, stop: int, cutoff: int): void =    
    if stop - start < INSERTION_LIMIT:
        #binary_insertion_sort(sequence, start, stop)
        insertion_sort(sequence, start, stop)
    elif cutoff == 0:
        heap_sort(sequence, start, stop)
    else:
        let pivot = partition(sequence, start, stop - 1)
        
        sort_helper(sequence, start, pivot, cutoff - 1)
        sort_helper(sequence, pivot + 1, stop, cutoff - 1)

proc intro_sort*(sequence: var seq[int]): void =
    let size = sequence.len
    sort_helper(sequence, 0, size, depth_limit(size))
