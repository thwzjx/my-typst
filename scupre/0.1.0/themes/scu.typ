// This theme is inspired by https://github.com/matze/mtheme
// The origin code was written by https://github.com/Enivex

// Consider using:
// #set text(font: "Fira Sans", weight: "light", size: 20pt)
// #show math.equation: set text(font: "Fira Math")
// #set strong(delta: 100)
// #set par(justify: true)

#import "../slide.typ": s
#import "../utils/utils.typ"
#import "../utils/states.typ"
#import "../utils/components.typ"
#import "@preview/showybox:2.0.1": showybox
#let _saved-align = align

#let slide(
  self: none,
  title: auto,
  footer: auto,
  align: horizon,
  ..args,
) = {
  self.page-args += (
    fill: self.colors.neutral-lightest,
  )
  if title != auto {
    self.m-title = title
  }
  if footer != auto {
    self.m-footer = footer
  }
  (self.methods.touying-slide)(
    ..args.named(),
    self: self,
    setting: body => {
      show: _saved-align.with(align)
      set text(fill: self.colors.main-font-color)
      // states.current-section-title == none
      show: args.named().at("setting", default: body => body)
      body
    },
    ..args.pos(),
  )
}
#let d-outline(
  self: none,
  enum-args: (:),
  list-args: (:),
  cover: true,
) = states.touying-progress-with-sections(dict => {
  let (current-sections, final-sections) = dict
  current-sections = current-sections.filter(section => section.loc != none)
  final-sections = final-sections.filter(section => section.loc != none)
  let current-index = current-sections.len() - 1
  let d-cover(i, body) = if i != current-index and cover {
    (self.methods.d-cover)(self: self, body)
  } else {
    body
  }
  set enum(..enum-args)
  set list(..enum-args)
  set text(fill: self.colors.primary)
  // let state_now = states.current-section-title == none
  // block(state_now)
  for (i, section) in final-sections.enumerate() {
    d-cover(
      i,
      {
        enum.item(
          i + 1,
          [#link(
              section.loc,
              section.title,
            )<touying-link>] + if section.children.filter(it => it.kind != "slide").len() > 0 {
            let subsections = section.children.filter(it => it.kind != "slide")
            set text(fill: self.colors.neutral-dark, size: 0.9em)
            list(
              ..subsections.map(subsection => [#link(subsection.loc, subsection.title)<touying-link>]),
            )
          },
        )
      },
    )
    parbreak()
  }
  // state_now
})
#let outline-slide(
  self: none,
  extra:none,
  // title: auto,
  // footer: auto,
  // align: horizon,
  outline-name: [目录],
  body,
  ..args,
  // body
) = {
  self = utils.empty-page(self)
  // let info = self.info + args.named()
  let content = {
    set text(fill: self.colors.primary-dark)
    set align(top)
    grid(
      inset: .5em,
      columns: (100%, 0%),
      fill: (x, y) => if calc.even(x + y) {
        color.hsl(0deg, 58.16%, 38.43%)
      } else {
        luma(70%)
      },
      align: (left),
      text(fill: color.white, outline-name, size: 2em),
    )


    set align(top + center)
    block(
      width: 90%,
      height: 80%,
      {
        set text(size: 1.2em)
        set align(horizon + left)
        body
        set align(bottom + right)
        image("../pic/四川大学.png", width: 10%)
      },
    )

  }
  (self.methods.touying-slide)(self: self, repeat: none, content)
}

#let title-slide(
  self: none,
  extra: none,
  show_shadow: none,
  ..args,
) = {
  self = utils.empty-page(self)
  let info = self.info + args.named()
  let content = {
    set text(fill: self.colors.primary-dark)
    set align(horizon)
    block(
      width: 100%,
      inset: 2em,
      {
        set align(center)
        let show_shadow = true
        if info.show_shadow != none {
          show_shadow = info.show_shadow
        }
        if (show_shadow == false) {
          block(
            fill: self.colors.primary,
            width: 100%,
            inset: (y: 1em),
            radius: 0.5em,
            text(size: 1.5em, fill: self.colors.neutral-lightest, weight: "bold")[
              #info.title \
              #if info.subtitle != none {
                text(size: 0.8em)[#info.subtitle]
                [true & true]
              }
            ],
          )
        } else {
          showybox(
          frame: (
            border-color: self.colors.primary,
            title-color: self.colors.primary,
            body-color: self.colors.primary,
            radius: 10pt,
          ),
          body-style: (
            color: white,
            weight: "bold",
            align: center,
          ),
          shadow: (
            offset: 10pt,
          ),
          // title: [#info.title],
          text(size: 1.5em)[#info.title],
          // [#info.field],
          if info.subtitle != none {
              text(size: 1.2em)[#info.subtitle]
                      }
        )
        }

        set text(size: 1em)
        if info.author != none {
          block(spacing: 1em, info.author)
        }
        if info.institution != none {
          block(spacing: 0.8em, info.institution)
        }
        // line(stroke: none)
        v(1.5em)
        if info.date != none {
          block(spacing: 1em, utils.info-date(self))
        }
        // if info.date != none {
        //   block(spacing: 1em, utils.info-date(self))
        // } else {
        //   block(spacing: 1em, datetime.today().display())
        // }
        set text(size: 1em)

        if extra != none {
          block(spacing: 1em, extra)
        }
      },
    )
  }
  (self.methods.touying-slide)(self: self, repeat: none, content)
}

#let new-section-slide(self: none, short-title: auto, title) = {
  self = utils.empty-page(self)
  let content = {
    set align(horizon)
    show: pad.with(20%)
    set text(size: 1.5em)
    title
    block(height: 2pt, width: 100%, spacing: 0pt, utils.call-or-display(self, self.m-progress-bar))
  }
  (self.methods.touying-slide)(self: self, repeat: none, section: (title: title, short-title: short-title), content)
}

#let focus-slide(self: none, body) = {
  self = utils.empty-page(self)
  self.page-args += (
    fill: self.colors.primary-dark,
    margin: 2em,
  )
  set text(fill: self.colors.neutral-lightest, size: 1.5em)
  (self.methods.touying-slide)(self: self, repeat: none, align(horizon + center, body))
}

