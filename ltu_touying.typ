#import "@preview/touying:0.6.1": *

#let ltu-theme(
  ..args,
  body,
) = {
  set text(size: 20pt, font: ("Helvetica Neue", "Arial", "Liberation Sans"))

  show: touying-slides.with(
    config-common(
      slide-fn: slide,
    ),
    ..args,
  )

  body
}
