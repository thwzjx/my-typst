#import "@local/scupre:0.1.0": *
// Themes: default, simple, metropolis, dewdrop, university, aqua, scu
#let s = themes.scu.register(aspect-ratio: "4-3")
#let s = (s.methods.info)(
  self: s,
  title: [Start Your Writing in Touying],
  subtitle: [Subtitle],
  author: [Author],
  date: datetime.today(),
  institution: [Institution],
)
#let (init, slides, touying-outline, alert) = utils.methods(s)
#show: init
#set text(font: ("Times New Roman", "LXGWWenKai"))
#show strong: alert

#let (slide, title-slide, focus-slide) = utils.slides(s)
#show: slides

= The Section

== Slide Title
一个简单的测试
#strong[sjdagjdgaj]

= 测试

== 新的测试

Slide content.



#lorem(60)
// #touying-outline()
// #scu-outline()
= 呢哇

#grid(
  align: center,
  [一个简单的的恶事],
)

== 东安等俺

= 塞阿甘大僧

#grid(
  columns: 2,
  column-gutter: 2em,
  [- dsahdkasd
      - sdhakjdhakj
      - sdsadad
  ],
  [ - dsakdhk
    - dassjkdhajk
    - hjhdakshk
  ],
)

// ... existing code ...

// 定义计数器
#let theorem-counter = counter("theorem")

// 定义theorem环境
#let theorem(body) = {
  // 获取当前节的编号
  context{
    let section-number = counter(heading).get().at(0)
  
  
  theorem-counter.step()
  let theorem-number = theorem-counter.display()
  
  block(
    fill: rgb("#f0f0f0"),
    inset: 10pt,
    radius: 4pt,
    width: 100%,
  )[
    *定理 #section-number.#theorem-number.* #emph(body)
  ]
  }
}

// ... existing code ...

== 新的测试

// 设置1.2倍行间距
// #let line-spacing = 1.2
// #set par(leading: 1em)

Slide content.

#theorem[这是第一个定理。]

#lorem(30)

#theorem[这是第二个定理。]

// ... existing code ...


= 新的章节

== 另一个测试

#theorem[这是新章节的第一个定理。]

// ... existing code ...