import Darwin
import Foundation
import SwiftyTextTable

let Sets = getSettings( argus: getopt_long(argus: Array(CommandLine.arguments.dropFirst())))
let titles = ["SSID", "BSSID", "PHY Mode", "Channel", "Channel Band", "Bandwidth", "RSSI", "Noise", "Security"]
guard let scanner = WiFiScanner() else {
    print("Init scanner fail.")
    exit(-1)
}

// if updateInterval doesnt set, process run once.
// if updateInterval set but updateTimes not set, process run forever.
// if updateInterval set and also updateTimes, process run updateTimes times.
var updateInterval = Sets.updateInterval
var updateTimes = Sets.updateTimes
var ssid: String? = Sets.findSSID

#if RELEASE
if ( updateInterval == ARGUMENT_NOT_SET_INT ) {
	updateInterval = 0
	updateTimes = 1
} else if ( updateTimes == ARGUMENT_NOT_SET_INT ) {
	updateTimes = Int.max 
}
#else
updateInterval = 5
updateTimes = Int.max
#endif

// create text table
var cols = [TextTableColumn]()
for i in 0...titles.count-1 {
	cols.append(TextTableColumn(header: titles[i]))
}

// do scan
while updateTimes > 0 {

	autoreleasepool{
		guard var wifis = scanner.scan(name: ssid) else {
			print("Process terminatied.");
			exit(-1)
		}
        
        var table = TextTable(columns: cols)
        
		// sort by ssid
		wifis.sort(by: {$0.ssid < $1.ssid})

		for wifi in wifis {
			table.addRow(values: [
				wifi.ssid,
				wifi.bssid,
				wifi.modes,
				wifi.channel,
				wifi.channel_band,
				wifi.channel_bandwidth,
				wifi.rssi,
				wifi.noise,
				wifi.security
			])
		}
        
		print(table.render())
	}
    
	if updateTimes != Int.max {
		updateTimes -= 1
	}
    
	sleep(UInt32(updateInterval))
}
