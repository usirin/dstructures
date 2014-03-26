Node = require "./tree-node"

defaultCompareFn = (a, b) -> a - b

class Heap
  @PARENT: "parent"
  @DIRECTIONS = [
    "left"
    "right"
  ]

  constructor: (compareFn) ->
    @root = null
    @tail = null
    @length = 0

    # we are taking a custom compare function
    # because heap can be used for things
    # other than numbers or strings
    @compare = if compareFn then compareFn else defaultCompareFn

  @calculateNodePath: (index) ->
    throw new Error "Illegal input" unless index % 1 is 0
    pathArray = []

    # will start from the given index and will
    # divide index by 2 and get the integer value
    # of it so that we can have the index of parent
    # of the node at given index. The modulo operation
    # will tell us that it is either at the left or
    # at the right of the parent node.
    until index is 1
      pathArray.unshift @DIRECTIONS[index % 2]

      # used Math.floor because `//` gave compile error
      index = Math.floor(index / 2)

    pathArray

  @swap: (first, second) ->
    [first.data, second.data] = [second.data, first.data]

  incrementLength: -> @length += 1
  decrementLength: -> @length -= 1 if @length > 0

  push: (data) ->
    newNode = new Node(data)

    # check if the heap is empty
    # if so stick the new node to the root
    # and return the heap itself.
    if @length is 0
      @root = newNode
    else
      path = Heap.calculateNodePath(@length + 1)

      # we are removing the last element from
      # the path so that we will iterate to newNode's
      # parent, and then the last path will tell us
      # we will either put new node to left or right.
      # Don't forget that Array#pop mutates the original
      # array, which is exactly we want here.
      lastDirection = path.pop()

      current = @root

      # go to parent node of the recently
      # created newNode.
      current = current[direction] for direction in path

      current[lastDirection] = newNode
      newNode.parent = current

    @incrementLength()

    return newNode

  bubbleUp: (node) ->
    if node.parent isnt null
      if @compare(node.data, node.parent.data) > 0
        Heap.swap(node, node.parent)
        @bubbleUp(node.parent)
    else
      return

  insert: (data) ->
    throw new Error "Illegal input" unless data

    @bubbleUp @push data

    return this

module.exports = Heap

