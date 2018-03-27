import Darwin
import Foundation
import SwiftyTextTable

// global settings
var update_interval: UInt32 = 0

// parse arguments and init scanner
let argus = getopt_long(argus: CommandLine.arguments)
for argu in argus {
  if argu.name == "interval" {
    let input = UInt32(argu.value) ?? 0
    guard input >= 5 else {
      print("Parse arguments error: intreval should be >= 5 but get ", argu.value)
      continue
    }
    update_interval = input
  }
}
let scanner = WiFiScanner()

// create text table
let titles = ["SSID", "BSSID", "PHY Mode", "Channel", "Channel Band", "Bandwidth", "RSSI", "Noise", "Security"]
var cols = [TextTableColumn]()
for i in 0...titles.count-1 {
  cols.append(TextTableColumn(header: titles[i]))
}
var table = TextTable(columns: cols)

// do scan
repeat {
  guard var wifis = scanner.scan() else {
    print("Process terminatied.");
    exit(-1)
  }
  
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
  wifis.removeAll()
  sleep(update_interval)
} while update_interval > 0

