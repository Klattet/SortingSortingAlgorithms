import uing
from uing/rawui import nil

proc rectangle(context: ptr DrawContext, x, y, width, height: float, r, g, b: int, a: float = 1f) = 
    var 
        brush: DrawBrush
        path = newDrawPath(DrawFillModeWinding)

    brush.r = cdouble (r/255)
    brush.g = cdouble (g/255)
    brush.b = cdouble (b/255)
    brush.a = cdouble a

    path.addRectangle(x, y, width, height)
    `end` path
    context.fill(path, addr brush)
    free path

proc draw_sequence(context: ptr DrawContext, sequence: var seq[int], x: int, y: int, scale: int): void =
    for index, num in sequence:
        rectangle(
            context,
            float(x + index * scale) + 0.5 * float(scale * index), 
            float(y - num * scale),
            float(scale),
            float(num * scale),
            0, 255, 0
        )

import algorithms/bubble_sort_impl

proc draw_handler(a: ptr AreaHandler; area: ptr rawui.Area; p: ptr AreaDrawParams) {.cdecl.} =
    #draw_sequence(p.context, @[5,3,7,1], 100, 500, 10)
    var sequence = @[5,3,7,1,9,4,3,6,7,3,4,1,8]
    draw_bubble_sort(p.context, sequence, 100, 400, 20,  )

proc init_gui*() = 
    let window = newWindow("Sorting algorithms", 1200, 800)

    let box = newHorizontalBox(true)
    window.child = box

    var handler: AreaHandler
    handler.draw = draw_handler
    handler.mouseEvent = proc (_: ptr AreaHandler, a: ptr rawui.Area, b: ptr AreaMouseEvent) {.cdecl.} = discard
    handler.mouseCrossed = proc (_: ptr AreaHandler, a: ptr rawui.Area, b: cint) {.cdecl.} = discard
    handler.dragBroken = proc (_: ptr AreaHandler, a: ptr rawui.Area) {.cdecl.} = discard
    handler.keyEvent = proc (_: ptr AreaHandler, a: ptr rawui.Area, b: ptr AreaKeyEvent): cint {.cdecl.} = cint 0

    let area = newArea(addr handler)
    box.add area, true

    show window
    mainLoop()
