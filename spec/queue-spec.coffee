Queue = require "../src/queue"

describe "Queue", ->
  beforeEach ->
    @q = new Queue

  it "has null head", ->
    expect(@q.head).toBeNull()

  it "has null tail", ->
    expect(@q.tail).toBeNull()

  it "has zero length", ->
    expect(@q.length).toEqual 0

  describe "#incrementLength", ->
    it "increments length", ->
      expect(@q.incrementLength()).toEqual 1

  describe "#decrementLength", ->
    it "doesn't decrement length to a negative value", ->
      @q.decrementLength()
      expect(@q.length).toEqual 0

    it "decrements length", ->
      @q.length = 3
      @q.decrementLength()
      expect(@q.length).toEqual 2

  describe "#push", ->
    it "returns false when there is no input", ->
      expect(@q.push()).toBe false

    it "pushes data to top of the queue", ->
      @q.push "data"
      expect(@q.head.data).toBe "data"

    it "returns itself for chainining", ->
      expect(@q.push("data")).toBe @q

    it "has a tail that points to the first inned element", ->
      @q.push('first').push('second').push('third')
      expect(@q.tail.data).toBe 'first'
      expect(@q.head.data).toBe 'third'

    it "has a head and tail that point to the same element when there is only one", ->
      @q.push('first')
      expect(@q.tail.data).toEqual @q.head.data

    it "increments length", ->
      @q.push('data')
      expect(@q.length).toBe 1

