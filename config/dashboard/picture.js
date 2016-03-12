var blessed = require('blessed')
  , contrib = require('blessed-contrib')
  , screen = blessed.screen()

var pic = contrib.picture(
   { file: './res/icon.png'
   , cols: 95
   , onReady: ready})
function ready() { screen.render() }

screen.append(pic)
