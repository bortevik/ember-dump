`import QueryLogic from '../../../logics/query'`
`import { test } from 'ember-qunit'`
`import Ember from 'ember'`

module 'Logics - Query',
  teardown: ->
    delete QueryLogic.queryCache

test '_deepEquals check equality of two objects', ->
  o1 = {foo: 2, bar: 'one'}
  o2 = {bar: 'one', foo: 2}
  ok(QueryLogic._deepEquals o1, o2)

test '_deepEquals check equality of two objects with unsorted arrays as values', ->
  o1 = {foo: 2, bar: [1,4,5,3,2]}
  o2 = {bar: [2,1,3,5,4], foo: 2}
  ok(QueryLogic._deepEquals(o1, o2))

test '_deepEquals check equality of two objects with nested objects', ->
  o1 = {foo: 2, bar: {baz: 'nested one', goo: 'nested two'}}
  o2 = {bar: {goo: 'nested two', baz: 'nested one'}, foo: 2}
  ok(QueryLogic._deepEquals o1, o2)

test '_setCached saves cache query with response collection', ->
  type = 'foo'
  query = {bar: 'one', baz: 1}
  collection = 'some collection'
  cachedObject = {query: query, collection: collection}

  ok(!QueryLogic.get('queryCache'))

  QueryLogic._setCached(type, query, collection)
  deepEqual(QueryLogic.get('queryCache').get(type), [cachedObject])

  QueryLogic._setCached(type, query, collection)
  deepEqual(QueryLogic.get('queryCache').get(type), [cachedObject, cachedObject])

test '_getCached gets saved collection', ->
  type = 'foo'
  query = {bar: 'one', baz: 1}
  collection = 'some collection'

  QueryLogic._setCached(type, query, collection)
  QueryLogic._setCached('some type', {goo: true}, 'another collection')
  equal(QueryLogic._getCached(type, query), collection)

test '_isQueryRequested checks whether such request occured', ->
  type = 'foo'
  query = {bar: 'one', baz: 1}
  collection = 'some collection'

  QueryLogic._setCached(type, query, collection)
  QueryLogic._setCached('some type', {goo: true}, 'another collection')
  ok(QueryLogic._isQueryRequested(type, query))