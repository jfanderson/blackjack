class window.RoundView extends Backbone.View
  # tagName: 'div'
  # className: 'round'

  template: _.template '
    <button class="hit-button">Hit</button> <button class="stand-button">Stand</button>
    <div class="player-hand-container"></div>
    <div class="dealer-hand-container"></div>
  '

  events:
    'click .hit-button': -> 
      @model.playerHits()

    'click .stand-button': -> 
      @model.playerStands()

  initialize: ->
    @render()

  render: ->
    @$el.children().detach()
    @$el.html @template()
    @$('.player-hand-container').html new HandView(collection: @model.get('playerHand')).el
    @$('.dealer-hand-container').html new HandView(collection: @model.get('dealerHand')).el
