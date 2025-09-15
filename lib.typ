/// `unchecked-sym` function.
///
/// - `fill`: [`string`] - The fill color for the unchecked symbol.
/// - `stroke`: [`string`] - The stroke color for the unchecked symbol.
/// - `radius`: [`string`] - The radius of the unchecked symbol.
/// - `size`: [`length`] - The size of the unchecked symbol
#let unchecked-sym(fill: white, stroke: rgb("#616161"), radius: .1em, size: 0.8em, vshift: 0.1em) = move(dy: vshift, {
  box(
    height: 0pt,
    width: size / 4,
  )
  box(
    stroke: size/16 + stroke,
    fill: fill,
    height: size / 2,
    width: size / 2,
    radius: radius,
    outset: size / 4,
  )
  box(
    height: 0pt,
    width: size / 4,
  )
})

/// `checked-sym` function.
///
/// - `fill`: [`string`] - The fill color for the checked symbol.
/// - `stroke`: [`string`] - The stroke color for the checked symbol.
/// - `radius`: [`string`] - The radius of the checked symbol.
/// - `size`: [`length`] - The size of the checked symbol
/// - `light` : ['bool'] - The style of the checked symbol (light or dark)
#let checked-sym(fill: white, stroke: rgb("#616161"), radius: .1em, size: 0.8em, vshift: 0.1em, light: false) = move(
  dy: vshift, {
    box(
      height: 0pt,
      width: size / 4,
    )
    box(
      stroke: size/16 + stroke,
      fill: if light { fill } else { stroke },
      height: size / 2,
      width: size / 2,
      radius: radius,
      outset: size / 4,
      {
        place(dy: 0.22 * size , dx: -0.04 * size, 
        rotate(45deg, reflow: false, origin: left+horizon,
        line(
          length: 3 * size / 8 ,
          stroke: if light { stroke } else { fill } + size/8,
        )
        )
        )
        place(dy: 0.442 * size , dx: 0.18 * size, 
        rotate(-45deg, reflow: false, origin: left+horizon,
        line(
          length: 0.6 * size,
          stroke: if light { stroke } else { fill } + size/8,
        )
        )
        )
      },
    )
    box(
      height: 0pt,
      width: size / 4,
    )
  },
)

/// `incomplete-sym` function.
///
/// - `fill`: [`string`] - The fill color for the incomplete symbol.
/// - `stroke`: [`string`] - The stroke color for the incomplete symbol.
/// - `radius`: [`string`] - The radius of the incomplete symbol.
///  - `size`: [`length`] - The size of the incomplete symbol
/// - `light` : ['bool'] - The style of the incomplete symbol (light or dark)
#let incomplete-sym(fill: white, stroke: rgb("#616161"), radius: .1em, size: 0.8em, vshift: 0.1em, light: false) = move(
  dy: vshift, {
    box(
      height: 0pt,
      width: size / 4,
    )
    box(
      stroke: size/16 + stroke,
      fill: fill,
      height: size / 2,
      width: size / 2,
      radius: radius,
      outset: size / 4,
      if light {
        box(move(dy: size / 2, dx: 0.0em, rotate(90deg, reflow: false, line(
          length: size,
          stroke: stroke + size*3/32,
        ))))
      } else {
        move(dy: -size / 4, dx: size / 4, box(fill: stroke, height: size, width: size / 2, radius: (
          top-left: radius,
          bottom-left: radius,
        )))
      },
    )
    box(
      height: 0pt,
      width: size / 4,
    )
  },
)

/// `canceled-sym` function.
///
/// - `fill`: [`string`] - The fill color for the canceled symbol.
/// - `stroke`: [`string`] - The stroke color for the canceled symbol.
/// - `radius`: [`string`] - The radius of the canceled symbol.
///  - `size`: [`length`] - The size of the canceled symbol
/// - `light` : ['bool'] - The style of the canceled symbol (light or dark)
#let canceled-sym(fill: white, stroke: rgb("#616161"), radius: .1em, size: 0.8em, vshift: 0.1em, light: false) = move(
  dy: vshift, {
    box(
      height: 0pt,
      width: size / 4,
    )
    box(
      stroke: size/16 + stroke,
      fill: if light { fill } else { stroke },
      height: size / 2,
      width: size / 2,
      radius: radius,
      outset: size / 4,
      {
        align(center + horizon, box(height: .16 * size, width: 0.7*size, fill: if light { stroke } else { fill }))
      },
    )
    box(
      height: 0pt,
      width: size / 4,
    )
  },
)


