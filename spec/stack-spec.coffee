Stack = require "../src/stack"

describe "Stack", ->
  beforeEach ->
    @stack = new Stack

  describe "#constructor", ->
    it "has zero length", ->
      expect(@stack.length).toEqual 0

    it "has null head", ->
      expect(@stack.head).toBeNull()

  describe "#incrementLength", ->
    it "increments length", ->
      @stack.incrementLength()
      expect(@stack.length).toEqual 1

  describe "#decrementLength", ->
    it "decrements length", ->
      @stack.length = 3 # test purposes
      @stack.decrementLength()
      expect(@stack.length).toEqual 2

    it "doesn't decrement to a negative value", ->
      @stack.decrementLength()
      expect(@stack.length).toEqual 0

  describe "#push", ->
    it "returns false when there is no input", ->
      expect(@stack.push()).toBe false

    it "pushes data to the top of the stack", ->
      @stack.push('data')
      expect(@stack.head.data).toBe 'data'

    it "returns the object for chaining purposes", ->
      expect(@stack.push('data')).toBe @stack

    it "increments length by one", ->
      length = @stack.length
      @stack.push('data')
      expect(@stack.length).toBe length + 1

  describe "#pop", ->
    beforeEach ->
      @stackWithData = (new Stack)
        .push "first"
        .push "second"
        .push "third"

    it "returns false when the stack is empty", ->
      expect(@stack.pop()).toBe false

    it "pops the data out from the stack", ->
      expect(@stackWithData.pop()).toBe "third"
      expect(@stack.push("dummy").pop()).toBe "dummy"

    it "removes the node from the stack", ->
      @stackWithData.pop()
      expect(@stackWithData.head.data).toNotEqual "third"

    it "decrements the length", ->
      @stackWithData.pop()
      expect(@stackWithData.length).toBe 2

