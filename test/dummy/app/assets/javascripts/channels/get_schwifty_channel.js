document.addEventListener('getSchwifty.subscribe:before', function(ev) {
  console.log(ev);
}, false)

document.addEventListener('getSchwifty.subscribe:after', function(ev) {
  console.log(ev);
}, false)

document.addEventListener('getSchwifty.render:before', function(ev) {
  console.log(ev);
}, false)

document.addEventListener('getSchwifty.render:after', function(ev) {
  console.log(ev);
}, false)

document.addEventListener("DOMContentLoaded", function() {
  GetSchwifty(App).showMeWhatYouGot('body');
}, false);
