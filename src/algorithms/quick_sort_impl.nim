
proc partition(sequence: var seq[int], low: int, high: int): int {.inline.} =
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
    let size = sequence.len
    if 1 < size:
        sort_helper(sequence, 0, size - 1)