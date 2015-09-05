class window.AppView extends Backbone.View

  className: 'app container'

  template: _.template '
    <div class="round-container"></div>
  '

  initialize: ->
    @render()

  render: ->
    @$el.children().detach()
    @$el.html @template()
    @$('.round-container').html new RoundView(model: @model.get('round')).el