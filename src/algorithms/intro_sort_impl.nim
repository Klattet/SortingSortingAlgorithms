import std/math

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

proc partition(sequence: var seq[int], low: int, high: int): int {.inline.} =
    let pivot = sequence[high - 1]
    var i = low
    for j in low ..< high - 1:
        if sequence[j] < pivot:
            swap(sequence[i], sequence[j])
            i += 1
    
    swap(sequence[i], sequence[high - 1])
    return i

proc sort_helper(sequence: var seq[int], low: int, high: int, cutoff: int): void =
    let delta = high - low
    
    if delta < 30:
        binary_insertion_sort(sequence, low, high + 1)
    elif cutoff == 0:
        heap_sort(sequence, low, high + 1)
    else:
        let pivot = partition(sequence, low, high + 1)
        
        sort_helper(sequence, low, pivot - 1, cutoff - 1)
        sort_helper(sequence, pivot + 1, high, cutoff - 1)

proc intro_sort*(sequence: var seq[int]): void =
    let size = sequence.len
    sort_helper(sequence, 0, size - 1, 2 * int(log2(float(size))))
