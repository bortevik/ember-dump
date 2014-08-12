`import Ember from 'ember'`

PostsRoute = Ember.Route.extend
  model: ->
    @store.find('post', page: 3, per_page: 4, cache: false)

`export default PostsRoute`
