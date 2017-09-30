GetSchwifty = function(app) {
  _App = app;

  function dispatchEvent(ev, el, data) {
    data = data || {}
    var event = new CustomEvent('getSchwifty.' + ev, {
      detail: data,
      bubbles: true
    });
    el.dispatchEvent(event)
  };

  return {
    showMeWhatYouGot: function(selector) {
      selector = selector || '';

      [].forEach.call(document.querySelectorAll(selector + ' [data-get-schwifty]'), function(el) {
        var schwiftyJobId = el.getAttribute('data-get-schwifty');
        var schwiftyParams = JSON.parse(el.getAttribute('data-get-schwifty-params')) || {};

        dispatchEvent('subscribe:before', el, { schwiftyJobId: schwiftyJobId, paschwiftyParamsrams: schwiftyParams });

        var subscription = Object.assign({ channel: "GetSchwiftyChannel", id: schwiftyJobId }, schwiftyParams);

        var cable = _App.cable.subscriptions.create(subscription, {
          received: function(html) {
            dispatchEvent('render:before', el, { schwiftyJobId: schwiftyJobId, html: html });

            var newContent = document.createRange().createContextualFragment(html);
            var newEl = newContent.firstChild;
            el.parentNode.replaceChild(newContent, el)

            dispatchEvent('render:after', newEl, { schwiftyJobId: schwiftyJobId, html: html });

            cable.perform('rendered');
            cable.unsubscribe();
          }
        });

        dispatchEvent('subscribe:after', el, { schwiftyJobId: schwiftyJobId })
      });
    }
  };
}
