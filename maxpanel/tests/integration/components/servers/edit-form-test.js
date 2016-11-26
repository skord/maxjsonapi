import { moduleForComponent, test } from 'ember-qunit';
import hbs from 'htmlbars-inline-precompile';

moduleForComponent('servers/edit-form', 'Integration | Component | servers/edit form', {
  integration: true
});

test('it renders', function(assert) {
  // Set any properties with this.set('myProperty', 'value');
  // Handle any actions with this.on('myAction', function(val) { ... });

  this.render(hbs`{{servers/edit-form}}`);

  assert.equal(this.$().text().trim(), '');

  // Template block usage:
  this.render(hbs`
    {{#servers/edit-form}}
      template block text
    {{/servers/edit-form}}
  `);

  assert.equal(this.$().text().trim(), 'template block text');
});
