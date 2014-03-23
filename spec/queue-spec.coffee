Queue = require "../src/queue"

describe "Queue", ->
  beforeEach ->
    @q = new Queue

  describe "#push", ->
    it "returns false when there is no input", ->
      expect(@q.push()).toBe false

    it "pushes data to top of the queue", ->
      @q.push "data"
      expect(@q.list.first()).toBe "data"

    it "returns itself for chainining", ->
      expect(@q.push("data")).toBe @q

    it "has a tail that points to the first inned element", ->
      @q.push('first').push('second').push('third')
      expect(@q.list.last()).toBe 'first'
      expect(@q.list.first()).toBe 'third'

    it "has a head == tail", ->
      @q.push('first')
      expect(@q.list.first()).toEqual @q.list.last()

    it "increments length", ->
      @q.push('data')
      expect(@q.length()).toBe 1

  describe "#peek", ->
    it "returns the first element without removing it", ->
      @q.push('first')
      expect(@q.peek()).toEqual 'first'
      @q.push('second')
      expect(@q.peek()).toEqual 'first'

  describe "#pop", ->
    beforeEach ->
      @qD = (new Queue)
        .push('first')
        .push('second')
        .push('third')

    it "returns false when it is empty", ->
      expect(@q.pop()).toBe false

    it "pops from tail", ->
      node = @qD.pop()
      expect(node).toEqual 'first'

    it "decrements the length", ->
      @qD.pop()
      expect(@qD.length()).toEqual 2

