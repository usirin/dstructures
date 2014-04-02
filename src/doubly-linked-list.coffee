Node = require "./nodes/doubly"

class DoublyLinkedList
  constructor: ->
    @head = null
    @tail = null
    @length = 0

  incrementLength: -> @length += 1
  decrementLength: -> @length -= 1 if @length > 0

  # Returns the node instance at given index.
  at: (index) ->
    throw new Error "Out of bounds" unless 0 <= index < @length

    # Start from beginning if the
    # is less than the half of its
    # length, otherwise start from the end.
    if index < @length / 2
      current = @head
      current = current.next for i in [0...index]
    else
      current = @tail
      current = current.prev for i in [@length...index + 1]

    return current

  # Returns the data of the node at given index.
  get: (index) ->
    @at(index).data

  # Helper function to get first
  # node's data in the list.
  first: ->
    @get(0)

  # Helper function to get last
  # node's data in the list.
  last: ->
    @get(@length - 1)

  # Add data to end of list.
  #
  # data - could be any object
  #
  # Returns LinkedList object for chaining.
  append: (data) ->
    throw new Error "List is empty" unless data?

    newNode = new Node(data)

    if @length == 0
      @head = newNode
    else
      last         = @tail
      last.next    = newNode
      newNode.prev = last

    @tail = newNode

    @incrementLength()
    return this

  # Adds data to end of list.
  #
  # data - could be any object
  #
  # Returns LinkedList object for chaining.
  prepend: (data) ->
    throw new Error "List is empty" unless data?

    newNode = new Node(data)

    if @length == 0
      @tail = newNode
    else
      first        = @head
      first.prev   = newNode
      newNode.next = first

    @head = newNode

    @incrementLength()
    return this

  # Adds data to given index.
  #
  # index
  # data - could be any object
  #
  # Returns LinkedList object for chaining
  insertAt: (index, data) ->
    throw new Error "Out of bounds" unless 0 <= index <= @length

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

  # Removes last element and returns it.
  trim: ->
    throw new Error "List is empty" if @length is 0

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
    return last.data

  # Removes first element and returns it.
  shift: ->
    throw new Error "List is empty" if @length is 0

    # Basically same thing as trim,
    # just replace head with tail,
    # last with first.
    # I love doubly linked list.
    # it is fat, but fast!

    first = @head
    @head = first.next

    if @head?
      @head.prev = null
    else
      @tail = @head = null

    @decrementLength()
    return first.data

  deleteAt: (index) ->
    throw new Error "Out of bounds" unless 0 <= index < @length

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
    return toBeDeleted.data

  # Array representation of the list.
  toArray: ->
    current = @head
    array = []

    while current?
      array.push current.data
      current = current.next

    return array

  # String representation of the list.
  toString: ->
    @toArray().toString()

module?.exports = DoublyLinkedList
