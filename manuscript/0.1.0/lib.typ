// = Hello Typst
#import "@preview/numblex:0.2.0": numblex

#let info(
  title: none,
  subtitle: none,
  language: "zh",
  paper_author: none,
  authors: (
    (
      name: none,
      affiliation: none,
      email: none,
    ),
  ),
  abstract: none,
  keywords: none,
  doc,
) = {
  let abstract_title = "摘要"
  let keywords_list = "关键词"
  if language != "zh" {
    abstract_title = "Abstract"
    keywords_list = "Keywords"
  } else {
    let abstract_title = "摘要"
    let keywords_list = "关键词"
  }
  // Set and show rules from before.
  // set text(font: "SimSun")
  set text(font: ("Times New Roman", "Songti SC"), size: 12pt)
  set align(center)
  text(20pt, strong[#title])

  if subtitle != none {
    v(-1em)
    text(16pt, subtitle)
  }
  if type(paper_author) == content {
    v(0em)
    text(10pt, strong[#paper_author])
  }

  set par(justify: true, leading: 1em)
  let count = authors.len()
  let ncols = calc.min(count, 3)
  grid(
    columns: (2fr,) * ncols,
    row-gutter: 24pt,
    ..authors.map(author => [
      #set align(center)
      #grid(
        align: center,
        gutter: 4pt,
        rows: 1em,
        [#author.name #h(0.5em) #author.number],
        [#author.affiliation],
        if author.keys().contains("mail") {
          [#author.email]
        },
      )
    ]),
  )
  v(-2em)
  // [#type(abstract) == content]
  if type(abstract) == content {
    set align(left)
    h(2em)
    align(left)[#h(2em) #strong[#abstract_title]: #abstract]
  }
  set align(left)
  if type(keywords) == content {
    set par(first-line-indent: 0em)
    box[
      #h(2em)
      #strong[#keywords_list]:
      #text(font: ("Times New Roman", "KaiTi_GB2312"))[#strong[#keywords]]
    ]
  }
  show figure: it => {
    it
    h(2em)
  }

  // show heading:
  // set par(leading: 0.5em)
  set heading(numbering: numblex("{[一]、:d==1}{[(一)]}:d==2"))
  show heading: it => {
    [#it]
    h(2em)
    // par[#text(size: 0.0em)[#h(0.0em)]]
  }
  // show heading.where(level: 1): it => {
  //   set text(size: 14pt)
  //   [#it]
  //   // counter(math.equation).update(0)
  //   // counter(math.equation).step(level: 2)
  //   // counter("theorem").step(level: 1)
  // }
  // box[ #type(keywords)]
  show heading.where(level: 1): it => {
    set text(size: 14pt)
    align(center)[#it]
  }
  show heading.where(level: 2): it => {
    v(-0.5em)
    set text(size: 12pt)
    // h(2em)
    [#it]
  }

  show par: it => {
    [#it]
  }
  show par: set block(spacing: .5em)
  // set par(leading: 0.5em)
  set par(first-line-indent: 2em, leading: 0.5em)
  show figure.where(kind: table): set figure.caption(position: top)
  set text(size: 12pt)
  doc
}

#let eq_num(it) = {
  set math.equation(
    // numbering: x => numbering("(1.1)", counter(heading).get().at(0), x),
    numbering: "(1)",
    supplement: [公式],
  )
  it
  h(2em)
}
