`import Ember from 'ember'`

QueryLogic = Ember.Object.extend().reopenClass

  get: (key)->
    Ember.get @, key

  set: (key, value)->
    Ember.set @, key, value

  cachableFindQuery: ->
    self = @
    (type, query)->
      if self._isNotCachable(query)
        delete query['cache']
        return @_super(type, query)

      if self._isQueryRequested(type, query)
        self._getCached(type, query)
      else
        @_super(type, query).then (collection) ->
          self._setCached(type, query, collection)
          collection

  _isNotCachable: (query)->
    if query['cache'] == false || query['cache'] == 'false'
      true
    else
      false

  _isQueryRequested: (type, query)->
    return false unless @get('queryCache')
    cachedQueries = @get('queryCache').get(type)
    return false unless cachedQueries
    cachedQueries.any (cachedQuery)=>
      @_deepEquals(query, cachedQuery.query)

  _deepEquals: (o1, o2)->
     o1.sort() if Ember.isArray(o1)
     o2.sort() if Ember.isArray(o2)

     k1 = Object.keys(o1).sort()
     k2 = Object.keys(o2).sort()

     return false if k1.length != k2.length

     k1.every (key)=>
       if typeof o1[key] == typeof o2[key] == "object"
         @_deepEquals(o1[key], o2[key])
       else
         o1[key] == o2[key]

  _getCached: (type, query)->
    cachedObject = @get('queryCache').get(type).find (cachedQuery)=>
      @_deepEquals(query, cachedQuery.query)

    cachedObject.collection

  _setCached: (type, query, collection)->
    dataToCache = {query: query, collection: collection}

    @set('queryCache', Ember.Object.create()) unless @get('queryCache')
    queryCache = @get('queryCache')

    typeArray = queryCache.get(type)
    if typeArray
      typeArray.push(dataToCache)
    else
      typeArray = Ember.A [dataToCache]

    queryCache.set(type, typeArray)

`export default QueryLogic`
