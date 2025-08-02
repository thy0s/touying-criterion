/*
"Criterion" theme by thy0s
Inspired by:
  - https://github.com/touying-typ/touying/blob/main/themes/university.typ
  - https://github.com/touying-typ/touying/blob/main/themes/metropolis.typ
*/

#import "@preview/touying:0.6.1": *

#let highlight-box(body) = block(
  width: 95%,
  fill: rgb("#e0e0e0"),
  inset: 0.3em,
  radius: 4pt,
  stroke: 1pt + rgb("#a0a0a0"),
  body
)

#let slide(
  title: auto, 
  show-level-one: true, 
  ..args
) = touying-slide-wrapper(self => {
  if title != auto {
    self.store.title = title
  }
  let header(self) = {
    set align(top)
    show: components.cell.with(fill: self.colors.primary, inset: 1em)
    set align(horizon)
    set text(fill: self.colors.neutral-lightest, size: .7em)

    if show-level-one {
      utils.display-current-heading(level: 1)
      linebreak()
    } 
    set text(size: 1.8em, weight: "bold", )
    if self.store.title != none {
      utils.call-or-display(self, self.store.title)
    } else {
      utils.display-current-heading(level: 2)
    }
  }
  let footer(self) = {
    set align(bottom)
    show: pad.with(.4em)
    set text(fill: self.colors.neutral-darkest, size: .7em)
    utils.call-or-display(self, self.store.footer)
    h(1fr)
    context utils.slide-counter.display() + " / " + utils.last-slide-number
  }
  self = utils.merge-dicts(
    self,
    config-page(
      header: header,
      footer: footer,
    ),
  )
  touying-slide(self: self, ..args)
})

#let title-slide(
  config: (:),
  extra: none,
  ..args,
) = touying-slide-wrapper(self => {
  self = utils.merge-dicts(
    self,
    config,
    config-common(freeze-slide-counter: true),
    config-page(fill: self.colors.neutral-lightest),
  )
  let info = self.info + args.named()
  let body = {
    set text(fill: self.colors.neutral-darkest)
    set std.align(horizon)
    block(
      width: 100%,
      inset: 2em,
      {
        components.left-and-right(
          {
            text(size: 1.5em, text(weight: "bold", fill: self.colors.primary, info.title))
            if info.subtitle != none {
              linebreak()
              block(spacing: 1em, text(weight: "medium" , info.subtitle))
            }
          },
          text(2em, utils.call-or-display(self, info.logo)),
        )
        line(length: 100%, stroke: 2pt + self.colors.primary)
        set text(size: .9em)
        if info.author != none {
          block(spacing: 1em, info.author)
        }
        if info.institution != none {
          block(spacing: 1em, info.institution)
        }
        if info.date != none {
          block(spacing: 1em, info.date.display("[year]-[month]-[day]"))
        }
        if extra != none {
          block(spacing: 1em, extra)
        }
      },
    )
  }
  touying-slide(self: self, body)
})

#let outline-slide(
  depth: 2
) = slide(
  title: "Outline",
  show-level-one: false,
  )[
    #show outline.entry.where(level: 1): it => strong(it)
    #components.adaptive-columns(
      outline(
        title: none, 
        indent: auto,
        depth: depth,
      )
    )
  ] 

#let new-section-slide(
  config: (:), 
  level: 1, 
  numbered: true, 
  body
) = touying-slide-wrapper(self => {
  let slide-body = {
    set std.align(horizon)
    show: pad.with(20%)
    set text(size: 1.8em, fill: self.colors.primary, weight: "bold")
    stack(
      dir: ttb,
      spacing: .65em,
      utils.display-current-heading(level: level, numbered: numbered),
      block(
        height: 2pt,
        width: 100%,
        spacing: 0pt,
        components.progress-bar(height: 2pt, self.colors.primary, self.colors.secondary),
      ),
    )
    body
  }
  touying-slide(self: self, config: config, slide-body)
})

#let focus-slide(body) = touying-slide-wrapper(self => {
  self = utils.merge-dicts(
    self,
    config-page(
      fill: self.colors.primary,
      margin: 2em,
    ),
  )
  set text(fill: self.colors.neutral-lightest, size: 2em)
  touying-slide(self: self, align(horizon + center, body))
})

#let haw-theme(
  aspect-ratio: "16-9",
  footer: none,
  ..args,
  body,
) = {
  set text(size: 22pt, font: "Source Sans 3")
  show: touying-slides.with(
    config-page(
      paper: "presentation-" + aspect-ratio,
      margin: (top: 3.5em, bottom: 1.5em, x: 2em),
    ),
    config-common(
      slide-fn: slide,
      new-section-slide-fn: new-section-slide,
    ),
    config-methods(alert: (self: none, it) => text(fill: self.colors.primary, it)),
    config-colors(
      primary: rgb("003366"),
      secondary:  rgb("CCE5FF"),
      neutral-lightest: rgb("FFFFFF"),
      neutral-darkest: rgb("000000"),
    ),
    config-store(
      title: none,
      footer: footer,
    ),
    ..args,
  )
  body
}