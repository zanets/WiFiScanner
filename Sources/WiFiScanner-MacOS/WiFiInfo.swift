import CoreWLAN

class WiFiInfo {

  // Do you want my password?
  var ssid: String
  // a, ac, b, g, n
  var modes: String
  // 2.4G: 1-14, 5G: TL;DR
  var channel: Int
  // 2.4, 5GHz
  var channel_band: String
  // 20, 40, 80, 160MHz
  var channel_bandwidth: String

  init (network: CWNetwork) {
    self.ssid              = network.ssid ?? "Unknown SSID"
    self.channel           = network.wlanChannel.channelNumber
    self.channel_band      = gen_channel_band(cw_channel_band: network.wlanChannel.channelBand)
    self.modes             = gen_modes(network: network)
    self.channel_bandwidth = gen_channel_bandwidth(cw_channel_width: network.wlanChannel.channelWidth)
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
  var modes = ""

  if network.supportsPHYMode(CWPHYMode.modeNone) {
    return modes
  }
  if network.supportsPHYMode(CWPHYMode.mode11a) {
    modes += "a,"
  }
  if network.supportsPHYMode(CWPHYMode.mode11ac) {
    modes += "ac,"
  }
  if network.supportsPHYMode(CWPHYMode.mode11b) {
    modes += "b,"
  }
  if network.supportsPHYMode(CWPHYMode.mode11g) {
    modes += "g,"
  }
  if network.supportsPHYMode(CWPHYMode.mode11n) {
    modes += "n,"
  }

  return modes
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
