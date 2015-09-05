# TODO: Refactor this model to use an internal Game Model instead
# of containing the game logic directly.
class window.App extends Backbone.Model
  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'round', round = new Round(@get('deck'))
    
    @listenTo @get('round'), 'player_wins', (message) -> 
      console.log(message)
      # $('#gameOverModal').openModal({dismissible: false})
    @listenTo @get('round'), 'dealer_wins', (message) -> 
      console.log(message)
      # $('#gameOverModal').openModal({dismissible: false})
    @listenTo @get('round'), 'tie', (message) -> 
      console.log(message)
      # $('#gameOverModal').openModal({dismissible: false})
    return    

  start: ->
    @get('round').startRound()