default: compile

compile:
	swift build

clean:
	swift clean

test:
	.build/x86_64-apple-macosx10.10/debug/WiFiScanner-MacOS

run:
	.build/x86_64-apple-macosx10.10/debug/WiFiScanner-MacOS --interval=10
	

