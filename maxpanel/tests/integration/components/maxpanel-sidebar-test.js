import { moduleForComponent, test } from 'ember-qunit';
import hbs from 'htmlbars-inline-precompile';

moduleForComponent('maxpanel-sidebar', 'Integration | Component | maxpanel sidebar', {
  integration: true
});

test('it renders', function(assert) {
  // Set any properties with this.set('myProperty', 'value');
  // Handle any actions with this.on('myAction', function(val) { ... });

  this.render(hbs`{{maxpanel-sidebar}}`);

  assert.equal(this.$().text().trim(), '');

  // Template block usage:
  this.render(hbs`
    {{#maxpanel-sidebar}}
      template block text
    {{/maxpanel-sidebar}}
  `);

  assert.equal(this.$().text().trim(), 'template block text');
});
