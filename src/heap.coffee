Node = require "./nodes/tree"

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

    compareFn = compareFn || defaultCompareFn
    @compare = (a, b) -> compareFn(a.data, b.data)

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

    return pathArray

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

    return node.data

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

  _bubbleDown: (node) ->
    return @root if node.isLeaf()

    if node.right
      shouldSwap = @compare(node, node.left) < 0 and
                   @compare(node, node.right) < 0

      if shouldSwap
        @_swapWithChild(node)
    else
      Heap.swap(node.left, node)
      @_bubbleDown(node.left)

  _swapWithChild: (parent) ->
    greaterChild = parent.greaterChild(@compare)
    Heap.swap(parent, greaterChild)
    @_bubbleDown(greaterChild)

module.exports = Heap

