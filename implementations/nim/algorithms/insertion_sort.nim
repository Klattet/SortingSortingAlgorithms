import ../swaps

proc insertion_sorter*(sequence: var seq[int]): void =
    for i in -1 ..< sequence.len - 1:     
        for j in countdown(i, 0):
            if sequence[j] <= sequence[j + 1]:
                break
            swap(sequence, j, j + 1)