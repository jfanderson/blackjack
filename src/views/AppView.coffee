class window.AppView extends Backbone.View

  className: 'app container'

  template: _.template '
    <div class="round-container"></div>
    <div class="modal-trigger" href="#gameOverModal"></div>
    <div id="gameOverModal" class="modal">
      <div class="modal-content">
        <h4>Modal Header</h4>
        <p>A bunch of text</p>
      </div>
      <div class="modal-footer">
        <a href="#!" class=" modal-action modal-close waves-effect waves-green btn-flat">Play Again</a>
      </div>
    </div>
  '

  initialize: ->
    @render()
    $('.modal-trigger').leanModal
      dismissible: true
    @model.get('round').on 'dealer_wins', (message) -> 
      console.log(message)
      $('#gameOverModal').openModal({dismissible: false})
    
    

  render: ->
    @$el.children().detach()
    @$el.html @template
    @$('.round-container').html new RoundView(model: @model.get('round')).el



