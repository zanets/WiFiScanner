import CoreWLAN

class WiFiScanner {
	let client: CWWiFiClient = CWWiFiClient.shared()
    var interface: CWInterface
    
    init?() {
        guard let interface = self.client.interface() else {
            print("Fail to get WiFi interface.")
            return nil
        }
        self.interface = interface
    }

	func scan (name: String? = nil) -> Array<WiFiInfo>? {
		if let networks = try? self.interface.scanForNetworks(withName: name) {
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
