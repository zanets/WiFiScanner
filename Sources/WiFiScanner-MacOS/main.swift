import Darwin
import Foundation
import SwiftyTextTable

let Sets = getSettings( argus: getopt_long(argus: Array(CommandLine.arguments.dropFirst())))
let scanner = WiFiScanner()

// if updateInterval doesnt set, process run once.
// if updateInterval set but updateTimes not set, process run forever.
// if updateInterval set and also updateTimes, process run updateTimes times.
var updateInterval = Sets.updateInterval
var updateTimes = Sets.updateTimes

if ( updateInterval == ARGUMENT_NOT_SET_INT ) {
	updateInterval = 0
	updateTimes = 1
} else if ( updateTimes == ARGUMENT_NOT_SET_INT ) {
	updateTimes = Int.max 
}

// create text table
let titles = ["SSID", "BSSID", "PHY Mode", "Channel", "Channel Band", "Bandwidth", "RSSI", "Noise", "Security"]
var cols = [TextTableColumn]()
for i in 0...titles.count-1 {
	cols.append(TextTableColumn(header: titles[i]))
}

// do scan
while updateTimes > 0 {
	guard var wifis = scanner.scan() else {
		print("Process terminatied.");
		exit(-1)
	}

	// sort by ssid
	wifis.sort(by: {$0.ssid < $1.ssid})

	var table = TextTable(columns: cols)
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

	if updateTimes != Int.max {
		updateTimes -= 1
	}

	print(table.render())
	sleep(UInt32(updateInterval))
}