/// `character-sym` function.
///
/// - `symbol`: [`string`] - The character that will be put inside the checkbox
/// - `fill`: [`string`] - The fill color for the character symbol.
/// - `stroke`: [`string`] - The stroke color for the character symbol.
/// - `radius`: [`string`] - The radius of the character symbol.
///  - `size`: [`length`] - The size of the character symbol
/// - `light` : ['bool'] - The style of the character symbol (light or dark)
#let character-sym(
  symbol: " ",
  fill: white,
  stroke: rgb("#616161"),
  radius: .1em,
  size: 0.8em,
  vshift: 0.1em,
  light: false,
) = move(dy: vshift, {
  box(
    height: 0pt,
    width: size / 4,
  )
  box(
    stroke: size/16 + stroke,
    fill: if light { fill } else { stroke },
    height: size / 2,
    width: size / 2,
    radius: radius,
    outset: size / 4,
    {
      align(center + horizon, text(size: size, fill: if light { stroke } else { fill }, weight: "bold", symbol))
    },
  )
  box(
    height: 0pt,
    width: size / 4,
  )
})


#let to-string(content) = {
  if type(content) == str {
    content
  } else if content.has("text") {
    content.text
  } else if content.has("children") {
    content.children.map(to-string).join("")
  } else if content.has("body") {
    to-string(content.body)
  } else if content == [ ] {
    " "
  }
}

#let first-line(text) = {
  let lines = text.split("[")
  lines.at(0)
}

#let cheq-outline-entry(body, marker) = {
  // invisible figure, s.t. we can reference it in the outline
  // probably depends on https://github.com/typst/typst/issues/147 for a cleaner solution
  hide(
    box(
      height: 0pt,
      width: 0pt,
      figure(
        none,
        kind: "cheq-"+str(marker),
        supplement: [],
        caption: first-line(to-string(body)),
        outlined: true,
      ),
    ),
  )
}


