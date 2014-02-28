//= require jquery
//= require handlebars
//= require ember
//= require ember-data
//= require spree

Spree.App = Ember.Application.create()

DS.RESTAdapter.reopen 
  namespace: 'api'
  headers:
    'X-Spree-Token': 'fake'

DS.RESTAdapter.map('Spree.App.Product', {
  variant:
    embedded: 'always'
  }
)

Spree.App.Router.map ->
  this.route('products', { path: '/products' })
  this.resource('product', { path: '/product/:slug' });

Spree.App.Variant = DS.Model.extend
  product: DS.belongsTo('product')
  name: DS.attr('string')
  
Spree.App.Product = DS.Model.extend
  name: DS.attr('string')
  slug: DS.attr('string')
  display_price: DS.attr('string')
  master: DS.belongsTo('variant', { embedded: 'always'})

Spree.App.IndexRoute = Ember.Route.extend
  model: ->
    this.store.find('product')

Spree.App.ProductsRoute = Ember.Route.extend
  beforeModel: ->
    this.transitionTo('index')

Spree.App.ProductRoute = Ember.Route.extend({
  model: (params) ->
    return this.store.find('product', params.slug)
});