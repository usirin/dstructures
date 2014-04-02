Heap = require "../src/heap"

describe "Heap", ->
  beforeEach ->
    @heap = new Heap
    @heapWithData = (new Heap).insert(10).insert(30).insert(20)

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

  describe "#_push", ->
    it "adds element to root if it is empty", ->
      @heap._push("data")
      expect(@heap.root.data).toEqual "data"

    it "adds the node to correct place", ->
      @heap._push("first")
      @heap._push("second")
      expect(@heap.root.left.data).toEqual "second"

    it "sets new node's parent", ->
      @heap._push("first")
      node = @heap._push("second")
      expect(node.parent).toEqual @heap.root

  describe ".swap", ->
    it "swaps the data of 2 different nodes", ->
      @heap._push("first")
      @heap._push("second")
      Heap.swap(@heap.root, @heap.root.left)
      expect(@heap.root.data).toEqual "second"
      expect(@heap.root.left.data).toEqual "first"

  describe "#_bubbleUp", ->
    it "corrects the order of heap", ->
      @heap._push(8)
      node = @heap._push(10)
      @heap._bubbleUp(node)
      expect(@heap.root.data).toEqual 10

    it "doesn't change heap if it is already correct", ->
      @heap._push(8)
      node = @heap._push(7)
      @heap._bubbleUp(node)
      expect(@heap.root.data).toEqual 8

  describe "#insert", ->
    it "throws error when input is invalid", ->
      expect(=> @heap.insert()).toThrow()

    it "inserts the data and sorts it", ->
      @heap.insert(20).insert(30).insert(10)
      expect(@heap.root.data).toEqual 30
      expect(@heap.root.left.data).toEqual 20
      expect(@heap.root.right.data).toEqual 10

  describe "#lastNode", ->
    it "returns the last node", ->
      expect(@heapWithData.lastNode().data).toEqual 20

  describe "#_pop", ->
    it "returns the root element", ->
      expect(@heapWithData._pop().data).toEqual 30

    it "moves last node to root", ->
      @heapWithData._pop()
      @heapWithData._pop()
      expect(@heapWithData.root.data).toEqual 10

    it "decrements length", ->
      @heapWithData._pop()
      expect(@heapWithData.length).toEqual 2

  describe "#_bubbleDown", ->
    it "swaps parrent node with one of its children if necessary", ->
      @heap._push(10)
      @heap._push(30)
      @heap._push(20)
      @heap._push(40)
      @heap._bubbleDown(@heap.root)
      expect(@heap.root.data).toEqual 30
      expect(@heap.root.left.data).toEqual 40

  describe "_swapWithChild", ->
    it "swaps with correct child", ->
      @heap._push(10)
      @heap._push(30)
      @heap._push(20)
      @heap._push(40)
      @heap._swapWithChild(@heap.root)
      expect(@heap.root.data).toEqual 30

  describe "_greaterChild", ->
    it "returns greater child", ->
      gC = @heapWithData._greaterChild(@heapWithData.root)
      expect(gC.data).toEqual 20

  describe "#remove", ->
    it "throws an error if heap is empty", ->
      expect(=> @heap.remove()).toThrow("Heap is already empty")

    it "removes the root element", ->
      @heapWithData.remove()
      expect(@heapWithData.root.data).not.toEqual 30

    it "returns the root element", ->
      expect(@heapWithData.remove()).toEqual 30

    it "sorts data accordingly", ->
      @heapWithData.insert(5)
      @heapWithData.remove()
      expect(@heapWithData.root.data).toEqual 20
      expect(@heapWithData.root.right.data).toEqual 5

