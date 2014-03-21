DoublyLinkedList = require "../src/doubly-linked-list"

describe "DoublyLinkedList", ->
  beforeEach ->
    @d = new DoublyLinkedList

  it "has null head", ->
    expect(@d.head).toBeNull()

  it "has null tail", ->
    expect(@d.tail).toBeNull()

  it "has zero length", ->
    expect(@d.length).toEqual 0

  describe "#incrementLength", ->
    it "increments length", ->
      expect(@d.incrementLength()).toEqual 1

  describe "#decrementLength", ->
    it "decrements length", ->
      @d.length = 3 # test purposes
      @d.decrementLength()
      expect(@d.length).toEqual 2

    it "doesn't decrement to a negative value", ->
      @d.decrementLength()
      expect(@d.length).toEqual 0

  describe "#append", ->
    it "returns false with empty argument", ->
      expect(@d.append()).toEqual false

    it "adds adds a node to empty list", ->
      @d.append('data')
      expect(@d.head.data).toEqual 'data'
      expect(@d.tail.data).toEqual 'data'

    it "increments length", ->
      @d.append('first')
      expect(@d.length).toEqual 1
      @d.append('second')
      expect(@d.length).toEqual 2

    it "adds node to the end", ->
      @d.append('first').append('second')
      expect(@d.head.data).toEqual 'first'
      expect(@d.tail.data).toEqual 'second'

    it "returns itself for chaining", ->
      expect(@d.append('data')).toBe @d

  describe "#prepend", ->
    it "returns false with empty argument", ->
      expect(@d.prepend()).toEqual false

    it "adds a node to empty list", ->
      @d.prepend('data')
      expect(@d.head.data).toEqual 'data'
      expect(@d.tail.data).toEqual 'data'

    it "increments length", ->
      @d.prepend('first')
      expect(@d.length).toEqual 1
      @d.prepend('second')
      expect(@d.length).toEqual 2

    it "adds node to beginning", ->
      @d.prepend('first').prepend('second')
      expect(@d.head.data).toEqual 'second'
      expect(@d.tail.data).toEqual 'first'

  describe "when there is a list with data", ->
    beforeEach ->
      @dD = (new DoublyLinkedList)
        .append('first')
        .append('second')
        .append('third')

    describe "#at", ->
      it "returns false when index is out of bounds", ->
        expect(@dD.at(-1)).toEqual false
        expect(@dD.at(@dD.length)).toEqual false
        expect(@dD.at(@dD.length+1)).toEqual false

      it "returns the node at given index", ->
        expect(@dD.at(0).data).toEqual 'first'
        expect(@dD.at(1).data).toEqual 'second'
        expect(@dD.at(2).data).toEqual 'third'
        expect(@dD.append('fourth').at(3).data).toEqual 'fourth'
        expect(@dD.append('fifth').at(4).data).toEqual 'fifth'

    describe "#get", ->
      it "returns false when index is out of bounds", ->
        expect(@dD.get(-1)).toEqual false
        expect(@dD.get(@dD.length)).toEqual false
        expect(@dD.get(@dD.length+1)).toEqual false

      it "returns the data at given index", ->
        expect(@dD.get(0)).toEqual 'first'
        expect(@dD.get(1)).toEqual 'second'
        expect(@dD.get(2)).toEqual 'third'
        expect(@dD.append('fourth').get(3)).toEqual 'fourth'
        expect(@dD.append('fifth').get(4)).toEqual 'fifth'

    describe "#insertAt", ->
      it "returns false when index is out of bounds", ->
        expect(@dD.insertAt(-1, 'dumb')).toEqual false
        expect(@dD.insertAt(@dD.length+1, 'dumb')).toEqual false

      it "prepends data if index is zero", ->
        spyOn @dD, 'prepend'
        @dD.insertAt(0, 'dumb')
        expect(@dD.prepend).toHaveBeenCalled()

      it "appends data if index equals to length", ->
        spyOn @dD, 'append'
        @dD.insertAt(@dD.length, 'dumb')
        expect(@dD.append).toHaveBeenCalled()

      it "inserts data at given index", ->
        @dD.insertAt 2, 'data'
        expect(@dD.length).toEqual 4
        expect(@dD.get 2).toEqual 'data'

      it "returns itself", ->
        expect(@dD.insertAt(2, 'dumb')).toBe @dD

    describe "#trim", ->
      it "returns false when list is empty", ->
        expect(@d.trim()).toBe false

      it "handles the case where there is only one node", ->
        node = @d.append(1).trim()
        expect(node.data).toBe 1
        expect(@d.head).toBeNull()
        expect(@d.tail).toBeNull()

      it "returns the last node", ->
        node = @dD.trim()
        expect(node.data).toEqual "third"

      it "decrements length", ->
        @dD.trim()
        expect(@dD.length).toEqual 2

    describe "#shift", ->
      it "returns false when list is empty", ->
        expect(@d.shift()).toBe false

      it "handles the case where there is only one node", ->
        node = @d.append(1).shift()
        expect(node.data).toEqual 1
        expect(@d.head).toBeNull()
        expect(@d.tail).toBeNull()

      it "returns the first node", ->
        node = @dD.shift()
        expect(node.data).toEqual "first"

      it "decrements length", ->
        @dD.shift()
        expect(@dD.length).toEqual 2

    describe "#deleteAt", ->
      it "returns false when list is empty", ->
        expect(@d.deleteAt(0)).toBe false

      it "returns false when index is out of bounds", ->
        expect(@dD.deleteAt(-1)).toBe false
        expect(@dD.deleteAt(3)).toBe false
        expect(@dD.deleteAt(4)).toBe false

      it "delegates to trim when index equals index - 1", ->
        spyOn @dD, 'trim'
        @dD.deleteAt(@dD.length - 1)
        expect(@dD.trim).toHaveBeenCalled()

      it "delegates to shift when index is zero", ->
        spyOn @dD, 'shift'
        @dD.deleteAt(0)
        expect(@dD.shift).toHaveBeenCalled()

      it "deletes the node at index and returns it", ->
        node = @dD.at(1)
        expect(@dD.deleteAt(1)).toBe node

      it "decrements length", ->
        @dD.deleteAt(1)
        expect(@dD.length).toEqual 2

    describe "#toArray", ->
      it "converts itself to array", ->
        expect(@d.toArray()).toEqual []
        array = [
          'first'
          'second'
          'third'
        ]
        expect(@dD.toArray()).toEqual array

    describe "#toString", ->
      it "converts itself to string", ->
        expect(@d.toString()).toEqual ""
        expect(@dD.toString()).toEqual "first,second,third"

