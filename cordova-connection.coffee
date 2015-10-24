Polymer:
  is: "cordova-connection"

  properties:
    ### Return if cordova deviceready event has been fired. ###
    ready:
      notify: yes
      observer: "_observeReady"
      readOnly: yes
      type: Boolean
      value: no
    ### Offers a fast way to determine the device's network connection state, and
   type of connection ###
    type:
      readOnly: yes
      reflectToAttribute: yes
      type: String
      value: "unknown"

  _observeType: ->
    Connection = navigator.connection
    types = {}
    types[Connection.CELL] = "cell"
    types[Connection.CELL_2G] = "2G"
    types[Connection.CELL_3G] = "3G"
    types[Connection.CELL_4G] = "4G"
    types[Connection.ETHERNET] = "ethernet"
    types[Connection.NONE] = "none"
    types[Connection.WIFI] = "wifi"

    @_setType types[Connection.type] || "unkown"

  attached: ->
    observer = @_observeType
    offlineFn = @fire.bind this, "cordova-connection-offline"
    onlineFn = @fire.bind this, "cordova-connection-online"

    document.addEventListener "offline", observer, false
    document.addEventListener "offline", offlineFn, false
    document.addEventListener "online", observer, false
    document.addEventListener "online", onlineFn, false

  detached: ->
    document.addEventListener "offline", @_observeType
    document.addEventListener "offline", @fire
    document.addEventListener "online", @_observeType
    document.addEventListener "online", @fire
