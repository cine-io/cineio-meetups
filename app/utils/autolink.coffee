# strongly adapted from:
# https://github.com/bryanwoods/autolink-js

pattern = ///
  (^|\s) # Capture the beginning of string or leading whitespace
  (
    (?:https?|ftp):// # Look for a valid URL protocol (non-captured)
    [\-A-Z0-9+\u0026@#/%?=()~_|!:,.;]* # Valid URL characters (any number of times)
    [\-A-Z0-9+\u0026@#/%=~()_|] # String must end in a valid URL character
  )
///gi

# usage: autolink('abc')
# usage: autolink('abc', link_options)
#   => link_options: {target: "_blank", rel: "nofollow", id: "1"}
# usage: autolink('abc', callback: (url)-> url)
module.exports = (str, options...) ->

  return str.replace(pattern, "$1<a href='$2'>$2</a>") unless options.length > 0

  option = options[0]
  linkAttributes = (
    " #{k}='#{v}'" for k, v of option when k isnt 'callback'
  ).join('')

  matchFunction = (match, space, url) ->
    link = option.callback?(url) or
      "<a href='#{url}'#{linkAttributes}>#{url}</a>"
    "#{space}#{link}"

  str.replace pattern, matchFunction
