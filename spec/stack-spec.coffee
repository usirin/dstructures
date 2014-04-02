Stack = require "../src/stack"

describe "Stack", ->
  beforeEach ->
    @stack = new Stack

  describe "#constructor", ->
    it "has zero length", ->
      expect(@stack.length()).toEqual 0

  describe "#peek", ->
    it "throws an error when empty", ->
      expect(-> @stack.peek()).toThrow()

    it "returns the next value without removing it", ->
      spyOn(@stack.list, 'get').andReturn 'data'
      expect(@stack.peek()).toEqual 'data'

  describe "#push", ->
    it "throws an error when there is no input", ->
      expect(=> @stack.push()).toThrow('Illegal input')

    it "pushes data to the top of the stack", ->
      @stack.push('data')
      expect(@stack.peek()).toBe 'data'

    it "returns the object for chaining purposes", ->
      expect(@stack.push('data')).toBe @stack

    xit "increments length by one", ->
      length = @stack.length()
      @stack.push('data')
      expect(@stack.length()).toBe length + 1

  describe "#pop", ->
    beforeEach ->
      @stackWithData = (new Stack)
        .push("first")
        .push("second")
        .push("third")

    it "throws an error when the stack is empty", ->
      expect(=> @stack.pop()).toThrow('List is empty')

    it "pops the data out from the stack", ->
      expect(@stackWithData.pop()).toBe "third"
      expect(@stack.push("dummy").pop()).toBe "dummy"

    it "removes the node from the stack", ->
      @stackWithData.pop()
      expect(@stackWithData.peek()).toNotEqual "third"

    xit "decrements the length", ->
      @stackWithData.pop()
      expect(@stackWithData.length()).toBe 2

