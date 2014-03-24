BinarySearchTree = require "../src/binary-search-tree.coffee"

describe "BinarySearchTree", ->
  beforeEach ->
    @bst = new BinarySearchTree

  it "has a null root", ->
    expect(@bst.root).toBeNull()

  it "has zero length", ->
    expect(@bst.length).toEqual 0

  describe "#incrementLenght", ->
    it "increments length", ->
      @bst.incrementLength()
      expect(@bst.length).toEqual 1

  describe "#decrementLength", ->
    it "decrements length", ->
      @bst.length = 3
      @bst.decrementLength()
      expect(@bst.length).toEqual 2

    it "doesn't decrement to a negative value", ->
      @bst.decrementLength()
      expect(@bst.length).toEqual 0

  describe "#add", ->
    it "returns false if data is empty", ->
      expect(@bst.add).toThrow()

    it "assigns data to root if tree is empty", ->
      @bst.add 10
      expect(@bst.root.data).toEqual 10

    it "assigns data to left if it lesser than parent data", ->
      @bst.add(10).add(5).add(7)
      expect(@bst.root.left.right.data).toEqual 7

    it "assigns data to right if it is greater than parent data", ->
      @bst.add(10).add(15).add(13)
      expect(@bst.root.right.left.data).toEqual 13

    it "increases length", ->
      @bst.add(10).add(15).add(13)
      expect(@bst.length).toEqual 3

  describe "When we have a tree with data", ->
    beforeEach ->
      @bstd = (new BinarySearchTree)
        .add(20).add(10).add(18).add(25)

    describe "#find", ->
      it "throws and error if tree is empty", ->
        expect(@bst.find).toThrow()

      it "finds correct data and returns it", ->
        expect(@bstd.find(18)).toEqual 18

      it "returns false if it can't find data", ->
        expect(@bstd.find(7)).toBe false

    describe "#walk", ->
      it "returns false if the argument is not a function", ->
        expect(@bstd.walk).toThrow()

    describe "#toArray", ->
      it "returns the array representation", ->
        array = @bstd.toArray()
        expect(array).toEqual [10, 18, 20, 25]

    describe "#toString", ->
      it "returns the string representation", ->
        string = @bstd.toString()
        expect(string).toEqual "10,18,20,25"

  describe ".fromArray", ->
    it "initializes tree from array", ->
      bst = BinarySearchTree.fromArray [20, 10, 18, 25]
      expect(bst.toArray()).toEqual [10, 18, 20, 25]

