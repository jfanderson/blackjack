class window.GameView extends Backbone.View
  
  className: 'valign-wrapper round row'

  template: _.template '
    <div class="col s3 valign">
      <div class="section center-align">
        <button id="betfive" class="betbuttons waves-effect waves-light btn">Bet 5</button>
        <button id="betten" class="betbuttons waves-effect waves-light btn">Bet 10</button>
        <button id="bettwentyfive" class="betbuttons waves-effect waves-light btn">Bet 25</button>
        <button id="betfifty" class="betbuttons waves-effect waves-light btn">Bet 50</button>
      </div>
      <div class="section center-align">
        <button id="startgame" class="waves-effect waves-light btn">Start Round!</button>
      </div>
      <div class="divider"></div>
      <div class="section center-align">
        <button class="playbuttons hit-button waves-effect waves-light btn">Hit</button>
        <button class="playbuttons stand-button waves-effect waves-light btn">Stand</button>
      </div>
      <div class="divider"></div>
      <div class="section bettinggoeshere center-align golden-base golden">
        <h3>Current Bet</h3>
        <h5><%= bet %></h5>
      </div>
    </div>
    <div class="col s7">
      <div class="player-hand-container section"></div>
      <div class="dealer-hand-container section"></div>
    </div>
    <div class="col s2 center-align">
      <div class="playerchips section golden-base golden">
        <h3>Player Chips</h3>
        <h5><%= pchips %></h5>
      </div>
      <div class="dealerchips section golden-base golden">
        <h3>Dealer Chips</h3>
        <h5><%= dchips %></h5>
      </div>
    </div>  
    <div id="gameOverModal" class="modal">
      <div class="modal-content">
        <h4>Round Over</h4>
        <p><%= message %></p>
      </div>
      <div class="modal-footer">
        <a href="#!" class="modal-action modal-close waves-effect waves-green btn-flat">Okay!</a>
      </div>
    </div>
  '

  events:
    'click #startgame': ->
      @model.set 'playerChips', @model.get('playerChips') - @model.get('bet')
      @model.startNewRound()
      @$el.find(".playbuttons").prop('disabled', false)
      @$el.find(".betbuttons").prop('disabled', true)
            

    'click .hit-button': -> 
      @model.playerHits()

    'click .stand-button': ->
      @model.playerStands()

    'click #betfive': ->
      @model.set 'bet', 5
    'click #betten': ->
      @model.set 'bet', 10
    'click #bettwentyfive': ->
      @model.set 'bet', 25
    'click #betfifty': ->
      @model.set 'bet', 50

  initialize: ->
    @render()
    @$el.find(".playbuttons").prop('disabled', true)
    @$el.find(".betbuttons").prop('disabled', false)
    
    @listenTo @model, 'player_wins', (message) -> 
      @message = message
      @render()
      @$el.find(".playbuttons").prop('disabled', true)
      @$el.find(".betbuttons").prop('disabled', false)
      $('#gameOverModal').openModal({dismissible: false})
    @listenTo @model, 'dealer_wins', (message) -> 
      @message = message  
      @render()
      @$el.find(".playbuttons").prop('disabled', true)
      @$el.find(".betbuttons").prop('disabled', false)
      $('#gameOverModal').openModal({dismissible: false})
    @listenTo @model, 'tie', (message) -> 
      @message = message  
      @render()
      @$el.find(".playbuttons").prop('disabled', true)
      @$el.find(".betbuttons").prop('disabled', false)
      $('#gameOverModal').openModal({dismissible: false})
    @listenTo @model, 'continue', @render
    # @listenTo @model, 'change', @render

  render: ->
    @$el.children().detach()
    @$el.html @template {
      'message': @message
      'pchips': @model.get('playerChips')
      'dchips': @model.get('dealerChips')
      'bet': @model.get('bet')
    }
    @$('.player-hand-container').html new HandView(collection: @model.get('playerHand')).el
    @$('.dealer-hand-container').html new HandView(collection: @model.get('dealerHand')).el

