import Darwin

let ARGUMENT_NOT_SET_INT = -1

// global settings
struct Settings {
	var updateInterval: Int = ARGUMENT_NOT_SET_INT
	var updateTimes: Int = ARGUMENT_NOT_SET_INT
	var maxRecord: Int = ARGUMENT_NOT_SET_INT
	var sortBy: String = "SSID"
	var sortOrder: String = ""
}

func getopt_long (argus: [String]) -> [(name: String, value: String)] {
	var res = [(name: String, value: String)]()

	for argu in argus {

		let seps = argu.split(separator: "=", maxSplits: 1)

		var name: String = ""
		var value: String = ""

		if seps.count == 1 {
			name = String(seps[0])
		} else if seps.count == 2 {
			name = String(seps[0])
			value = String(seps[1])
		} else {
			print("Argument error on \(argu)")
		}

		guard name.hasPrefix("--") || name.hasPrefix("-") else {
			print("Arguments error: require '--' or '-' on \(argu)")
			continue
		}
		
		if name.first == "-" {
			name.removeFirst()
		}
		
		if name.first == "-" {
			name.removeFirst()
		}
		
		res.append( (name: name, value: value ) )
	}

	return res
}

func getSettings ( argus: [(name: String, value: String)] ) -> Settings{
	var Sets = Settings()
	for argu in argus {
		if argu.name == "updateInterval" {
			let input = Int(argu.value) ?? ARGUMENT_NOT_SET_INT
			guard input >= 5 else {
				print("Arguments error: updateIntreval should be >= 5 but get \(argu.value)")
				exit(-1)
			}
			Sets.updateInterval = input
		} else if argu.name == "updateTimes" {
			let input = Int(argu.value) ?? ARGUMENT_NOT_SET_INT
			guard input >= 0 else {
				print("Arguments error: updateTimes should be >= 0 but get \(argu.value)")
				exit(-1)
			}
			Sets.updateTimes = input
		} else if argu.name == "help" || argu.name == "h" {
			usage()
			exit(0)
		}
	}
	return Sets
}

func usage() {
	print("Usage: WiFiScanner-MacOS [OPTION]")
	print("Scan wireless networks and view WLANSSID, BSSID, PHY Mode, Channel, Channel Band, Bandwidth, RSSI, Noise and Security")
	print()
	print("--help, -h            This usage")
	print("--updateInterval=NUM  Process wait for NUM seconds for every scan")
	print("--updateTimes=NUM     Process will scan NUM times")
	print("\nAbout updateInterval and updateTimes:")
	print("If updateInterval is not given, process run once.")
	print("If updateInterval is given but updateTimes is not, process run forever.")
	print("If updateInterval and updateTimes are given, process updateTimes times.")
}
