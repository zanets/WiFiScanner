BUILD_PATH=.build/x86_64-apple-macosx10.10/release/WiFiScanner-MacOS
NAME=WiFiScanner

default: compile

compile: compile-release compile-debug

compile-release:
	swift build -c release -Xswiftc -static-stdlib

compile-debug:
	swift build

clean:
	swift package clean

cleanall:
	swift package reset

install:
	cp ${BUILD_PATH} ./${NAME}
	
