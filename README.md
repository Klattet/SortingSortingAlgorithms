All swaps will be written with a swap function to separate different swapping methods from the actual algorithm.

examples:
```py
def swap(left, right):
    left, right = right, left

def swap(left, right):
    temp = right
    right = left
    left = temp

def swap(left, right):
    left ^= right
    right ^= left
    left ^= right
```
