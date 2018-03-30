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
	
test:

