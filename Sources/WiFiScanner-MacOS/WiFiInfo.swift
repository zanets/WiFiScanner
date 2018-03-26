import CoreWLAN

class WiFiInfo {

  // Do you want my password?
  var ssid: String
  // mac address
  var bssid: String
  // a, ac, b, g, n
  var modes: String
  // 2.4G: 1-14, 5G: TL;DR
  var channel: Int
  // 2.4, 5GHz
  var channel_band: String
  // 20, 40, 80, 160MHz
  var channel_bandwidth: String
  // WPA...
  var security: String
  // dBm
  var noise: Int
  // dBm
  var rssi: Int

  init (network: CWNetwork) {
    self.ssid              = network.ssid ?? "Unknown SSID"
    self.bssid             = network.bssid ?? "Unknown BSSID"
    self.channel           = network.wlanChannel.channelNumber
    self.channel_band      = gen_channel_band(cw_channel_band: network.wlanChannel.channelBand)
    self.modes             = gen_modes(network: network)
    self.channel_bandwidth = gen_channel_bandwidth(cw_channel_width: network.wlanChannel.channelWidth)
    self.security          = gen_security(network: network)
    self.noise             = network.noiseMeasurement
    self.rssi              = network.rssiValue
  }
}

func gen_channel_bandwidth (cw_channel_width: CWChannelWidth) -> String {
  if cw_channel_width == CWChannelWidth.width20MHz {
    return "20MHz"
  } else if cw_channel_width == CWChannelWidth.width40MHz {
    return "40MHz"
  } else if cw_channel_width == CWChannelWidth.width80MHz {
    return "80MHz"
  } else if cw_channel_width == CWChannelWidth.width160MHz {
    return "160MHz"
  } else {
    return "Unknown Channel Bandwidth"
  }
}

func gen_modes (network: CWNetwork) -> String {
  var res = ""

  if network.supportsPHYMode(CWPHYMode.modeNone) {
    res += "None,"
  }
  if network.supportsPHYMode(CWPHYMode.mode11a) {
    res += "a,"
  }
  if network.supportsPHYMode(CWPHYMode.mode11ac) {
    res += "ac,"
  }
  if network.supportsPHYMode(CWPHYMode.mode11b) {
    res += "b,"
  }
  if network.supportsPHYMode(CWPHYMode.mode11g) {
    res += "g,"
  }
  if network.supportsPHYMode(CWPHYMode.mode11n) {
    res += "n,"
  }

  return res
}

func gen_channel_band (cw_channel_band: CWChannelBand) -> String {
  if cw_channel_band == CWChannelBand.band2GHz {
    return "2.4GHz"
  } else if cw_channel_band == CWChannelBand.band5GHz {
    return "5GHz"
  } else {
    return "Unknown Channel Band"
  }
}

func gen_security (network: CWNetwork) -> String {
  var res = ""

  // OMG so much...
  if network.supportsSecurity(CWSecurity.none) {
    res += "None/"
  }
  if network.supportsSecurity(CWSecurity.unknown) {
    res += "Unknown/"
  }
  if network.supportsSecurity(CWSecurity.dynamicWEP) {
    res += "Dynamic WEP/"
  }
  if network.supportsSecurity(CWSecurity.enterprise) {
    res += "Enterprise/"
  }
  if network.supportsSecurity(CWSecurity.personal) {
    res += "Personal/"
  }
  if network.supportsSecurity(CWSecurity.WEP) {
    res += "WEP/"
  }
  if network.supportsSecurity(CWSecurity.wpa2Enterprise) {
    res += "WPA2 Enterprise/"
  }
  if network.supportsSecurity(CWSecurity.wpa2Personal) {
    res += "WPA2 Personal/"
  }
  if network.supportsSecurity(CWSecurity.wpaEnterprise) {
    res += "WPA Enterprise/"
  }
  if network.supportsSecurity(CWSecurity.wpaEnterpriseMixed) {
    res += "WPA Enterprise Mixed/"
  }
  if network.supportsSecurity(CWSecurity.wpaPersonal) {
    res += "WPA Personal/"
  }
  if network.supportsSecurity(CWSecurity.wpaPersonalMixed) {
    res += "WPA Personal Mixed/"
  }

  return res
}