/// `checklist` function.
///
/// Example: `#show: checklist.with(fill: luma(95%), stroke: blue, radius: .2em)`
///
/// **Arguments:**
///
/// - `fill`: [`string`] - The fill color for the checklist marker.
/// - `stroke`: [`string`] - The stroke color for the checklist marker.
/// - `radius`: [`string`] - The radius of the checklist marker.
/// - `light`: [`bool'] - The style of the markers, light or dark.
///  - `size`: [`length`] - The size of the checklist symbols
/// - `marker-map`: [`map`] - The map of the checklist marker. It should be a map of character to symbol function, such as `(" ": sym.ballot, "x": sym.ballot.cross, "-": sym.bar.h, "/": sym.slash.double)`.
/// - `highlight-map`: [`map`] - The map of the highlight functions. It should be a map of characther to functions, see examples.
/// - `highlight`: [`bool`] - The flag to enable or disable the application of highlight functions to the list item.
/// - `extras`: [`bool`] - The flag that includes or excludes the extra map of symbols
/// - `body`: [`content`] - The main body from `#show: checklist` rule.
///
/// The default map is:
///
/// ```typ
/// #let default-map = (
///   "x": checked-sym(fill: fill, stroke: stroke, radius: radius),
///   " ": unchecked-sym(fill: fill, stroke: stroke, radius: radius, light: false),
///   "/": incomplete-sym(fill: fill, stroke: stroke, radius: radius, light: false),
///   "-": canceled-sym(fill: fill, stroke: stroke, radius: radius, light: false),
/// )
/// ```
///
/// The extra map is:
///
/// ```typ
///
/// #let extra-map = (
///   ">": "➡",
///   "<": "📆",
///   "?": "❓",
///   "!": "❗",
///   "*": "⭐",
///   "\"": "❝",
///   "l": "📍",
///   "b": "🔖",
///   "i": "ℹ️",
///   "S": "💰",
///   "I": "💡",
///   "p": "👍",
///   "c": "👎",
///   "f": "🔥",
///   "k": "🔑",
///   "w": "🏆",
///   "u": "🔼",
///   "d": "🔽",
/// )
/// ```
#let checklist(
  fill: white,
  stroke: rgb("#616161"),
  radius: .1em,
  light: false,
  size: 0.8em,
  marker-map: (:),
  highlight-map: (:),
  highlight: true,
  extras: false,
  body,
) = {
  let vshift = 0.35em - size / 4 // Centers vertically the checkmark on the line

  let default-map = (
    " ": unchecked-sym(fill: fill, stroke: stroke, radius: radius, size: size, vshift: vshift),
    "x": checked-sym(fill: fill, stroke: stroke, radius: radius, size: size, vshift: vshift, light: light),
    "/": incomplete-sym(fill: fill, stroke: stroke, radius: radius, size: size, vshift: vshift, light: light),
    "-": canceled-sym(fill: fill, stroke: stroke, radius: radius, size: size, vshift: vshift, light: light),
  )

  let extra-map = (
    ">": "➡",
    "<": "📆",
    "?": "❓",
    "!": "❗",
    "*": "⭐",
    "\"": "❝",
    "l": "📍",
    "b": "🔖",
    "i": "ℹ️",
    "S": "💰",
    "I": "💡",
    "p": "👍",
    "c": "👎",
    "f": "🔥",
    "k": "🔑",
    "w": "🏆",
    "u": "🔼",
    "d": "🔽",
  )

  let default-map = default-map + if extras { extra-map } else { (:) }

  let marker-map = default-map + marker-map

  let default-highlight = (
    "-": it => { strike(text(fill: rgb("#888888"), it)) },
  )
  let highlight-map = default-highlight + highlight-map

  show list: it => {
    let is-checklist = false
    let items-list = ()
    let symbols-list = ()
    let default-marker = if type(it.marker) == array {
      it.marker.at(0)
    } else {
      it.marker
    }

    for list-children in it.children {
      if not (type(list-children.body) == content and list-children.body.func() == [].func()) {
        symbols-list.push(default-marker)
        items-list.push(list-children.body)
      } else {
        let children = list-children.body.children

        // A checklist item has at least 5 children: `[`, marker, `]`, space, content
        if children.len() < 5 or not (children.at(0) == [#"["] and children.at(2) == [#"]"] and children.at(3) == [ ]) {
          symbols-list.push(default-marker)
          items-list.push(list-children.body)
        } else {
          let marker-text = if children.at(1) == [ ] {
            " "
          } else if children.at(1) == ["] {
            "\""
          } else if children.at(1) == ['] {
            "'"
          } else if children.at(1).has("text") {
            children.at(1).text
          } else {
            none
          }

          if marker-text != none {
            is-checklist = true
            if marker-text in marker-map and marker-map.at(marker-text) != none {
              if "html" in dictionary(std) and target() == "html" {
                list.item(
                  box(if marker-text == "x" {
                    html.elem("input", attrs: (
                      type: "checkbox",
                      style: "margin: 0 .2em .25em -1.4em; vertical-align: middle;",
                      checked: "checked",
                    ))
                  } else if marker-text == " " {
                    html.elem("input", attrs: (
                      type: "checkbox",
                      style: "margin: 0 .2em .25em -1.4em; vertical-align: middle;",
                    ))
                  } else if type(marker-map.at(marker-text)) == str {
                    html.elem(
                      "span",
                      attrs: (
                        style: "display: inline-flex; align-items: center; justify-content: center; width: 1em; height: 1em; vertical-align: middle; margin: 0 .2em .25em -1.4em;",
                      ),
                      marker-map.at(marker-text),
                    )
                  } else {
                    html.elem(
                      "span",
                      attrs: (
                        style: "display: inline-flex; align-items: center; justify-content: center; width: 1em; height: 1em; vertical-align: middle; margin: 0 .2em .25em -1.3em;",
                      ),
                      html.frame(marker-map.at(marker-text)),
                    )
                  })
                    + children.slice(4).sum(),
                )
              } else {
                symbols-list.push(marker-map.at(marker-text))
              }
            } else {
              symbols-list.push(character-sym(
                symbol: marker-text,
                fill: fill,
                stroke: stroke,
                radius: radius,
                size: size,
                vshift: vshift,
                light: light,
              ))
            }
            if not ("html" in dictionary(std) and target() == "html") {
              if highlight {
                let highligh-func = highlight-map.at(marker-text, default: it => { it })
                items-list.push(highligh-func([#cheq-outline-entry(children.slice(4).sum(), marker-text)#children.slice(4).sum()]))
              } else {
                items-list.push([#cheq-outline-entry(children.slice(4).sum(), marker-text)#children.slice(4).sum()
                ])
              }
            }
          } else {
            symbols-list.push(default-marker)
            items-list.push(list-children.body)
          }
        }
      }
    }

    if is-checklist {
      if not ("html" in dictionary(std) and target() == "html") {
        enum(
          numbering: (.., n) => { symbols-list.at(n - 1) },
          tight: it.tight,
          indent: it.indent,
          body-indent: it.body-indent,
          spacing: it.spacing,
          number-align: end + top,
          ..items-list,
        )
      }
    } else {
      it
    }
  }

  body
}
