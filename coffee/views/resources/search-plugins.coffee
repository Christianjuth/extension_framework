define [
  "jquery",
  "underscore",
  "mustache",
  "backbone",
  "parse",
  "queryString",
  "highlight",
  "text!templates/resources/search-plugins.html"
], ($, _, Mustache, Backbone, Parse, queryString, hljs, Template) ->


  #define modle and collection
  PluginModle = Parse.Object.extend "Plugin", {}
  PluginCollection = Parse.Collection.extend {}



  #define view
  View = Backbone.View.extend {

    #vars
    query: {
      'search': ''
    }
    el: $('.page')
    searchTimeoutID: null


    initialize: (options)->
      self = this
      _.bindAll(this, 'render')
      self.query = jQuery.extend(self.query, queryString.parse(location.search))
      self.render()


    #RENDER FUNCTIONS
    render: () ->
      self = this
      $el = this.$el
      query = self.query

      compiledTemplate = Mustache.render( $(Template).find('.view').html(), {} )
      self.$el.html( compiledTemplate )

      self.search ->
        self.show()

      $el.find('.search').select()

      if query.search isnt null
        $el.find('.search').val(query.search)


    searchRender: ->
      self = this
      $el = this.$el

      $el.find('.plugins tbody').off()
      $el.find('.plugins tbody').empty()
      self.plugins.each (plug)->
        name =        plug.get('name')
        developer =   plug.get('developer')

        plugTemplate = Mustache.render( $(Template).find('.item').html(), {
          name:       name
          link:       name.toLowerCase()
          developer:  developer
        })
        $this = $(plugTemplate).appendTo($el.find('.plugins tbody'))

        $this.find('.link').click (e)->
          e.preventDefault()
          self.query.search = developer
          self.search()
          self.updateUrl()


    #EVENTS
    events:
      'keyup  .search':      'onType'
      'submit .search-form': 'onSubmit'

    onType: (e)->
      #block spaces from search
      console.log e.which
      if e.which is 32
        e.preventDefault()
        return
      #don't search on arrow keys
      if (e.which <= 48 or e.which >= 90) and e.which isnt 8
        return
      #vars
      self = this
      $el = this.$el
      query = self.query
      query.search = $el.find('.search').val()
      #clear timer
      clearTimeout(self.searchTimeoutID)
      #logic
      self.searchTimeoutID = setTimeout ->
        self.search()
      , 500
      self.updateUrl()


    onSubmit: (e)->
      e.preventDefault()
      self = this
      $el = this.$el
      self.search()


    #FUNCTIONS
    updateUrl: ->
      self = this
      query = self.query
      url = location.pathname+'?'+queryString.stringify(query)
      Backbone.history.navigate  url, {replace: true}


    search: (callback)->
      self = this
      $el = this.$el
      query = self.query

      #dissable duplicate searches
      if query is self.currentQuery
        return
      self.currentQuery = jQuery.extend({}, query)

      this.plugins = new PluginCollection
      #name query
      nameQuery = new Parse.Query(PluginModle)
      nameQuery.contains("search", query.search.toLowerCase())
      #developer query
      developerQuery = new Parse.Query(PluginModle)
      developerQuery.contains("developer", query.search.toLowerCase())
      #main query
      this.plugins.query = Parse.Query.or(nameQuery,developerQuery)
      this.plugins.query.notEqualTo("file", null)
      this.plugins.query.ascending("name")
      this.plugins.fetch {
        success: ->
          self.searchRender()
          callback()
      }



  }



  #Our module now returns our view
  return View;