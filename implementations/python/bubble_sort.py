from typing import MutableSequence

"""
Basic
"""
def bubble_sort(seq: MutableSequence, length: int) -> None:
    for i in range(length):
        for j in range(length - 1 - i):
            if seq[j] > seq[j + 1]:
                swap(seq[j], seq[j + 1])


from itertools import pairwise
"""
Optimisation
"""
def bubble_sort(seq: MutableSequence, length: int) -> None:
    done: bool
    for i in range(length):
        done = True
        for j, k in pairwise(range(length - i)):
            if seq[j] > seq[k]:
                swap(seq[j], seq[k])
                done = False
        if done:
            break
