#let thmcounters = state(
  "thm",
  (
    "counters": ("heading": ()),
    "latest": (),
  ),
)
#let math_environment_generator(
  initialnizer,
  base: "heading",
  base_level: none,
  // font_style: none,
  // title_fill: none,
) = {
  let global_numbering = numbering
  return (
    ..args,
    body,
    name: none,
    supplement: initialnizer,
    number: auto,
    numbering: "1.1",
    refnumbering: auto,
    base: base,
    base_level: base_level,
  ) => {
    if refnumbering == auto {
      refnumbering = numbering
    }
    let result = none
    if number == auto and numbering == none {
      number = none
    }
    let num = context {
      query(selector(heading.where(level: 1)).before(here())).len()
    }
    if number == auto and numbering != none {
      result = locate(loc => {
        return thmcounters.update(thmpair => {
          let counters = thmpair.at("counters")
          // Manually update heading counter
          counters.at("heading") = counter(heading).at(loc)
          if not initialnizer in counters.keys() {
            counters.insert(initialnizer, (0,))
          }

          let tc = counters.at(initialnizer)
          if base != none {
            let bc = counters.at(base)

            // Pad or chop the base count
            if base_level != none {
              if bc.len() < base_level {
                bc = bc + (0,) * (base_level - bc.len())
              } else if bc.len() > base_level {
                bc = bc.slice(0, base_level)
              }
            }

            // Reset counter if the base counter has updated
            if tc.slice(0, -1) == bc {
              counters.at(initialnizer) = (..bc, tc.last() + 1)
            } else {
              counters.at(initialnizer) = (..bc, 1)
            }
          } else {
            // If we have no base counter, just count one level
            counters.at(initialnizer) = (tc.last() + 1,)
            let latest = counters.at(initialnizer)
          }

          let latest = counters.at(initialnizer)
          return (
            "counters": counters,
            "latest": latest,
          )
        })
      })
      number = thmcounters.display(x => {
        return global_numbering(numbering, ..x.at("latest"))
      })
    }
    let environname = upper(initialnizer)
    return figure(
      align(left)[
        #block(width: 100%)[
          #result
          // #number
          #strong[#environname] #number (#name) \
          #align(left)[
            #body]
        ]],
      kind: initialnizer,
      supplement: initialnizer,
      numbering: x => number,
    )
  }
}

#let theenv = math_environment_generator("定理", base_level: 1)
#let def = math_environment_generator("定义", base_level: 1)
#let col = math_environment_generator("引理", base_level: 1)
#let pro = math_environment_generator("证明")
// TODO 样式设计