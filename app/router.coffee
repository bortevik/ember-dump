`import Ember from 'ember'`

Router = Ember.Router.extend
  location: EmberDumpENV.locationType

Router.map ->
  @route 'articles'
  @route 'posts'

`export default Router`
