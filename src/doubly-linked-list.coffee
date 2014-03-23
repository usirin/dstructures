Node = require "./doubly-node"

class DoublyLinkedList
  constructor: ->
    @head = null
    @tail = null
    @length = 0

  incrementLength: -> @length += 1
  decrementLength: -> @length -= 1 if @length > 0

  at: (index) ->
    return false unless (0 <= index < @length)

    if index < (@length / 2)
      current = @head
      current = current.next for i in [0...index]
    else
      current = @tail
      current = current.prev for i in [@length...index + 1]

    return current

  get: (index) ->
    node = @at(index)
    return false unless node
    node.data

  first: ->
    @get(0)

  last: ->
    @tail.data

  append: (data) ->
    return false unless data?

    newNode = new Node(data)

    if @length == 0
      @head = newNode
    else
      lastNode = @tail
      lastNode.next = newNode
      newNode.prev = lastNode

    @tail = newNode
    @incrementLength()

    return this

  prepend: (data) ->
    return false unless data?

    newNode = new Node(data)

    if @length == 0
      @tail = newNode
    else
      [firstNode, firstNode.prev, newNode.next] = [@head, newNode, firstNode]

    @head = newNode
    @incrementLength()

    return this

  insertAt: (index, data) ->
    return false unless 0 <= index <= @length

    return @prepend(data) if index is 0
    return @append(data)  if index is @length

    # get right bound
    rightBound = @at(index)

    # get left bound
    leftBound = rightBound.prev

    # create new Node
    newNode = new Node(data)

    # assign newNode's pointers
    [newNode.prev, newNode.next] = [leftBound, rightBound]

    # assign bounds' pointers to newNode
    leftBound.next = rightBound.prev = newNode

    @incrementLength()

    return this

  trim: ->
    return false if @length is 0

    # cache tail
    last = @tail

    # move tail
    @tail = last.prev

    # if tail is not null
    # do regular thing
    # make the one before last
    # the last.
    if @tail?
      @tail.next = null
    # else it means that it only had
    # 1 element so make it empty.
    else
      @head = @tail = null

    @decrementLength()

    return last

  shift: ->
    return false if @length is 0

    first = @head
    @head = first.next

    if @head?
      @head.prev = null
    else
      @tail = @head = null

    @decrementLength()

    return first

  deleteAt: (index) ->
    return false if @length is 0
    return false unless 0 <= index < @length

    return @shift() if index is 0
    return @trim()  if index is @length - 1

    # start caching things
    # so that we won't lose them
    toBeDeleted = @at(index)
    leftBound   = toBeDeleted.prev
    rightBound  = toBeDeleted.next

    # remove node from list
    leftBound.next = rightBound
    rightBound.prev = leftBound
    toBeDeleted.next = toBeDeleted.prev = null

    @decrementLength()

    return toBeDeleted

  toArray: ->
    current = @head
    array = []

    while current?
      array.push current.data
      current = current.next

    array

  toString: ->
    @toArray().toString()

module?.exports = DoublyLinkedList
