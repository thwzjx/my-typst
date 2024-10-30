// = Hello Typst

#let info(
  title: none,
  language: "zh",
  paper_author: none,
  authors: (
    (
      name: none,
      affiliation: none,
      email: none,
    ),
  ),
  abstract: [],
  keywords: [],
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
  set text(font: ("Times New Roman", "SimSun", "Songti SC"))
  set align(center)
  text(22pt, strong[#title])

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
      #set align(right)
      #grid(
        align: right,
        gutter: 4pt,
        rows: 1em,
        [#author.name],
        [#author.number],
        [#author.affiliation],
        if author.keys().contains("mail") {
          [#author.email]
        },
      )
    ]),
  )
  v(-2em)
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
  set heading(numbering: "1.1")
  show heading: it => {
    [#it]
    h(2em)
  }
  show heading.where(level: 1): it => {
    [#it]
    // counter(math.equation).update(0)
    // counter(math.equation).step(level: 2)
    // counter("theorem").step(level: 1)
  }
  // box[ #type(keywords)]
  show heading.where(level: 1): it => {
    align(center)[#it]
  }
  set par(first-line-indent: 2em, leading: 0.5em)
  show par: it => {
    [#it]
  }
  show par: set block(spacing: 1em)
  set par(leading: 1em)
  show figure.where(kind: table): set figure.caption(position: top)
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


