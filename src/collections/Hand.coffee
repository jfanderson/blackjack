class window.Hand extends Backbone.Collection
  model: Card

  initialize: (array, @deck, @isDealer) ->

  hit: ->
    @add(@deck.pop())
    @last()


  hasAce: -> @reduce (memo, card) ->
    memo or card.get('value') is 1
  , 0

  minScore: -> @reduce (score, card) ->
    score + if card.get 'revealed' then card.get 'value' else 0
  , 0

  scores: ->
    # The scores are an array of potential scores.
    # Usually, that array contains one element. That is the only score.
    # when there is an ace, it offers you two scores - the original score, and score + 10.
    [@minScore(), @minScore() + 10 * @hasAce()]

  maxLegalScore: ->
    if @scores()[1] > 21
      @scores()[0]
    else
      @scores()[1]

  checkBlackJack: ->
    if @isDealer and @hasAce()
      @at(0).get('value') + @at(1).get('value') == 11
    else
      @scores()[1] == 21

  checkBust: ->
    @minScore() > 21
