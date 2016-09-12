# Riot.js Syntax highlight

Atom Syntax highlight for [Riot.js](http://riotjs.com/) `.tag` components.

## install

- Via Atom Editor: search for `riot-tag`
- Console: `apm install language-riot-tag`

## Emmet

- For Emmet compatibility, add the following to your `keymap.cson` file.

```
'atom-text-editor[data-grammar="text html riot"]:not([mini])':
    'tab': 'emmet:expand-abbreviation-with-tab'
```

## Note

- You've got to put your JS / es6 / coffee scripts inside `<script></script>` tag to get syntax highlights.
- `CoffeeScript`, `Sass`, `Scss`, `Less` and `Stylus` highlights should work fine. You need to specify your language on the `type` attribute. e.g. `(<style type="stylus">)`
- `Jade` is not supported.
- Pull requests are always welcome!

## Credit

- Thanks to @yyx990803 as I've used his Sublime Text Vue Syntax highlights repo as a template to setup this repo.
