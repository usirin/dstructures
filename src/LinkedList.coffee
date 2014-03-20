class Node
  constructor: (@data) ->
    @next = null

class LinkedList
  constructor: () ->
    @head   = null
    @length = 0

  incrementLength: ->
    @length += 1

  decrementLength: ->
    @length -= 1 if @length > 0

  at: (index) ->
    if index >= @length or index < 0
      console.log "Out of bounds"
      return false

    current = @head
    i = 0
    current = current.next while i++ < index

    return current

  get: (index) ->
    node = @at(index)
    return false unless node
    return node.data

  append: (data) ->
    unless data
      console.log("Needs an input")
      return false

    unless @head?
      @head = new Node(data)
      @incrementLength()
      return this

    # we don't have an empty list.
    current = @head
    current = current.next while current.next?
    current.next = new Node(data)

    @incrementLength()

    return this

  prepend: (data) ->
    unless data
      console.log("Needs an input")
      return false

    restOfTheList = @head
    @head = new Node(data)
    @head.next = restOfTheList

    @incrementLength()

    return this

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

    return this

  trim: ->
    if @length == 0
      console.log("List is empty")
      return false

    # handle the list with only one Node
    unless @head.next
      _head = @head
      @head = null
      @decrementLength()
      return _head

    nodeBeforeLast = @at(@length - 2)
    lastNode       = nodeBeforeLast.next

    nodeBeforeLast.next = null
    @decrementLength()

    lastNode

  shift: ->
    if @length == 0
      console.log("List is empty")
      return false

    _head      = @head
    @head      = _head.next
    _head.next = null
    @decrementLength()

    _head

  deleteAt: (index) ->
    if index >= @length or index < 0
      console.log "Out of bounds"
      return false

    return @shift() if index == 0
    return @trim()  if index == @length - 1

    prev    = @at(index - 1)
    current = prev.next
    rest    = current.next

    prev.next = rest

    @decrementLength()

    current

  toArray: ->
    current = @head
    array = []

    while current?
      array.push(current.data)
      current = current.next

    array

  toString: ->
    @toArray().toString()

module?.exports = LinkedList

