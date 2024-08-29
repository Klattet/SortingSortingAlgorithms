
proc heapify(sequence: var seq[int], size: int, index: int): void =
    let left = 2 * index + 1
    let right = 2 * index + 2
    
    var largest = index
    
    if left < size and sequence[left] > sequence[largest]:
            largest = left
    if right < size and sequence[right] > sequence[largest]:
            largest = right
    
    if largest != index:
        swap(sequence[index], sequence[largest]) 
        heapify(sequence, size, largest)

proc heap_sort_rec*(sequence: var seq[int]): void =
    let size = sequence.len
    for i in countdown(size div 2 - 1, 0):
        heapify(sequence, size, i)
    
    for i in countdown(size - 1, 0):
        swap(sequence[0], sequence[i])
        heapify(sequence, i, 0)

proc heap_sort_iter*(sequence: var seq[int]): void =
    let size = sequence.len
    if 1 < size:
    
        var j = 1
        var i = 1
        var child = 0
        while true:
            while sequence[j] > sequence[child]:
                swap(sequence[j], sequence[child])
                j = child
                child = (j - 1) div 2
            
            child = i div 2
            i += 1
            if i == size:
                break
            j = i
    
        i -= 1
        while true:
            swap(sequence[0], sequence[i])
            
            j = 0
            var index = 1
        
            while true:
                if index < (i - 1) and sequence[index] < sequence[index + 1]:
                    index += 1

                if index < i and sequence[j] < sequence[index]:
                    swap(sequence[j], sequence[index])
            
                if index >= i:
                    break
            
                j = index
                index = 2 * j + 1
            
            i -= 1
            if 0 == i:
                break
