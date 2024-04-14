// Workaround for the lack of an `std` scope.
#let std-bibliography = bibliography

// This function gets your whole document as its `body` and formats
// it as an article in the style of the IEEE.
// Taken from https://github.com/typst/templates/tree/main/charged-ieee
#let ieee(
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

  pagebreak()

  // Configure the page.
  set page(paper: "a4")

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
  pagebreak()

  set page(numbering: "1")
  counter(page).update(1)


  // Display the paper's contents.
  body

  // Display bibliography.
  if bibliography != none {
    show std-bibliography: set text(8pt)
    set std-bibliography(title: text(10pt)[References], style: "ieee")
    bibliography
  }
}
