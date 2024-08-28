
proc naive_bubble_sort*(sequence: var seq[int]): void =
    let size = sequence.len
    for i in 1 ..< size:
        for j in 1 .. size - i:
            if sequence[j - 1] > sequence[j]:
                swap(sequence[j - 1],sequence[j])

proc optimised_bubble_sort*(sequence: var seq[int]): void =
    let size = sequence.len
    for i in 1 ..< size:
        var flag = true
        for j in 1 .. size - i:
            if sequence[j - 1] > sequence[j]:
                swap(sequence[j - 1],sequence[j])
                flag = false
        if flag:
            break

