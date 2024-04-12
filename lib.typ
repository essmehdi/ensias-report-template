#let IMAGE_BOX_MAX_WIDTH = 120pt
#let IMAGE_BOX_MAX_HEIGHT = 50pt

#let project(title: "", subtitle: none, school-logo: "images/ENSIAS.svg", company-logo: none, authors: (), mentors: (), jury: (), branch: none, academic-year: none, body) = {
  // Set the document's basic properties.
  set document(author: authors, title: title)
  set page(
    numbering: "1",
    number-align: center,
    footer: locate(loc => {
      // Omit page number on the first page
      let page-number = counter(page).at(loc).at(0);
      if page-number > 1 {
        line(length: 100%, stroke: 0.5pt)
        v(-2pt)
        text(size: 12pt, weight: "regular")[
          ENSIAS
          #h(1fr)
          #page-number
          #h(1fr)
          #academic-year
        ]
      }
    })
  )

  set text(font: "Linux Libertine", lang: "en", size: 13pt)
  set heading(numbering: "1.1")
  
  show heading: it => {
    if it.level == 1 and it.numbering != none {
      pagebreak()
      v(40pt)
      text(size: 30pt)[Chapter #counter(heading).display() #linebreak() #it.body ]
      v(60pt)
    } else {
      v(5pt)
      [#it]
      v(12pt)
    }
  }

  if company-logo == "" {
    company-logo = none
  }
  if school-logo == "" {
    school-logo = none
  }

  if (company-logo != none or school-logo != none) {
    block[
      #box(height: IMAGE_BOX_MAX_HEIGHT, width: IMAGE_BOX_MAX_WIDTH)[
        #if company-logo != none {
          align(left + horizon)[
            #image(company-logo)
          ]
        }
      ]
      #h(1fr)
      #box(height: IMAGE_BOX_MAX_HEIGHT, width: IMAGE_BOX_MAX_WIDTH)[
        #if school-logo != none {
          align(right + horizon)[
            #image(school-logo)
          ]
        }
      ]
    ]
  }
  
  // Title box  
  align(center + horizon)[
    #if subtitle != none {
      text(size: 14pt, tracking: 2pt)[
        #smallcaps[
          #subtitle
        ]
      ]
    }
    #line(length: 100%, stroke: 0.5pt)
    #text(size: 20pt, weight: "bold")[#title]
    #line(length: 100%, stroke: 0.5pt)
  ]

  // Credits
  box()
  h(1fr)
  grid(
    columns: (auto, 1fr, auto),
    [
      // Authors
      #if authors.len() > 0 {
        [
          *Author#if authors.len() > 1 {
            [s]
          }* #linebreak()
          #for author in authors {
            [#author #linebreak()]
          }
        ]
      }
    ],
    [
      // Mentor
      #if mentors != none and mentors.len() > 0 {
        align(right)[
          *Mentor#if mentors.len() > 1 {
            [s]
          }* #linebreak()
          #for mentor in mentors {
            mentor
            linebreak()
          }
        ]
      }
      // Jury
      #if jury != none and jury.len() > 0 {
        align(right)[
          *Jury* #linebreak()
          #for prof in jury {
            [#prof #linebreak()]
          }
        ]
      }
    ]
  )

  align(center + bottom)[
    #if branch != none {
      branch
      linebreak()
    }
    #if academic-year != none {
      [Academic year: #academic-year]
    }
  ]
  
  pagebreak()

  // Table of contents.
  outline(depth: 3, indent: true)

  pagebreak()

  // Table of figures.
  outline(
    title: [Table of figures],
    target: figure.where(kind: image)
  )

  pagebreak()

  outline(
    title: [Table of tables],
    target: figure.where(kind: table)
  )

  pagebreak()
  
  // Main body.
  body
}