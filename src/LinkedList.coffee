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


module?.exports = LinkedList