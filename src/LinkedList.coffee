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

module?.exports = LinkedList