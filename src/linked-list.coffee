Node = require "./single-node"

class LinkedList
  constructor: () ->
    @head   = null
    @length = 0

  incrementLength: ->
    @length += 1

  decrementLength: ->
    @length -= 1 if @length > 0

  at: (index) ->
    return false unless 0 <= index < @length

    current = @head
    i = 0
    current = current.next while i++ < index

    return current

  get: (index) ->
    node = @at(index)
    return false unless node
    return node.data

  append: (data) ->
    return false unless data

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
    return false unless data

    restOfTheList = @head
    @head = new Node(data)
    @head.next = restOfTheList

    @incrementLength()

    return this

  insertAt: (index, data) ->
    return false unless 0 <= index <= @length

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
    return false if @length == 0

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
    return false if @length == 0

    _head      = @head
    @head      = _head.next
    _head.next = null
    @decrementLength()

    _head

  deleteAt: (index) ->
    return false unless 0 <= index < @length

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

