#import "@preview/fontawesome:0.2.0": *
#import "@preview/codly:0.2.0": *
#import "@preview/drafting:0.2.0": *


#let link-icon = super[#fa-arrow-up-right-from-square()]

// Workaround for the lack of an `std` scope.
#let std-bibliography = bibliography

// This function gets your whole document as its `body` and formats
// it as an article in the style of the IEEE.
// Taken from https://github.com/typst/templates/tree/main/charged-ieee
#let template(
  // The paper's title.
  title: [Paper Title],

  // An array of authors. For each author you can specify a name,
  // department, organization, location, and email. Everything but
  // but the name is optional.
  authors: (),

  // The paper's abstract. Can be omitted if you don't have one.
  abstract: none,

  preface: [Preface goes here],

  // A list of index terms to display after the abstract.
  index-terms: (),

  // The result of a call to the `bibliography` function or `none`.
  bibliography: none,

  // The paper's content.
  body
) = {
  // Set document metadata.
  set document(title: title, author: authors.map(author => author.name))
  set text(font: "Noto Sans", lang: "en")
  set heading(numbering: "1.1")

  show link: set text(style: "italic")

  pagebreak()

  // Configure the page.
  set page(paper: "a4", margin: 2.5cm)

  set align(center + horizon)
  preface
  set align(top + left)

  pagebreak()

  set page(numbering: "I")
  counter(page).update(1)

  // Display abstract and index terms.
  if abstract != none [
    #set text(weight: 700)
    #h(1em) _Abstract_---#h(weak: true, 0pt)#abstract

    #if index-terms != () [
      #h(1em)_Index terms_---#h(weak: true, 0pt)#index-terms.join(", ")
    ]
    #v(2pt)
  ]
  pagebreak()


  // Table of contents.
  outline(depth: 3, indent: true)

  set page(numbering: "1")
  counter(page).update(1)

  set par(leading: 10pt, justify: true)
  show par: set block(above: 1em, below: 2em)

  show figure: set block(breakable: true, below: 2em)
  show figure.caption: emph

  let icon(codepoint) = {
    box(
      height: 0.8em,
      baseline: 0.05em,
      image(codepoint)
    )
    h(0.1em)
  }

  show: codly-init.with()
  codly(languages: (
    tsv: (name: "TSV", icon: icon("images/tsv.png"), color: gray),
    csv: (name: "CSV", icon: icon("images/csv.png"), color: gray),
  ))

  set-page-properties()
  
  show heading.where(level: 1): it => pagebreak(weak: true) + it

  // Display the paper's contents.
  body

  // Display bibliography.
  if bibliography != none {
    show std-bibliography: set text(8pt)
    set std-bibliography(title: text(10pt)[References], style: "ieee")
    bibliography
  }
}
