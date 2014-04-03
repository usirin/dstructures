class TreeNode
  constructor: (@data) ->
    @parent = null
    @right  = null
    @left   = null

  isLeaf: ->
    return @left == null && @right == null

  greaterChild: (compareFn) ->
    if typeof compareFn isnt "function"
      throw new Error "It requires a compare function"

    return @left unless @right?
    return if compareFn(@left, @right) > 0 then @left else @right

module?.exports = TreeNode
