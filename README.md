_[Demo and API docs](https://adelarosab.github.io/cordova-connection)_

### &lt;cordova-connection&gt;
`<cordova-connection>` provides information about the device's cellular and 
wifi connection, and whether the device has an internet connection.

### Installation
In your `www` project:
```bash
bower install --save cordova-connection
```

In your `cordova` project:
```bash
cordova plugin add cordova-plugin-network-information
```

### Usage
```html
<cordova-connection
  online
  ready
  type="4G"
></cordova-connection>
```

`<cordova-connection>` allow to read the state of the device's connection
 in the current moment. `ready` means cordova is fully operative and 
 `type`  shows the kind of connection.

---

###### Note
Due to restrictions `ready` attribute is not shown into attributes table.
