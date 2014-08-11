`import EmberData from 'ember-data'`
`import QueryLogic from '../logics/query'`

CachableQuery =
  name: 'cachableQuery'
  initialize: ->
    EmberData.Store.reopen
      findQuery: QueryLogic.cachableFindQuery()

`export default CachableQuery`
