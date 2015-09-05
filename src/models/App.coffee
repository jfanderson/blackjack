# TODO: Refactor this model to use an internal Game Model instead
# of containing the game logic directly.
class window.App extends Backbone.Model
  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'round', round = new Round(@get('deck'))

    @get('round').on 'player_wins', (message) -> 
      console.log(message)
      $('#gameOverModal').openModal({dismissible: false})
    @get('round').on 'tie', (message) -> 
      console.log(message)
      $('#gameOverModal').openModal({dismissible: false})

    return

    # @get('round').on 'dealer_wins', (message) -> 
    #   console.log(message)
    #   $('#gameOverModal').openModal({dismissible: false})
    