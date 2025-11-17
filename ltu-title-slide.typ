#import "@preview/touying:0.6.1": *
#import "autosize.typ": autosize
/// Title slide for the presentation. You should update the information in the `config-info` function. You can also pass the information directly to the `title-slide` function.
///
/// Example:
///
/// ```typst
/// #show: university-theme.with(
///   config-info(
///     title: [Title],
///     logo: emoji.school,
///   ),
/// )
///
/// #title-slide(subtitle: [Subtitle])
/// ```
///
/// - config (dictionary): is the configuration of the slide. Use `config-xxx` to set individual configurations for the slide. To apply multiple configurations, use `utils.merge-dicts` to combine them.
///
/// - extra (string, none): is the extra information for the slide. This can be passed to the `title-slide` function to display additional information on the title slide.
#let ltu-title-slide(
  config: (:), // this is the syntax for an empty dictionary
  extra: none,
  ..args,
) = touying-slide-wrapper(self => {
  self = utils.merge-dicts(
    self,
    config,
    config-common(freeze-slide-counter: true),
  )
  let info = self.info + args.named()
  info.authors = {
    let authors = if "authors" in info {
      info.authors
    } else {
      info.author
    }
    if type(authors) == array {
      authors
    } else {
      (authors,)
    }
  }
  let body = {
     v(24%) // taken from official template
    std.align(
      center + top,
      {
        [#block(
          fill: white,
          width: 60%, // taken from officiel template
          height: 40%, // taken from official template
          inset: 1cm,  // padding towards the box
          breakable: false)[
          #{
            set align(left + top)
            // Text size 10 is an ok choice, that means autosize can range from 1pt to 50pt in 1pt steps
            set text(size: 10pt, fill: self.colors.ltublue, font: ("Helvetica Neue", "Arial", "Liberation Sans")) 
            // two thirds title + subtitle, make as large as possible, subtitle 75% the size of the title
            block(height: 2fr,autosize(info.title + if info.subtitle != none {align(bottom,text(size: 0.75em, parbreak() + info.subtitle))}))
            // Orange bar
            rect(fill: self.colors.ltuorange, width: 15%, height: 2%)
            // one third authors and date 
            align(bottom, block(height: 1fr)[   
              #{
            grid(
              columns: (1fr,) * calc.min(info.authors.len(), 3),
              column-gutter: 1em,
              row-gutter: 1em,
              ..info.authors.map(author => align(left, text( author,  )))
            )
            if info.date != none {
              utils.display-info-date(self)
            }
            if info.institution != none {
               "   -   " + info.institution
            }

              }
            ])
          }]  
        ]
      },
    )
  }
  let my_args = (:);
  my_args.background = {
    align(right, image("template_assets/first_slide_bg.jpg", fit: "stretch", width: 50%, height: 100%))
  }
  self = utils.merge-dicts(
    self,
    config-common(freeze-slide-counter: true),
    config-page(margin: (left: 0mm, right: 0mm, top: 0mm, bottom: 0mm), ..my_args),
  )
  touying-slide(self: self, body)
})
