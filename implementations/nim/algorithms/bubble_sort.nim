import ../swaps

proc bubble_sorter*(sequence: var seq[int]): void =
    for i in 1 ..< sequence.len:
        var swapped = false
        for j in 1 .. sequence.len - i:
            if sequence[j - 1] > sequence[j]:
                swap(sequence, j - 1, j)
                swapped = true
        
        if not swapped:
            break
