#let _unchecked_prefix = [[ ] ]
#let _checked_prefix = [[x] ]
#let _incomplete_prefix = [[/] ]
#let _cancelled_prefix = [[-] ]
#let _forwarded_prefix = [[>] ]
#let _scheduling_prefix = [[<] ]
#let _question_prefix = [[?] ]
#let _important_prefix = [[!] ]
#let _star_prefix = [[\*] ]
#let _quote_prefix = [["] ]

#let unchecked-sym(fill: white, stroke: rgb("#616161"), radius: .1em) = move(
  dy: -.08em,
  box(stroke: .05em + stroke, fill: fill, height: .8em, width: .8em, radius: radius),
)

#let checked-sym(fill: white, stroke: rgb("#616161"), radius: .1em) = move(
  dy: -.08em,
  box(
    stroke: .05em + stroke,
    fill: stroke,
    height: .8em,
    width: .8em,
    radius: radius,
    {
      box(move(dy: .48em, dx: 0.1em, rotate(45deg, line(length: 0.3em, stroke: fill + .1em))))
      box(move(dy: .38em, dx: -0.05em, rotate(-45deg, line(length: 0.48em, stroke: fill + .1em))))
    },
  ),
)

#let incomplete-sym(fill: white, stroke: rgb("#616161"), radius: .1em) = move(
  dy: -.08em,
  box(
    stroke: .05em + stroke,
    fill: fill,
    height: .8em,
    width: .8em,
    radius: radius,
    {
      move(dx: 0.39em, box(fill: stroke, height: .8em, width: .4em, radius: (top-right: radius, bottom-right: radius)))
    },
  ),
)

#let checklist(
  fill: white,
  stroke: rgb("#616161"),
  radius: .1em,
  default: ([•], [‣], [–]),
  unchecked: auto,
  checked: auto,
  incomplete: auto,
  cancelled: auto,
  forwarded: auto,
  scheduling: auto,
  question: auto,
  important: auto,
  star: auto,
  quote: auto,
  body,
) = {
  if unchecked == auto {
    unchecked = unchecked-sym(fill: fill, stroke: stroke, radius: radius)
  }

  if checked == auto {
    checked = checked-sym(fill: fill, stroke: stroke, radius: radius)
  }

  if incomplete == auto {
    incomplete = incomplete-sym(fill: fill, stroke: stroke, radius: radius)
  }

  if cancelled == auto {
    cancelled = default
  }

  if forwarded == auto {
    forwarded = default
  }

  if scheduling == auto {
    scheduling = default
  }

  if question == auto {
    question = default
  }

  if important == auto {
    important = default
  }

  if star == auto {
    star = default
  }

  if quote == auto {
    quote = default
  }

  show list.item: it => {
    if type(it.body) == content and it.body.func() == [].func() {
      let children = it.body.children

      // A checklist item has at least 5 children: `[`, markder, `]`, space, content
      if children.len() >= 5 {
        let prefix = children.slice(0, 4).sum()

        if prefix == _unchecked_prefix {
          list(
            marker: unchecked,
            children.slice(4).sum(),
          )
        } else if prefix == _checked_prefix {
          list(
            marker: checked,
            children.slice(4).sum(),
          )
        } else if prefix == _incomplete_prefix {
          list(
            marker: incomplete,
            children.slice(4).sum(),
          )
        } else if prefix == _cancelled_prefix {
          list(
            marker: cancelled,
            children.slice(4).sum(),
          )
        } else if prefix == _forwarded_prefix {
          list(
            marker: forwarded,
            children.slice(4).sum(),
          )
        } else if prefix == _scheduling_prefix {
          list(
            marker: scheduling,
            children.slice(4).sum(),
          )
        } else if prefix == _question_prefix {
          list(
            marker: question,
            children.slice(4).sum(),
          )
        } else if prefix == _important_prefix {
          list(
            marker: important,
            children.slice(4).sum(),
          )
        } else if prefix == _star_prefix {
          list(
            marker: star,
            children.slice(4).sum(),
          )
        } else if prefix == _quote_prefix {
          list(
            marker: quote,
            children.slice(4).sum(),
          )
        } else {
          it
        }
      } else {
        it
      }
    } else {
      it
    }
  }

  body
}