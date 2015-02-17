define [
  "jquery",
  "underscore",
  "mustache"
  "backbone",
  "parse",
  "text!templates/404.html"
], ($, _, Mustache, Backbone, Parse, Template) ->

  View = Backbone.View.extend({

    el: $('.content'),

    render: ->

      #Using Underscore we can compile our template with data
      compiledTemplate = Mustache.render( Template , {})
      this.$el.html( compiledTemplate )

      #hide loader
      $('.loader').fadeOut(100)

  })

  #Our module now returns our view
  return View
