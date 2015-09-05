class window.Round extends Backbone.Model
  initialize: (@deck) ->
    @set 'playerHand', @deck.dealPlayer()
    @set 'dealerHand', @deck.dealDealer()

  playerHits: ->
    @get('playerHand').hit()
    if @get('playerHand').checkBust()
      @endGame 'dealer_wins', 'You Bust! Dealer Wins!'

  playerStands: ->
    @dealerPlays()

  dealerPlays: ->
    # flip first dealer card
    @get('dealerHand').at(0).flip()

    # if score under 17, dealer must keep hitting
    while(true)
      if @get('dealerHand').maxLegalScore() < 17
        @get('dealerHand').hit()
        if @get('dealerHand').checkBust()
          @endGame 'player_wins', 'Dealer Busts! You Win!'
          break
      else
        @compareScores()
        break

  compareScores: ->
    if @get('playerHand').maxLegalScore() > @get('dealerHand').maxLegalScore()
      @endGame 'player_wins', "Player's #{@get('playerHand').maxLegalScore()} beats Dealer's #{@get('dealerHand').maxLegalScore()}. You Win!"
    else if @get('playerHand').maxLegalScore() == @get('dealerHand').maxLegalScore()
      @endGame 'tie', "#{@get('playerHand').maxLegalScore()} and #{@get('dealerHand').maxLegalScore()}. It's a Tie!"
    else if @get('playerHand').maxLegalScore() < @get('dealerHand').maxLegalScore()
      @endGame 'dealer_wins', "Dealer's #{@get('dealerHand').maxLegalScore()} beats Player's #{@get('playerHand').maxLegalScore()}. Dealer Wins!"

  startRound: ->
    if @get('playerHand').checkBlackJack() and @get('dealerHand').checkBlackJack()
      @get('dealerHand').at(0).flip()
      @endGame 'tie', 'Tie! Twin Blackjacks!' 
    else if @get('playerHand').checkBlackJack()
      @endGame 'player_wins', 'Player BlackJack! You Win!'
    else if @get('dealerHand').checkBlackJack()
      @get('dealerHand').at(0).flip()
      @endGame 'dealer_wins', 'Dealer Blackjack! Dealer Wins!'

  endGame: (eventName, gameOverMessage) ->
    # might want to pass more complicated object with trigger later (e.g. player/dealer earnings multiplier)
    @trigger eventName, gameOverMessage
