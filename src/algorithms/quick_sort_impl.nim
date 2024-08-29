
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
    #let pivot = median_of_three_pivot(sequence, low, high) # No significant speedup on random data.
    let pivot = sequence[high]
    
    var i = low
    for j in low ..< high:
        if sequence[j] < pivot:
            swap(sequence[i], sequence[j])
            i += 1
    
    swap(sequence[i], sequence[high])
    return i

proc sort_helper(sequence: var seq[int], low: int, high: int): void =
    if low < high:
        
        let pivot = partition(sequence, low, high)
        
        sort_helper(sequence, low, pivot - 1)
        sort_helper(sequence, pivot + 1, high)

proc quick_sort*(sequence: var seq[int]): void =
    sort_helper(sequence, 0, sequence.len - 1)
