# TODO: Refactor this model to use an internal Game Model instead
# of containing the game logic directly.
class window.App extends Backbone.Model
  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'game', game = new Game(@get('deck'))

    @listenTo @get('game'), 'player_wins', (message) -> 
      console.log(message)
    @listenTo @get('game'), 'dealer_wins', (message) -> 
      console.log(message)
    @listenTo @get('game'), 'tie', (message) -> 
      console.log(message)

  start: ->
    @get('game').startNewRound()
   