import Darwin
import Foundation

func beauty(raw: String, maxLen: Int) -> String {
  return raw.padding(toLength: maxLen, withPad: " ", startingAt: 0)
}

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
  for wifi in wifis {
    print()
    print( wifi.ssid, "(", wifi.bssid, ")" )    
    print( "\\ ", terminator: "" ) 
    print( beauty(raw: wifi.modes, maxLen: 10), terminator: "")    
    print( beauty(raw: wifi.channel, maxLen: 10), terminator: "")    
    print( beauty(raw: wifi.channel_band, maxLen: 10), terminator: "")    
    print( beauty(raw: wifi.channel_bandwidth, maxLen: 10), terminator: "")
    print( beauty(raw: wifi.rssi, maxLen: 10), terminator: "")
    print( beauty(raw: wifi.noise, maxLen: 10), terminator: "")
    print( beauty(raw: wifi.security, maxLen: 100) )  
  }

  sleep(update_interval)
} while update_interval > 0

