Node = require "./single-node"

class Stack
  constructor: ->
    @length = 0
    @head   = null

  incrementLength: ->
    @length += 1

  decrementLength: ->
    @length -= 1 if @length > 0

  push: (data) ->
    unless data
      console.log "Needs an input"
      return false

    restOfTheStack = @head
    @head = new Node(data)
    @head.next = restOfTheStack

    @incrementLength()

    return this

  pop: ->
    if @length is 0
      console.log "Empty stack"
      return false

    rest = @head.next
    toBePopped = @head
    @head = rest

    @decrementLength()

    return toBePopped.data

module?.exports = Stack
