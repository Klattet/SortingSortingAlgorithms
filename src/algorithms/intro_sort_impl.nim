import std/math

proc binary_insertion_sort(sequence: var seq[int], low: int, high: int): void =
    for i in low + 1 .. high:
        let key = sequence[i]
        
        var lower = low
        var higher = i
        while lower < higher:
            let middle = (lower + higher) div 2
            if key < sequence[middle]:
                higher = middle
            else:
                lower = middle + 1
        
        var j = i
        while lower < j:
            sequence[j] = sequence[j - 1];
            j -= 1
        sequence[j] = key

proc heapify(sequence: var seq[int], low: int, high: int, index: int): void =
    let left = 2 * (index - low) + 1 + low
    let right = 2 * (index - low) + 2 + low
    
    var largest = index
    
    if left < high and sequence[left] > sequence[largest]:
            largest = left
    if right < high and sequence[right] > sequence[largest]:
            largest = right
    
    if largest != index:
        swap(sequence[index], sequence[largest]) 
        heapify(sequence, low, high, largest)

proc heap_sort(sequence: var seq[int], low: int, high: int): void {.inline.} =
    for i in countdown(high + 1, low):
        heapify(sequence, low, high + 1, i)
    
    for i in countdown(high, low):
        swap(sequence[low], sequence[i])
        heapify(sequence, low, i, low)

proc partition(sequence: var seq[int], low: int, high: int): int {.inline.} =
    let pivot = sequence[high]
    var i = low
    for j in low ..< high:
        if sequence[j] < pivot:
            swap(sequence[i], sequence[j])
            i += 1
    
    swap(sequence[i], sequence[high])
    return i

proc sort_helper(sequence: var seq[int], low: int, high: int, cutoff: int): void =
    let delta = high - low
    
    if delta < 30:
        binary_insertion_sort(sequence, low, high)
    elif cutoff == 0:
        heap_sort(sequence, low, high)
    else:
        let pivot = partition(sequence, low, high)
        
        sort_helper(sequence, low, pivot - 1, cutoff - 1)
        sort_helper(sequence, pivot + 1, high, cutoff - 1)

proc intro_sort*(sequence: var seq[int]): void =
    let size = sequence.len
    sort_helper(sequence, 0, size - 1, 2 * int(log2(float(size))))
