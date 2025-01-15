# fp3251024linear-interpolation

Functional programming lab #3, implementing function Interpolation

---

What is this?

This project is a functional programming practice for implementation function interpolation. Application represents REPL, where user adds some initial points, and as the execution progresses algorithms interpolate this function. Each algorithm has a sliding window with the latest points. Here's conceptual overview of sliding window work:

```
o o o o o o . . x x x
  x x x . . o . . x x x
    x x x . . o . . x x x
      x x x . . o . . x x x
        x x x . . o . . x x x
          x x x . . o . . x x x
            x x x . . o o o o o o EOF
```

where:
- each line is a window of data on the basis of which the algorithm is calculated; lines are replaced as new data enters the system (old data is removed from the window, new data is added);
- `o` -- calculated data
- `.` -- points involved in calculating the value of o.
- `x` -- points whose calculation for "windows" is not required.

Implemented algorithms:
- Lagrange (4) and Linear Interpolation: [here](src/LibInterpolation.hs)
- Sliding window: [here](src/LibSlidingWindow.hs)
- REPL: [here](src/LibREPL.hs)
