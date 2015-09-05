class window.RoundView extends Backbone.View
  
  className: 'valign-wrapper round row'

  template: _.template '
    <div class="col s4 valign">
      <div class="section center-align">
        <button class="hit-button waves-effect waves-light btn">Hit</button>
        <button class="stand-button waves-effect waves-light btn">Stand</button>
      </div>
      <div class="divider"></div>
      <div class="section bettinggoeshere"></div>
    </div>
    <div class="col s8">
      <div class="player-hand-container section"></div>
      <div class="divider"></div>
      <div class="dealer-hand-container section"></div>
    </div>
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

