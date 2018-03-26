import CoreWLAN

class WiFiScanner {
  let client: CWWiFiClient = CWWiFiClient.shared()

  func getInterface () -> CWInterface? {
    guard let interface = self.client.interface() else {
      print("Fail to get WiFi interface.")
      return nil
    }
    return interface
  }

  func scan () -> Array<WiFiInfo>? {
    guard let interface = self.getInterface() else {
      return nil
    }

    if let networks = try? interface.scanForNetworks(withName: nil) {
      var infos = [WiFiInfo]()
      for network in networks {
        infos.append( WiFiInfo(network: network) )
      }
      return infos
    } else {
      print("Scan fail.")
      return nil
    }
  }

  func scan (name: String) -> Array<WiFiInfo>? {
    guard let interface = self.getInterface() else {
      return nil
    }

    if let networks = try? interface.scanForNetworks(withName: name) {
      var infos = [WiFiInfo]()
      for network in networks {
        infos.append( WiFiInfo(network: network) )
      }
      return infos
    } else {
      print("Scan fail.")
      return nil
    }
  }
}
