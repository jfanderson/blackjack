assert = chai.assert
expect = chai.expect

describe 'hand', ->
  cards = null
  hand = null
  deck = null

  beforeEach ->
    cards = []
    hand = null
    
  describe 'hasAce', ->
    it 'should detect an ace in the Hand', ->
      cards.push new Card
        rank: 1
        suit: 0
      cards.push new Card
        rank: 2
        suit: 1
      hand = new Hand(cards)
      assert.strictEqual hand.hasAce(), true
    it 'should NOT fire when no aces', ->
      cards.push new Card
        rank: 5
        suit: 0
      cards.push new Card
        rank: 2
        suit: 1
      hand = new Hand(cards)
      assert.strictEqual hand.hasAce(), false
    
  describe 'minScore', ->
    it 'should be sum of scores if all cards revealed', ->
      cards.push new Card
        rank: 5
        suit: 0
      cards.push new Card
        rank: 2
        suit: 1
      hand = new Hand(cards)
      assert.strictEqual hand.minScore(), 7

  describe 'checkBlackJack', ->
    it 'should expect ace-ten to be blackjack', ->
      cards.push new Card
        rank: 1
        suit: 0
      cards.push new Card
        rank: 10
        suit: 1
      hand = new Hand(cards)
      assert.strictEqual hand.checkBlackJack(), true
    it 'should NOT expect 7-ten to be blackjack', ->
      cards.push new Card
        rank: 7
        suit: 0
      cards.push new Card
        rank: 10
        suit: 1
      hand = new Hand(cards)
      assert.strictEqual hand.checkBlackJack(), false
    it 'should find blackjack when cards not flipped', ->
      cards.push new Card
        rank: 1
        suit: 0
      cards.push new Card
        rank: 10
        suit: 1
      cards[0].flip()
      hand = new Hand(cards, deck, true)
      assert.strictEqual hand.checkBlackJack(), true

  describe 'checkBust', ->
    it 'should expect sum over 21 with no ace to bust', ->
      cards.push new Card
        rank: 2
        suit: 0
      cards.push new Card
        rank: 10
        suit: 1
      cards.push new Card
        rank: 10
        suit: 2
      hand = new Hand(cards)
      assert.strictEqual hand.checkBust(), true
    it 'should NOT assume aces are always value 11', ->
      cards.push new Card
        rank: 1
        suit: 0
      cards.push new Card
        rank: 1
        suit: 3
      cards.push new Card
        rank: 10
        suit: 1
      hand = new Hand(cards)
      assert.strictEqual hand.checkBust(), false

