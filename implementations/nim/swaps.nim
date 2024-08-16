
proc temp_swap*(sequence: var seq, a: int, b: int): void {.inline.} =
    let temp = sequence[a]
    sequence[a] = sequence[b]
    sequence[b] = temp

proc xor_swap*(sequence: var seq, a: int, b: int): void {.inline.} =
    sequence[a] = sequence[a] xor sequence[b]
    sequence[b] = sequence[b] xor sequence[a]
    sequence[a] = sequence[a] xor sequence[b]

proc dest_swap*(sequence: var seq, a: int, b: int): void {.inline.} =
    (sequence[a], sequence[b]) = (sequence[b], sequence[a])

proc swap*(sequence: var seq, a: int, b: int): void {.inline.} =
    (sequence[a], sequence[b]) = (sequence[b], sequence[a])