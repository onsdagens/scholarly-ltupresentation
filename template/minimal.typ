#set rect(
  width: 100%,
  height: 100%,
  inset: 0pt,
)

// these values are meant for playing around:
#let c   = 10mm                 // corner size
#let ts  = 15mm                 // text size
#let bw  = 1.5mm                // bar width
#let bh  = 20mm                 // bar height
#let ha  = 0.2                  // header ascent
#let btd = ts / 2               // bar-text-distance

// these values are not meant for playing around:
#let cx = c                    // corner x
#let cy = c                    // corner y
#let tm = (cy + bh) / (1- ha)  // top margin 
#let xm = btd + bw + cx   // x-margin, we are only interested in left, x is only for symmetry
#let sl = btd + bw  // shift  left
#let bar = rect(width: bw, height: bh, fill: orange)
#let tab = align(horizon,
               stack(dir: ltr,
                   bar, h(btd), text(size: ts, lorem(4)) // orange bar, distance, and the text
               ) // go from left to right
           ) // align bar horizontally with text

#set page(
  paper: "presentation-16-9",
  header: 
      rect(fill: aqua,
          move(dx: -sl,
             [
                 #tab<text-and-bar>
             ]
          )  // move
      ), // rect
  footer: rect(fill: aqua)[Footer],
  number-align: center,
  margin: (top: tm, x: xm),
  header-ascent: ha * 100%
)

// Content
#rect(fill: aqua.lighten(40%), "Content")
