import { acceptance, exists } from "discourse/tests/helpers/qunit-helpers";
import { visit } from "@ember/test-helpers";
import { test } from "qunit";

acceptance("Discourse Blank Pages", function (needs) {
  const external_js_link = 'nonexistent_dummy_url';
  needs.settings({ external_js_link });

  test("example page works", async function (assert) {
    await visit("/pages/example");
    assert.ok(exists("#example"), "it shows the div on page with route name as id");
  });

  test('external js link on page', async function (assert) {
    await visit("/pages/example");
    const scriptElement = document.querySelector(`
      script[src='${external_js_link}']
    `);
    
    assert.ok(scriptElement !== null, `Script tag with src '${external_js_link}' found`);
  })
});