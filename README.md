# SortingSortingAlgorithms

## Goals
- Efficiently implement sorting algorithms and their variants.
- Test the performance of sorting algorithms on different data shapes (best case, worst case, random, etc.)
- Analyse how the run-time of sorting algorithms grows in response to the input size (BigO notation).
- Investigate the real world performance of sorting algorithms and their ideal use-case.

## Background
I find sorting algorithms fascinating. They perfectly encapsulate how, even hiding behind something seemingly mundane, exists abundant complexity. To re-order a list of numbers so that, every number is smaller than or equal to the next one, is conceptually a very simple operation. It is nonetheless an extremely useful operation in our digital world that is frequently used in countless different contexts.\
\
So then the question becomes: **What is the most efficient way to sort a list of numbers?**\
The answer is of course: **It depends...**

### Why Nim?
Currently, this repo only contains implementations of algorithms in Nim. I chose to use Nim because I wanted to use a statically typed and compiled systems programming language, and I thought it would be a great opportunity to improve my Nim programming skills. Nim is great because it can achieve similar performance to C/C++ with a more pleasant Python-esque syntax. In fact, it compiles to C and then to machine code. Nim has a garbage collector, but empowers the programmer with tools to customize how memory is managed, and even the ability to turn the GC off completely. The result of that is the flexibility to choose automatic or manual memory management, and references or raw pointers, depending on your needs.\
\
I plan to add implementations in different languages eventually, but don't hold your breath.

## Currently implemented:
- Bubble sort
  - Naive
  - Standard
  - Optimised
- Heap sort
  - Recursive
  - Iterative
- Insertion sort
  - Standard
  - Binary insertion
- Intro sort (With iterative heap sort)
  - Standard
  - Binary insertion
  - Median-of-three
  - Binary insertion + Median-of-three
- Quick sort
  - Standard
  - Median-of-three

## Dependencies
No additional dependencies needed! Build using the official Nim compiler and run the program.
