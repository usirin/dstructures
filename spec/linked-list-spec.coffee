LinkedList = require '../src/linked-list'

describe "LinkedList", ->
  describe "when it is just initialized", ->
    beforeEach ->
      @ll = new LinkedList
      @llWithData = (new LinkedList)
        .append('first')
        .append('second')
        .append('third')

    it "has zero length", ->
      expect(@ll.length).toEqual 0

    it "has null head", ->
      expect(@ll.head).toBeNull()

    describe "#incrementLength", ->
      it "increments length", ->
        @ll.incrementLength()
        expect(@ll.length).toEqual 1

    describe "#decrementLength", ->
      it "decrements length", ->
        @ll.length = 3; # test purposes
        @ll.decrementLength()
        expect(@ll.length).toEqual 2

      it "doesn't decrement to a negative value", ->
        @ll.decrementLength()
        expect(@ll.length).toEqual 0

    describe "#append", ->
      it "throws an error when there is no input", ->
        expect(=> @ll.append()).toThrow "Illegal input"

      it "assings a new node to head if list is empty", ->
        @ll.append('data')
        expect(@ll.head.data).toBe 'data'

      it "appends data to the end of the list", ->
        @ll.append('first').append('second')
        expect(@ll.length).toBe 2
        expect(@ll.head.next.data).toBe 'second'

      it "increments length by 1 when successful", ->
        length = @ll.length
        @ll.append('data')
        expect(@ll.length).toBe length+1

    describe "#prepend", ->
      it "throws an error when there is no input", ->
        expect(=> @ll.prepend()).toThrow "Illegal input"

      it "assigns a new node to head if list is empty", ->
        @ll.prepend('data')
        expect(@ll.head.data).toBe 'data'

      it "prepends data to the beginning of the list", ->
        @ll.prepend('first').prepend('second')
        expect(@ll.length).toBe 2
        expect(@ll.head.data).toBe 'second'

      it "increments length by 1 when successful", ->
        length = @ll.length
        @ll.prepend('data')
        expect(@ll.length).toBe length+1

    describe "#at", ->
      it "throws an error for negative index", ->
        expect(=> @ll.at(-1)).toThrow "Out of bounds"

      it "throws an error for index equals to its length", ->
        expect(=> @ll.at(@ll.length)).toThrow "Out of bounds"

      it "throws an error for an index greater than length", ->
        expect(=> @ll.at(@ll.length + 2)).toThrow "Out of bounds"

      it "returns the Node object with the index", ->
        first  = @llWithData.at(0)
        second = @llWithData.at(1)
        third  = @llWithData.at(2)
        expect(first.data).toBe  'first'
        expect(second.data).toBe 'second'
        expect(third.data).toBe  'third'

    describe "#get", ->
      it "throws an error for negative index", ->
        expect(-> @ll.get(-1)).toThrow()

      it "throws an error for index equals to its length", ->
        expect(-> @ll.get(@ll.length)).toThrow()

      it "throws an error for an index greater than length", ->
        expect(-> @ll.get(@ll.length + 2)).toThrow()

      it "returns the Node object with the index", ->
        first  = @llWithData.get(0)
        second = @llWithData.get(1)
        third  = @llWithData.get(2)
        expect(first).toBe  'first'
        expect(second).toBe 'second'
        expect(third).toBe  'third'

    describe "#insertAt", ->
      it "throws an error for negative index", ->
        expect(=> @ll.insertAt(-1, 'dumb')).toThrow "Out of bounds"

      it "throws an error for an index greater than length", ->
        result = => @ll.insertAt(@ll.length + 2, 'dumb')
        expect(result).toThrow "Out of bounds"

      it "prepends data if index is zero", ->
        spyOn @ll, 'prepend'
        @ll.insertAt(0, 'data')
        expect(@ll.prepend).toHaveBeenCalled()

      it "appends data if index equals to length", ->
        spyOn @llWithData, 'append'
        index = @llWithData.length
        @llWithData.insertAt(index, 'dumb')
        expect(@llWithData.append).toHaveBeenCalled()

      it "inserts data at given index", ->
        index = Math.floor(@llWithData.length / 2)
        @llWithData.insertAt(index, 'data')
        expect(@llWithData.get(index)).toBe 'data'

      it "increases length by 1 when it is successful", ->
        length = @llWithData.length
        @llWithData.insertAt(1, 'dumb')
        expect(@llWithData.length).toBe length+1

    describe "#trim", ->
      it "throws an error when list is empty", ->
        expect(=> @ll.trim()).toThrow "List is empty"

      it "handles lists that has only one node specially", ->
        node = @ll.append(1).trim()
        expect(node).toBe 1

      it "returns the last node", ->
        node = @llWithData.trim()
        expect(node).toBe 'third'

      it "removes the last node", ->
        node = @llWithData.trim()
        node2 = @llWithData.trim()
        expect(node).toNotEqual node2

      it "decrements length", ->
        length = @llWithData.length
        @llWithData.trim()
        expect(@llWithData.length).toBe length - 1

    describe "#shift", ->
      it "throws an error when list is empty", ->
        expect(=> @ll.shift()).toThrow "List is empty"

      it "returns the first node", ->
        node = @llWithData.shift()
        expect(node).toEqual 'first'

      it "removes the last node", ->
        node = @llWithData.shift()
        node2 = @llWithData.shift()
        expect(node).toNotEqual node2

      it "decrements length", ->
        length = @llWithData.length
        @llWithData.shift()
        expect(@llWithData.length).toBe length - 1

    describe "#deleteAt", ->
      it "throws an error when index is negative", ->
        expect(=> @ll.deleteAt(-1)).toThrow "Out of bounds"

      it "throws an error when index equals to length", ->
        deleteAt = => @llWithData.deleteAt(@llWithData.length)
        expect(deleteAt).toThrow "Out of bounds"

      it "throws an error when index is greater than length", ->
        deleteAt = => @llWithData.deleteAt(@llWithData.length + 1)
        expect(deleteAt).toThrow "Out of bounds"

      it "delegates to shift when index is 0", ->
        spyOn @llWithData, 'shift'
        @llWithData.deleteAt(0)
        expect(@llWithData.shift).toHaveBeenCalled()

      it "delegates to trim when index equals to length - 1", ->
        spyOn @llWithData, 'trim'
        @llWithData.deleteAt(@llWithData.length - 1)
        expect(@llWithData.trim).toHaveBeenCalled()

      it "deletes the node at index and returns it", ->
        expect(@llWithData.deleteAt(1)).toEqual 'second'

      it "decrements the length", ->
        length = @llWithData.length
        @llWithData.deleteAt(1)
        expect(@llWithData.length).toBe length - 1

    describe "#toArray", ->
      it "converts list to array", ->
        expect(@ll.toArray()).toEqual []
        array = [
          'first'
          'second'
          'third'
        ]
        expect(@llWithData.toArray()).toEqual array

    describe "#toString", ->
      it "converts list to string", ->
        expect(@ll.toString()).toEqual ""
        expect(@llWithData.toString()).toEqual "first,second,third"


