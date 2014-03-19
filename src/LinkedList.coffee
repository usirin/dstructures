class Node
  constructor: (@data) ->

class LinkedList
  constructor: () ->
    @head   = null
    @length = 0

  append: (data) ->
    unless data
      console.log("Needs an input")
      return false

    unless @head?
      @head = new Node(data)
      @length += 1
      return @

    # we don't have an empty list.
    current = @head
    current = current.next while current.next?
    current.next = new Node(data)
    @length += 1

    return @

  prepend: (data) ->
    unless data
      console.log("Needs an input")
      return false

    restOfTheList = @head
    @head = new Node(data)
    @head.next = restOfTheList
    @length += 1
    return @

  at: (index) ->
    if index > @length or index < 0
      console.log "Out of bounds"
      return false

    current = @head
    i = 0
    current = current.next while i++ < index

    # TODO: decide to return whether the node itself
    # or the `data` of the node
    return current

   get: (index) ->
     @at(index).data

module?.exports = LinkedList
