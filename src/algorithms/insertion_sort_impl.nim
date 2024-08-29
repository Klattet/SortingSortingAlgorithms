
proc insertion_sort*(sequence: var seq[int]): void =
    for i in 1 ..< sequence.len:
        let key = sequence[i]
        
        var j = i
        while 0 < j and key < sequence[j - 1]:
            sequence[j] = sequence[j - 1]
            j -= 1
        sequence[j] = key

proc binary_insertion_sort*(sequence: var seq[int]): void =
    for i in 1 ..< sequence.len:
        let key = sequence[i]
        
        # Binary search destination.
        var low = 0
        var high = i
        while low < high:
            let middle = (low + high) div 2
            if key < sequence[middle]:
                high = middle
            else:
                low = middle + 1
        
        # Move to position.
        var j = i
        while low < j:
            sequence[j] = sequence[j - 1];
            j -= 1
        sequence[j] = key
