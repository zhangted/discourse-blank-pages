import DiscourseRoute from "discourse/routes/discourse";

function loadExternalJS({ external_js_link }) {
  if(!external_js_link) return;
  const script = document.createElement('script')
  script.src = external_js_link
  document.head.append(script)
}

export default DiscourseRoute.extend({
  model() {
    const external_js_link = this.siteSettings.external_js_link;
    loadExternalJS({ external_js_link });

    const page_id = this.paramsFor('pages').page_id;
    console.log(page_id)
    return { page_id }
  }
})
