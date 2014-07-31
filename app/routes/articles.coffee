`import Ember from 'ember'`

ArticlesRoute = Ember.Route.extend
  model: ->
    @store.find('article', page: 5, per_page: 3)

`export default ArticlesRoute`
