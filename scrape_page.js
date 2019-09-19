var webPage = require('webpage');
var page = webPage.create();

var fs = require('fs');
var path = 'coes.html'

page.open('https://www.coes.org.pe/Portal/portalinformacion/demanda', function (status) {
  var content = page.content;
  fs.write(path,content,'w')
  phantom.exit();
});
