import ../swaps

proc heapify(sequence: var seq[int], size: int, index: int): void =
    let left = 2 * index + 1
    let right = 2 * index + 2
    
    var largest = index
    
    if left < size and sequence[left] > sequence[largest]:
            largest = left
    if right < size and sequence[right] > sequence[largest]:
            largest = right
    
    if largest != index:
        swap(sequence, index, largest) 
        heapify(sequence, size, largest)

proc heap_sort*(sequence: var seq[int]): void =
    for i in countdown(int(sequence.len / 2) - 1, 0):
        heapify(sequence, sequence.len, i)
    
    for i in countdown(sequence.len - 1, 0):
        swap(sequence, 0, i)
        heapify(sequence, i, 0)