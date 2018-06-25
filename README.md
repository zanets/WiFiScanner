# WiFiScanner

![demo](https://raw.githubusercontent.com/Zanets/WiFiScanner/master/Demo/demo.jpeg)

### USAGE
```
Usage: WiFiScanner [OPTION]
Scan wireless networks and view WLAN SSID, BSSID, PHY Mode, Channel, Channel Band, Bandwidth, RSSI, Noise and Security

--help, -h            This usage
--updateInterval=NUM  Wait for NUM seconds for every scan
--updateTimes=NUM     Scan NUM times
--ssid=NAME           Find wifi which SSID is NAME
--fssid=NAME          Find wifi which contains NAME in SSID.
--band=[24|5]         Find 2.4G or 5G.

About updateInterval and updateTimes:
If updateInterval is not given, process run once.
If updateInterval is given but updateTimes is not, process run forever.
If updateInterval and updateTimes are given, process updateTimes times.
```

### TODO
- [ ] Refresh output
- [ ] Filter 



