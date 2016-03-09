function Trace(){

  // debug setting
  var DEBUG = true;

  if (!(window.console && console.log)) {
      (function() {
          var noop = function() {};
          var methods = ['assert', 'clear', 'count', 'debug', 'dir', 'dirxml', 'error', 'exception', 'group', 'groupCollapsed', 'groupEnd', 'info', 'log', 'markTimeline', 'profile', 'profileEnd', 'markTimeline', 'table', 'time', 'timeEnd', 'timeStamp', 'trace', 'warn'];
          var length = methods.length;
          var console = window.console = {};
          while (length--) {
              console[methods[length]] = noop;
          }
      }());
  }

  var isIE = eval("/*@cc_on!@*/false");
  window.trace = (function(){
    if(!DEBUG) {
      return function(){};
    }
    if(isIE) return function(){};
    if('console' in window){
      return console.log.bind(console);
    }
  })();

}

module.exports = Trace

