BUILD_PATH=.build/x86_64-apple-macosx10.10/release/WiFiScanner
NAME=WiFiScanner
BIN1=/usr/local/bin
BIN2=/usr/bin

default: compile

compile: compile-release compile-debug

compile-release:
	swift build -c release -Xswiftc -static-stdlib

compile-debug:
	swift build -c debug

clean:
	swift package clean

cleanall:
	swift package reset
	@if [ -e ${BIN1}/${NAME} ]; then\
		rm ${BIN1}/${NAME} &&\
		echo "Remove ${BIN1}/${NAME}";\
	elif [ -e ${BIN2}/${NAME}  ]; then\
		rm ${BIN2}/${NAME} &&\
		echo "Remove ${BIN2}/${NAME}";\
	fi

install:
	@if [ -d ${BIN1} ]; then\
		cp ${BUILD_PATH} ${BIN1}/${NAME} &&\
		echo "Installed to ${BIN1}/${NAME}";\
	elif [ -d ${BIN2} ]; then\
		cp ${BUILD_PATH} ${BIN2}/${NAME} &&\
		echo "Installed to ${BIN2}/${NAME}";\
	fi
	
