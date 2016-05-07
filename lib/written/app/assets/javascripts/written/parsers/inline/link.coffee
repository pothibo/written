class Link
  constructor: (match) ->
    @match = match

  index: =>
    @match.index 

  length: =>
    @match[0].length

  markdown: =>
    "<a is='written-a' href='javascript:void(0)'><strong>#{@match[1]}</strong>#{@match[3]}</a>".toHTML()

  html: =>
    "<a href='#{@match[4]}'>#{@match[2]}</a>".toHTML()

Link.rule = /!{0}(\[([^\]]+)\])(\(([^\)]+)\))/gi

Written.Parsers.Inline.register Link

prototype = Object.create(HTMLAnchorElement.prototype)

prototype.getRange = (offset, walker) ->
  range = document.createRange()

  if !@firstChild?
    range.setStart(this, 0)
  else
    while walker.nextNode()
      if walker.currentNode.length < offset
        offset -= walker.currentNode.length
        continue

      range.setStart(walker.currentNode, offset)
      break

  range.collapse(true)
  range

prototype.toString = ->
  @textContent

document.registerElement('written-a', {
  prototype: prototype
  extends: 'a'
})
