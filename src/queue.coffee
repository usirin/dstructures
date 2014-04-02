DoublyLinkedList = require "./doubly-linked-list"

class Queue
  constructor: ->
    @list = new DoublyLinkedList

  length: ->
    @list.length

  peek: ->
    @list.last()

  push: (data) ->
    return false unless data

    @list.prepend(data)

    return this

  pop: ->
    return false unless @length() > 0

    @list.trim()


module?.exports = Queue
