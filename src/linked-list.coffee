Node = require "./nodes/single"

class LinkedList
  constructor: ->
    @head   = null
    @length = 0

  incrementLength: -> @length += 1
  decrementLength: -> @length -= 1 if @length > 0

  # Returns Node instance at given index
  at: (index) ->
    throw new Error "Out of bounds" unless 0 <= index < @length

    current = @head
    current = current.next for i in [0...index]

    return current

  # Returns the actual data
  # inside the node at given index
  get: (index) ->
    node = @at(index)
    return node.data

  # Appends the data to the
  # end of the list.
  #
  # data - could be any type of object
  #
  # Returns the LinkedList object for chaining.
  append: (data) ->
    throw new Error "Illegal input" unless data

    # tricky part is here
    # if the list is empty we don't
    # have a pointer to anywhere so
    # trying to traverse the list
    # will end up throwing errors.
    # So, this is basically the initiation
    # of the list.
    if @head is null
      @head = new Node(data)
    # since we have a pointer to at least
    # one node, which means it is traversable,
    # go traverse it, find the last node, and
    # stick the new data to the end of it.
    else
      current = @head
      current = current.next while current.next?
      current.next = new Node(data)

    @incrementLength()
    return this

  # Adds the data to the beginning of the list.
  #
  # data - could be any type of object
  #
  # Returns the LinkedList object for chanining.
  prepend: (data) ->
    throw new Error "Illegal input" unless data

    # easier than append, this is where
    # singly linked list is performant.
    # cache head, create new node with given
    # data, and merge them.
    restOfTheList = @head
    @head = new Node(data)
    @head.next = restOfTheList

    @incrementLength()
    return this

  # Inserts a data at given index.
  #
  # index
  # data - could be any object.
  #
  # Returns LinkedList object for chaining.
  insertAt: (index, data) ->
    throw new Error "Out of bounds" unless 0 <= index <= @length

    return @prepend(data) if index == 0
    return @append(data)  if index == @length

    beforeNode      = @at(index - 1)
    restOfTheList   = beforeNode.next
    newNode         = new Node(data)
    beforeNode.next = newNode
    newNode.next    = restOfTheList

    @incrementLength()

    return this

  # Returns the last element's data of the list.
  trim: ->
    throw new Error "List is empty" if @length == 0

    # Another tricky part:
    # there is a special case for
    # a list with only one node.
    # General flow works like, go
    # to the node before last one
    # and cache it and do the operations.
    # But since only one node, there is not
    # a node before the last one because we have
    # only one node.
    if @head.next is null
      last = @head
      @head = null
    # this is the regular trimming operation.
    # go to the node before last one, cache it.
    # clear its next pointer.
    else
      beforeLast      = @at(@length - 2)
      last            = beforeLast.next
      beforeLast.next = null

    @decrementLength()
    return last.data

  # Returns the first element of the list
  shift: ->
    throw new Error "List is empty" if @length == 0

    # Since we have a pointer to the
    # beginning of the list, it is way
    # easier than trimming.
    first      = @head
    @head      = first.next
    first.next = null

    @decrementLength()
    return first.data

  # Deletes a node at given index.
  #
  # index - index of the node to be deleted.
  #
  # Returns the deleted node's data.
  deleteAt: (index) ->
    throw new Error "Out of bounds" unless 0 <= index < @length

    return @shift() if index == 0
    return @trim()  if index == @length - 1

    prev      = @at(index - 1)
    current   = prev.next
    rest      = current.next
    prev.next = rest

    @decrementLength()
    return current.data

  # Returns the array representation of list.
  toArray: ->
    current = @head
    array   = []

    while current?
      array.push current.data
      current = current.next

    return array

  # Returns the string form of Linked List.
  toString: ->
    @toArray().toString()

module?.exports = LinkedList

