LinkedList = require "./linked-list"

class Stack
  constructor: ->
    @list   = new LinkedList

  length: ->
    @list.length

  peek: ->
    @list.get(0)

  push: (data) ->
    unless data
      console.log "Needs an input"
      return false

    @list.prepend(data)

    return this

  pop: ->
    if @length() is 0
      console.log "Empty stack"
      return false

    @list.shift().data

module?.exports = Stack
