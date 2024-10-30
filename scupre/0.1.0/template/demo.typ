#import "@preview/ctheorems:1.1.0": *
#import "@preview/showybox:2.0.1": showybox

#show: thmrules

#set page(width: 16cm, height: auto)
#set heading(numbering: "1.")

#let showythm(
  identifier,
  head,
  color: blue,
  ..showy-args,
  supplement: auto,
  base: "heading",
  base_level: none,
) = {

  if supplement == auto {
    supplement = head
  }

  return thmenv(
    identifier,
    base,
    base_level,
    (name, number, body, ..args) => {
      if name != none {
        name = [(#name)]
      }
      showybox(
        title: [#head #number #name],
        frame: (
          border-color: color,
          title-color: color.lighten(10%),
          body-color: color.lighten(95%),
          footer-color: color.lighten(80%),
        ),
        ..args.named(),
        body,
      )
    }
  ).with(supplement: head)
}

#let theorem = showythm("theorem", "Theorem")
#let lemma = showythm("lemma", "Lemma", base: "heading", color: rgb("#2d6341"))
#let corollary = showythm(
  "corollary",
  "Corollary",
  base: "heading",
  color: red,
)


= Using `showybox` with `ctheorems`

#theorem(
  "Stokes' theorem",
  footer: "Information extracted from a well-known public encyclopedia",
)[
  $
    integral.double_Sigma (bold(nabla) times bold(F)) dot bold(Sigma) =
    integral.cont_(diff Sigma) bold(F) dot dif bold(Gamma)
  $
] <stokes>

#lemma("阴历")[
  #lorem(20)
]

#corollary(lorem(5))[
  #lorem(15)

  Refer to @stokes.
]