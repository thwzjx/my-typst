#import "@local/touying:0.1.0": *
#import "@preview/showybox:2.0.1": showybox
#set text(font: "LXGW WenKai")
#set par(justify: true)
// Themes: default, simple, metropolis, dewdrop, university, aqua
#let s = themes.scu.register(aspect-ratio: "4-3")
#let s = (s.methods.info)(
  self: s,
  title: [Start Your Writing in Touying],
  subtitle: [Subtitle],
  author: [Author],
  date: [2024年7月1日],
  institution: [Institution],
)
#let (init, slides, touying-outline, alert) = utils.methods(s)
#show: init

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
  [- dsahdkasd
      - sdhakjdhakj
      - sdsadad
  ],
  [],
)