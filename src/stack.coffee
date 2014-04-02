LinkedList = require "./linked-list"

class Stack
  constructor: ->
    @list   = new LinkedList

  length: ->
    @list.length

  peek: ->
    @list.get(0)

  push: (data) ->
    @list.prepend(data)
    return this

  pop: ->
    @list.shift()

module?.exports = Stack
