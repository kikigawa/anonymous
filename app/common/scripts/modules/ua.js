function Ua(){
  var ua = navigator.userAgent.toUpperCase();
  var url = location.pathname;
  var spDir = '/sp/';

  (ua.indexOf('IPHONE') != -1 || ua.indexOf('IPAD') != -1 || ua.indexOf('IPOD') != -1 || ua.indexOf('ANDROID') != -1) ? isSP() : isPC();

  function isSP(){
    if(url.match(spDir)){
      return false;
    }else{
      location.href = url.match('/development/') ? '../sp/' : './sp/';
    }
  }

  function isPC(){
    if(!url.match(spDir)){
      return false;
    }else{
      var pos = url.indexOf('/sp/');
      location.href = url.slice(0, pos) + '/';
    }
  }

}

module.exports = Ua
