Node = require "./nodes/tree"

defaultCompareFn = (a, b) -> a.data - b.data

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

  insert: (data) ->
    throw new Error "Illegal input" unless data

    @_bubbleUp @_push data

    return this

  remove: ->
    throw new Error "Heap is already empty" if @length is 0

    node = @_pop()
    @_bubbleDown @root

    node.data

  lastNode: ->
    path = Heap.calculateNodePath(@length)
    current = @root
    current = current[direction] for direction in path
    return current

  _push: (data) ->
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

  _pop: ->
    [root, lastNode] = [@root, @lastNode()]
    parentOfLastNode = lastNode.parent

    [lastNode.left, lastNode.right] = [root.left, root.right]
    lastNode.parent = null

    direction = Heap.DIRECTIONS[@length % 2]
    parentOfLastNode[direction] = null

    root.left = root.right = null

    @root = lastNode
    @decrementLength()

    return root

  _bubbleUp: (node) ->
    if node.parent isnt null
      if @compare(node, node.parent) > 0
        Heap.swap(node, node.parent)
        @_bubbleUp(node.parent)
    else
      return

  _bubbleDown: (node) ->
    if node.right
      shouldSwap = @compare(node, node.left) < 0 and
                   @compare(node, node.right) < 0

      if shouldSwap
        @_swapWithChild(node)
    else if node.left and @compare(node, node.left) < 0
      Heap.swap(node.left, node)
      @_bubbleDown(node.left)
    else if node.left is null and node.right is null # it's a leaf
      return @root

  _swapWithChild: (parent) ->
    greaterChild = @_greaterChild(parent)
    Heap.swap(parent, greaterChild)
    @_bubbleDown(greaterChild)

  _greaterChild: (parent) ->
    if @compare(parent.left, parent.right) > 0
      return parent.left
    return parent.right

module.exports = Heap

