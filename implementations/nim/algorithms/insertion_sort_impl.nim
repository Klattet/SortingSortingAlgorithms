import ../swaps

proc insertion_sort*(sequence: var seq[int]): void =
    for i in 1 ..< sequence.len:     
        let current = sequence[i]
        for j in countdown(i, 1):
            if sequence[j - 1] > current:
                sequence[j] = sequence[j - 1]
            else:
                sequence[j] = current
                break
