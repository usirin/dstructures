Node = require "./nodes/tree"

class BinarySearchTree
  constructor: (opt_dataArray) ->
    @root = null
    @length = 0

    @fromArray opt_dataArray if opt_dataArray

  @fromArray: (array) ->
    bst = new BinarySearchTree
    bst.add item for item in array
    bst

  incrementLength: -> @length += 1
  decrementLength: -> @length -= 1 if @length > 0

  add: (data) ->
    throw new Error "Illegal input" unless data

    newNode = new Node(data)

    if @root == null
      @root = newNode
      @incrementLength()
      return this

    current = @root

    loop
      # if smaller go to left
      # until finding last node
      # then add it to the left of the node
      if data < current.data
        if current.left == null
          current.left = newNode
          @incrementLength()
          break
        else
          current = current.left
      # if greater go to right
      # until finding last node
      # then add it to right of the node
      else if data > current.data
        if current.right == null
          current.right = newNode
          @incrementLength()
          break
        else
          current = current.right
      # if can't find break the loop
      else
        break

    return this

  find: (data) ->
    throw new Error "Illegal input" unless data

    current = @root

    loop
      if data == current.data
        return data
      else if data < current.data
        if current.left
          current = current.left
        else
          return false
      else if data > current.data
        if current.right
          current = current.right
        else
          return false

  walk: (callback) ->
    throw new Error "Illegal argument" unless callback instanceof Function

    walkthrough = (node) ->
      return unless node
      walkthrough(node.left) if node.left
      callback.call this, node
      walkthrough(node.right) if node.right

    walkthrough @root

  toArray: ->
    array = []
    @walk (node) ->
      array.push(node.data)

    array

  toString: ->
    @toArray().toString()

module?.exports = BinarySearchTree
