Polymer:
  is: "cordova-connection"

  properties:
    ready:
      notify: yes
      observer: "_observeReady"
      readOnly: yes
      type: Boolean
      value: no
    type:
      readOnly: yes
      reflectToAttribute: yes
      type: String
      value: "unknown"

  _observeType: ->
    connection = navigator.connection

    @_setType switch connection.type
      when connection.CELL
        "cell"
      when connection.CELL_2G
        "2G"
      when connection.CELL_3G
        "3G"
      when connection.CELL_4G
        "4G"
      when connection.ETHERNET
        "ethernet"
      when connection.WIFI
        "wifi"
      when connection.NONE
        "none"
      else
        "unkown"


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
