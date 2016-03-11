_                 = require '../../vendor/lodash'
React             = require 'react'
ReactRedux        = require 'react-redux'
Login             = require './010-login'
Settings          = require './016-settings'
Icon              = require './910-icon'
actions           = require '../actions/actions'

mapStateToProps = (state) -> 
  settings:       state.settings
mapDispatchToProps = (dispatch) ->
  expandAllStories:   -> dispatch actions.expandAllStories()
  collapseAllStories: -> dispatch actions.collapseAllStories()
  clearLogs:          -> dispatch actions.clearLogs()
  quickFind: (txt) -> dispatch actions.quickFind txt

Toolbar = React.createClass
  displayName: 'Toolbar'

  #-----------------------------------------------------
  propTypes:
    # From Redux.connect
    settings:             React.PropTypes.object.isRequired
    expandAllStories:     React.PropTypes.func.isRequired
    collapseAllStories:   React.PropTypes.func.isRequired
  getInitialState: ->
    fSettingsShown:       false


  #-----------------------------------------------------
  render: -> 
    <div>
      {@renderSettings()}
      <div style={_style.outer}>
        <div style={_style.left}>
          <Icon 
            icon="cog" 
            size="lg"
            title="Show settings..."
            onClick={@toggleSettings}
            style={_style.icon}
          />
          <Icon 
            icon="chevron-circle-down" 
            size="lg" 
            title="Expand all stories"
            onClick={@props.expandAllStories}
            style={_style.icon}
          />
          <Icon 
            icon="chevron-circle-right" 
            size="lg" 
            title="Collapse all stories"
            onClick={@props.collapseAllStories}
            style={_style.icon}
          />
          <Icon 
            icon="remove"
            size="lg" 
            title="Clear logs"
            onClick={@props.clearLogs}
            style={_style.icon}
          />
          {' '}
          <input
            id="quickFind"
            type="search"
            results=0
            placeholder="Quick find..."
            onChange={@onChangeQuickFind}
          />
        </div>
        <div style={_style.spacer}/>
        <Login/>
      </div>
      <div style={_style.placeholder}/>
    </div>

  renderSettings: ->
    return if not @state.fSettingsShown
    <Settings onClose={@toggleSettings}/>

  #-----------------------------------------------------
  toggleSettings: -> @setState {fSettingsShown: not @state.fSettingsShown}
  onChangeQuickFind: (ev) -> @props.quickFind ev.target.value

#-----------------------------------------------------
_style = 
  outer:
    position: 'fixed'
    top: 0
    left: 0
    height: 30
    width: '100%'
    backgroundColor: 'white'
    borderBottom: '1px solid #ccc'
    display: 'flex'
    flexDirection: 'row'
    whiteSpace: 'nowrap'
  icon:
    cursor: 'pointer'
    marginRight: 5
  placeholder:
    height: 30
  left:
    padding: "4px 4px 4px 8px"
  spacer:
    flex: '1 1 0px'

#-----------------------------------------------------
connect = ReactRedux.connect mapStateToProps, mapDispatchToProps
module.exports = connect Toolbar