func getopt_long (argus: [String]) -> [(name: String, value: String)] {
  var res = [(name: String, value: String)]()

  for argu in argus {

    let seps = argu.split(separator: "=", maxSplits: 1)

    guard seps.count == 2 else {
      print("Parse arguments error: ", argu)
      continue
    }

    let name = seps[0]
    let value = seps[1]

    guard name.hasPrefix("--") else {
      print("Parse arguments error: require '--': ", argu)
      continue
    }

    res.append( (name: String(name.dropFirst(2)), value: String(value)) )
  }

  return res
}
