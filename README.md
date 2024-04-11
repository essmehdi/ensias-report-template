# ENSIAS Report Typst Template

A Typst template to quickly make reports for projects at ENSIAS. This template was created based on our reports that we also made for our projects.

## What does it provide?

For now, it provides a first page style that matches the common reports style used and encouraged at ENSIAS.

It also provides a style for first level headings to act as chapters

## Usage

```typ
#import "@preview/ensias-report": project

#show: project.with(
  title: "Example title",
  subtitle: "A hecker's guide",
  authors: (
    "Amine Hadnane",
    "Mehdi Essalehi"
  ),
  mentors: (
    "Pr. John Smith (Internal)",
    "Jane Doe (External)"
  ),
  jury: (
    "Pr. John Smith",
    "Pr. Jane Doe"
  ),
  branch: "Software Engineering",
  academic-year: "2077-2078"
)

// Put then your content here
```