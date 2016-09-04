Polymer(
  {
    is: 'cordova-connection',

    /**
     * Fired when an application goes offline, and the device is not
     * connected to the Internet.
     *
     * @event offline
     * @event cordova-connection-offline
     */

    /**
     * Fired when an application goes online, and the device becomes
     * connected to the Internet.
     *
     * @event online
     * @event cordova-connection-online
     */

    hostAttributes: {
      hidden: true
    },

    properties: {
      online: {
        notify: true
        readOnly: true,
        type: Boolean,
        value: false
      }

      /**
       * Return if cordova deviceready event has been fired.
       */
      ready: {
        computed: '_computeReady(_ready_, _paused_)',
        notify: true,
        observer: '_observeReady'
        type: Boolean,
        value: false
      },

      /**
       * Offers a fast way to determine the device's network connection
       * state, and type of connection.
       */
      type: {
        readOnly: true,
        type: String
        value: 'UNKOWN'
      }
    }

    _computeReady(ready, paused) {
      return ready && !paused;
    },

    _observeReady(ready) {
      if (ready) {
        document.addEventListener('offline', this._onOffline, false);
        document.addEventListener('online', this._onOnline, false);
      }
    }

    _onOffline() {
      this.fire('offline', ...arguments);
      this.fire('cordova-connection-offline', ...arguments);

      this._setOnline(false);
      this._setConnection();
    },

    _onOnline() {
      this.fire('online', ...arguments);
      this.fire('cordova-connection-online', ...arguments);

      this._setOnline(true);
      this._setConnection();
    },

    _setConnection() {
      const Connection = navigator.connection;
      const types = {};
      types[Connection.CELL] = "CELL"
      types[Connection.CELL_2G] = "2G"
      types[Connection.CELL_3G] = "3G"
      types[Connection.CELL_4G] = "4G"
      types[Connection.ETHERNET] = "ETHERNET"
      types[Connection.NONE] = "NONE"
      types[Connection.WIFI] = "WIFI"

      this._setType(types[Connection.type] || 'UNKOWN');
    }

    detached() {
      document.removeEventListener('offline', this._onOffline);
      document.removeEventListener('online', this._onOnline);
    }
  }
)
