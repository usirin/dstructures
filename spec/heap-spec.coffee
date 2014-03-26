Heap = require "../src/heap"

describe "Heap", ->
  beforeEach ->
    @heap = new Heap

  describe "constuctor", ->
    it "has zero length", ->
      expect(@heap.length).toEqual 0

    it "has null root", ->
      expect(@heap.root).toBeNull()

    it "has a null pointer to the last element", ->
      expect(@heap.tail).toBeNull()

    it "takes a custom function to compare elements", ->
      fn = (a, b) -> b - a
      heapWithCustomCompare = new Heap(fn)
      expect(heapWithCustomCompare.compare).toBe fn

  describe "#calculateNodePath", ->
    it "throws an error if input is illegal", ->
      expect(-> Heap.calculateNodePath()).toThrow()
      expect(-> Heap.calculateNodePath('string')).toThrow()

    it "calculates the path for node with given index", ->
      array = ["left", "left", "left"]
      expect(Heap.calculateNodePath(8)).toEqual array
      array = ["right", "left"]
      expect(Heap.calculateNodePath(6)).toEqual array
      array = ["right"]
      expect(Heap.calculateNodePath(3)).toEqual array

  describe "#incrementLength", ->
    it "increments length", ->
      @heap.incrementLength()
      expect(@heap.length).toEqual 1

  describe "#decrementLength", ->
    it "decrements length", ->
      @heap.length = 3
      @heap.decrementLength()
      expect(@heap.length).toEqual 2

    it "doesn't decrement to a negative value", ->
      @heap.decrementLength()
      expect(@heap.length).toEqual 0

  describe "#push", ->
    it "adds element to root if it is empty", ->
      @heap.push("data")
      expect(@heap.root.data).toEqual "data"

    it "adds the node to correct place", ->
      @heap.push("first")
      @heap.push("second")
      expect(@heap.root.left.data).toEqual "second"

    it "sets new node's parent", ->
      @heap.push("first")
      node = @heap.push("second")
      expect(node.parent).toEqual @heap.root

  describe ".swap", ->
    it "swaps the data of 2 different nodes", ->
      @heap.push("first")
      @heap.push("second")
      Heap.swap(@heap.root, @heap.root.left)
      expect(@heap.root.data).toEqual "second"
      expect(@heap.root.left.data).toEqual "first"

  describe "#bubbleUp", ->
    it "corrects the order of heap", ->
      @heap.push(8)
      node = @heap.push(10)
      @heap.bubbleUp(node)
      expect(@heap.root.data).toEqual 10

    it "doesn't change heap if it is already correct", ->
      @heap.push(8)
      node = @heap.push(7)
      @heap.bubbleUp(node)
      expect(@heap.root.data).toEqual 8

  describe "#insert", ->
    it "throws error when input is invalid", ->
      expect(=> @heap.insert()).toThrow()

    it "inserts the data and sorts it", ->
      @heap.insert(20).insert(30).insert(10)
      expect(@heap.root.data).toEqual 30
      expect(@heap.root.left.data).toEqual 20
      expect(@heap.root.right.data).toEqual 10



