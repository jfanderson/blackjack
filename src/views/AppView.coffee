class window.AppView extends Backbone.View

  className: 'app container'

  template: _.template '
    <div class="game-container"></div>
  '

  initialize: ->
    @render()
    


  render: ->
    @$el.children().detach()
    @$el.html @template 
    @$('.game-container').html new GameView(model: @model.get('game')).el



