forceHttps = (req, res, next) ->
  isHttps = req.headers["x-forwarded-proto"] == 'https'
  return next() if isHttps
  host = req.headers.host
  res.redirect("https://" + host + req.url)

module.exports = (app)->
  app.use forceHttps
