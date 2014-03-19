class Node
  constructor: (@data) ->

class LinkedList
  constructor: () ->
    @head   = null
    @length = 0

  incrementLength: ->
    @length += 1

  at: (index) ->
    if index > @length or index < 0
      console.log "Out of bounds"
      return false

    current = @head
    i = 0
    current = current.next while i++ < index

    return current

  get: (index) ->
    @at(index).data

  append: (data) ->
    unless data
      console.log("Needs an input")
      return false

    unless @head?
      @head = new Node(data)
      @incrementLength()
      return @

    # we don't have an empty list.
    current = @head
    current = current.next while current.next?
    current.next = new Node(data)

    @incrementLength()

    return @

  prepend: (data) ->
    unless data
      console.log("Needs an input")
      return false

    restOfTheList = @head
    @head = new Node(data)
    @head.next = restOfTheList

    @incrementLength()

    return @

  insertAt: (index, data) ->
    if index > @length or index < 0
      console.log "Out of bounds"
      return false

    return @prepend(data) if index == 0
    return @append(data)  if index == @length

    beforeNode      = @at(index - 1)
    restOfTheList   = beforeNode.next
    newNode         = new Node(data)
    beforeNode.next = newNode
    newNode.next    = restOfTheList

    @incrementLength()

    return @

module?.exports = LinkedList
