# @cjsx React.DOM
React = require('react')

module.exports = React.createClass

  buttonClasses: (isOn=true)->
    return "toggle-button-off" unless isOn
    return "toggle-button-on"

  iconClasses: (isOn=true)->
    className = if isOn then @props.onClassName else @props.offClassName
    return "fa fa-3x #{className}"

  updateIconClasses: (event, isOn)->
    buttonEl = iconEl = event.target
    console.dir buttonEl
    if buttonEl.firstChild
      iconEl = buttonEl.firstChild
    else
      buttonEl = buttonEl.parentNode

    buttonEl.className = @buttonClasses(isOn)
    iconEl.className = @iconClasses(isOn)

  mouseOutIcon: (event)->
    @updateIconClasses(event, @props.isOn)

  mouseOverIcon: (event)->
    @updateIconClasses(event, !@props.isOn)

  render: ->
    title = if !@props.isOn then "Turn #{@props.buttonName} on" else "Turn #{@props.buttonName} off"

    return (
      <button title={title} className={@buttonClasses(@props.isOn)} onClick={@props.onClick} onMouseOver={@mouseOverIcon} onMouseOut={@mouseOutIcon}>
        <i className={@iconClasses(@props.isOn)}></i>
      </button>
    )
