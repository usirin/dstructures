Node = require "./doubly-node"

class Queue
  constructor: ->
    @head   = null
    @tail   = null
    @length = 0

  incrementLength: ->
    @length += 1

  decrementLength: ->
    @length -= 1 if @length > 0

  push: (data) ->
    unless data
      console.log "Needs input"
      return false

    # cache it so that we can
    # deal with it later
    restOfTheList = @head

    newNode = new Node(data)
    @head = newNode
    @head.next = restOfTheList

    restOfTheList?.prev = newNode

    # change tail only if the queue is empty
    @tail ?= @head

    @incrementLength()

    return this


module?.exports = Queue
