class window.AppView extends Backbone.View

  className: 'app container'

  template: _.template '
    <div class="round-container"></div>
    <div class="modal-trigger" href="#gameOverModal"></div>
    <div id="gameOverModal" class="modal">
      <div class="modal-content">
        <h4>Round Over</h4>
        <p><%= message %></p>
      </div>
      <div class="modal-footer">
        <a href="#!" class=" modal-action modal-close waves-effect waves-green btn-flat">Play Again</a>
      </div>
    </div>
  '

  defaults: {
    message: 'No message'
  }

  initialize: ->
    @render()
    @listenTo @model.get('round'), 'player_wins', (message) -> 
      @message = message
      @render()  
      $('#gameOverModal').openModal({dismissible: false})
    @listenTo @model.get('round'), 'dealer_wins', (message) -> 
      @message = message  
      @render()
      $('#gameOverModal').openModal({dismissible: false})
    @listenTo @model.get('round'), 'tie', (message) -> 
      @message = message  
      @render()
      $('#gameOverModal').openModal({dismissible: false})
    

  render: ->
    @$el.children().detach()
    @$el.html @template {'message': @message}
    @$('.round-container').html new RoundView(model: @model.get('round')).el



