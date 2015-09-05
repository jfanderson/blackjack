class window.AppView extends Backbone.View

  className: 'app container'

  template: _.template '
    <button id="startgame">Start Round!</button>
    <div class="game-container"></div>
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
      @model.start()

  initialize: ->
    @render()
    @listenTo @model.get('game'), 'player_wins', (message) -> 
      @message = message
      @render()
      $('#gameOverModal').openModal({dismissible: false})
    @listenTo @model.get('game'), 'dealer_wins', (message) -> 
      @message = message  
      @render()
      $('#gameOverModal').openModal({dismissible: false})
    @listenTo @model.get('game'), 'tie', (message) -> 
      @message = message  
      @render()
      $('#gameOverModal').openModal({dismissible: false})
    @listenTo @model.get('game'), 'continue', @render


  render: ->
    @$el.children().detach()
    @$el.html @template {'message': @message}
    @$('.game-container').html new GameView(model: @model.get('game')).el



