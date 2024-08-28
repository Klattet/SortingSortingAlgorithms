
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

proc heap_sort*(sequence: var seq[int]): void =
    let size = sequence.len
    for i in countdown(size div 2 - 1, 0):
        heapify(sequence, size, i)
    
    for i in countdown(size - 1, 0):
        swap(sequence[0], sequence[i])
        heapify(sequence, i, 0)


proc buildMaxHeap(sequence: var seq[int], size: int): void =
    for i in 0 ..< size:
        if sequence[i] > sequence[(i - 1) div 2]:
            var j = i

            while sequence[j] > sequence[(j - 1) div 2]:
                swap(sequence[j], sequence[(j - 1) div 2])
                j = (j - 1) div 2

proc heap_sort_iter*(sequence: var seq[int]): void =
    let size = sequence.len
    buildMaxHeap(sequence, size)
  
    for i in countdown(size - 1, 1):
        swap(sequence[0], sequence[i])
        
        var j = 0
        var index = 0
        
        while true:
            index = 2 * j + 1
            
            if index < (i - 1) and sequence[index] < sequence[index + 1]:
                index += 1

            if index < i and sequence[j] < sequence[index]:
                swap(sequence[j], sequence[index])
            
            j = index  
            if index >= i: 
                break