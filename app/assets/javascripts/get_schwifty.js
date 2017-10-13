GetSchwifty = function(app) {
  _App = app;

  function dispatchEvent(ev, el, data) {
    data = data || {}
    var event = new CustomEvent('getSchwifty.' + ev, {
      detail: data,
      bubbles: true
    });
    el.dispatchEvent(event)
  }

  function replaceContent(schwiftyJobId, oldEl, response) {
    dispatchEvent('render:before', oldEl, { schwiftyJobId: schwiftyJobId, response: response });

    var newContent = document.createRange().createContextualFragment(response.body);
    var newEl = newContent.firstChild;
    oldEl.parentNode.replaceChild(newContent, oldEl);

    dispatchEvent('render:after', newEl, { schwiftyJobId: schwiftyJobId, html: response });
  }

  function redirectTo(schwiftyJobId, oldEl, response) {
    dispatchEvent('redirect:before', oldEl, { schwiftyJobId: schwiftyJobId, response: response });

    window.location = response.body;
  }

  return {
    showMeWhatYouGot: function(selector) {
      selector = selector || '';

      [].forEach.call(document.querySelectorAll(selector + ' [data-get-schwifty]'), function(el) {
        var schwiftyJobId = el.getAttribute('data-get-schwifty');
        var schwiftyParams = JSON.parse(el.getAttribute('data-get-schwifty-params')) || {};

        dispatchEvent('subscribe:before', el, { schwiftyJobId: schwiftyJobId, paschwiftyParamsrams: schwiftyParams });

        var subscription = Object.assign({ channel: "GetSchwiftyChannel", id: schwiftyJobId }, schwiftyParams);

        var cable = _App.cable.subscriptions.create(subscription, {
          received: function(response) {

            switch (response.status) {
              case 302:
              redirectTo(schwiftyJobId, el, response);
              break;
              default:
              replaceContent(schwiftyJobId, el, response);
            }

            cable.perform('rendered');
            cable.unsubscribe();
          }
        });

        dispatchEvent('subscribe:after', el, { schwiftyJobId: schwiftyJobId })
      });
    }
  };
}
