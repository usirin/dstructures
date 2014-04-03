TreeNode = require "../../src/nodes/tree"

describe "TreeNode", ->
  describe "#isLeaf", ->
    it "returns true if it doesn't have any child node", ->
      node = new TreeNode 'dumb'
      expect(node.isLeaf()).toEqual true

    it "throws an error if compare is not a function", ->
      node  = new TreeNode(1)
      expect(-> node.greaterChild()).toThrow "It requires a compare function"

    it "returns left child if right is empty", ->
      node  = new TreeNode(1)
      node.left = new TreeNode(2)
      greaterChild = node.greaterChild((a, b) -> a.data - b.data)
      expect(greaterChild).toEqual node.left

    it "returns the greater child", ->
      node  = new TreeNode(1)
      node.left = new TreeNode(2)
      node.right = new TreeNode(3)
      greaterChild = node.greaterChild((a, b) -> a.data - b.data)
      expect(greaterChild).toEqual node.right
