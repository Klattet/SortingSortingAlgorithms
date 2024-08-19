import ../swaps

proc optimised_bubble_sort*(sequence: var seq[int], size: int): void =
    for i in 1 ..< size:
        var flag = true
        for j in 1 .. size - i:
            if sequence[j - 1] > sequence[j]:
                swap(sequence, j - 1, j)
                flag = false
        if flag:
            break

proc naive_bubble_sort(sequence: var seq[int], size: int): void =