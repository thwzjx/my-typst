#import "@local/touying:0.1.0": *

// Themes: default, simple, metropolis, dewdrop, university, aqua
#let s = themes.metropolis.register(aspect-ratio: "4-3")
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

#show strong: alert

#let (slide, title-slide, focus-slide) = utils.slides(s)
#show: slides


= The Section

== Slide Title

Slide content.