#let slides(
  self: none,
  title-slide: true,
  outline-slide: true,
  outline-title: [目录],
  slide-level: 1,
  ..args,
) = {
  if title-slide {
    (self.methods.title-slide)(self: self)
  }
  if outline-slide {
    (self.methods.outline-slide)(self: self, title: outline-title, (self.methods.touying-outline)())
  }
  (self.methods.touying-slides)(self: self, slide-level: slide-level, ..args)
}

#let register(
  self: s,
  aspect-ratio: "16-9",
  header: states.current-section-title,
  footer: [],
  main_theme: self => self.info.title,
  footer-a: self => self.info.author,
  footer-b: self => if self.info.short-title == auto {
    self.info.title
  } else {
    self.info.short-title
  },
  footer-c: self => {
    h(1fr)
    utils.info-date(self)
    h(1fr)
    states.slide-counter.display() + " / " + states.last-slide-number
    h(1fr)
  },
  footer-right: states.slide-counter.display() + " / " + states.last-slide-number,
  footer-progress: true,
) = {
  self = (self.methods.colors)(
    self: self,
    neutral-lightest: rgb("#ffffff"),
    primary-dark: rgb("#b92917"),
    main-font-color: rgb("#000000"),
    secondary-light: rgb("#eb811b"),
    secondary-lighter: rgb("#b02323"),
    primary: rgb("#b92917"),
  )

  // save the variables for later use
  self.m-progress-bar = self => states.touying-progress(ratio => {
    grid(
      columns: (ratio * 100%, 1fr),
      components.cell(fill: self.colors.secondary-light), components.cell(fill: self.colors.secondary-lighter),
    )
  })
  // self.show_shadow = show_shadow
  self.m-footer-progress = footer-progress
  self.m-title = header
  self.m-footer = footer
  self.footer-a = footer-a
  self.footer-b = footer-b
  if footer-c != none {
    self.footer-c = footer-c
  } else {
    self.footer-c = datetime.today().display()
  }
  // self.footer-c = datetime.today().display()
  self.m-footer-right = footer-right
  self.methods.touying-outline = d-outline
  let header(self) = {
    set align(top)

    if self.m-title != none {
      // show: components.cell.with(fill: luma(80%), inset: 1em)
      set text(fill: self.colors.primary-dark, size: 1.8em)
      v(0.2em)
      // set align(center)
      grid(
        columns: (10%, 70%, 18%),
        rows: 60pt,
        gutter: 5pt,
        align: horizon + left,
        inset: 0pt,
        image("../pic/图片1.png", width: 105%),
        utils.fit-to-width(grow: false, 100%, text(weight: "medium", utils.call-or-display(self, self.m-title))),
        image("../pic/image.png", width: 100%),
      )
      v(-0.5em)
      line(length: 100%, stroke: self.colors.primary-dark)
      // set align(horizon)
      // info.title
      // set text(fill: self.colors.primary-dark, size: 1.8em)
      // utils.fit-to-width(grow: false, 100%, text(weight: "medium", utils.call-or-display(self, self.m-title)))
    } else {
      []
    }
  }
  self.scu-footer = self => {
    let cell(fill: none, it) = rect(
      width: 100%,
      height: 100%,
      inset: 1mm,
      outset: 0mm,
      fill: fill,
      stroke: none,
      align(horizon, text(fill: white, it)),
    )
    show: block.with(width: 100%, height: auto, fill: self.colors.secondary)
    grid(
      columns: (25%, 1fr, 25%),
      rows: (2em, auto),
      cell(fill: self.colors.primary, utils.call-or-display(self, footer-a)),
      cell(fill: self.colors.secondary-light, utils.call-or-display(self, footer-b)),
      cell(fill: self.colors.primary, utils.call-or-display(self, footer-c)),
    )
  }
  let footer(self) = {
    set text(size: .4em)
    set align(center + bottom)
    utils.call-or-display(self, self.scu-footer)
  }
  self.page-args += (
    paper: "presentation-" + aspect-ratio,
    header: header,
    footer: footer,
    header-ascent: 30%,
    footer-descent: 30%,
    margin: (top: 3em, bottom: 1.5em, x: 0em),
  )
  self.padding = (x: 2em, y: 0em)
  // register methods
  self.methods.slide = slide
  self.methods.title-slide = title-slide
  self.methods.outline-slide = outline-slide
  self.methods.new-section-slide = new-section-slide
  self.methods.touying-new-section-slide = new-section-slide
  self.methods.focus-slide = focus-slide
  self.methods.slides = slides
  self.methods.touying-outline = (self: none, enum-args: (:), ..args) => {
    states.touying-outline(enum-args: (tight: false) + enum-args, ..args)
  }
  self.methods.alert = (self: none, it) => text(fill: self.colors.secondary-light, it)
  self
}
