import Darwin
import Foundation

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

// do scan
repeat {
  guard var wifis = scanner.scan() else {
    print("Process terminatied.");
    exit(-1)
  }
  
  // sort by ssid
  wifis.sort(by: {$0.ssid < $1.ssid})
  
  // output
  print("--------------------------------------")
  for wifi in wifis {
    print(wifi.ssid, "(", wifi.bssid, ")")    
    print("\t", wifi.modes, terminator: "")    
    print("\t", wifi.channel, terminator: "")    
    print("\t", wifi.channel_band, terminator: "")    
    print("\t", wifi.channel_bandwidth, terminator: "")
    print("\t", wifi.rssi, "dBm", terminator: "")
    print("\t", wifi.noise, " dBm", terminator: "")
    print("\t", wifi.security)  
  }
  print("--------------------------------------")

  sleep(update_interval)
} while update_interval > 0

