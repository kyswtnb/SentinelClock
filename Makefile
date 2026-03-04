APP_NAME = SentinelClock
BUNDLE_ID = com.kyswtnb.SentinelClock
BUILD_DIR = build
APP_BUNDLE = $(BUILD_DIR)/$(APP_NAME).app
MACOS_DIR = $(APP_BUNDLE)/Contents/MacOS
RESOURCES_DIR = $(APP_BUNDLE)/Contents/Resources
SOURCES = $(wildcard Sources/*.swift)

all: x86 arm universal app

x86:
	mkdir -p $(BUILD_DIR)
	swiftc $(SOURCES) -target x86_64-apple-macosx11.0 -emit-executable -o $(BUILD_DIR)/$(APP_NAME)_x86_64

arm:
	mkdir -p $(BUILD_DIR)
	swiftc $(SOURCES) -target arm64-apple-macosx11.0 -emit-executable -o $(BUILD_DIR)/$(APP_NAME)_arm64

universal: x86 arm
	lipo -create -output $(BUILD_DIR)/$(APP_NAME) $(BUILD_DIR)/$(APP_NAME)_x86_64 $(BUILD_DIR)/$(APP_NAME)_arm64

app: universal
	mkdir -p $(MACOS_DIR)
	mkdir -p $(RESOURCES_DIR)
	cp $(BUILD_DIR)/$(APP_NAME) $(MACOS_DIR)/
	cp Resources/Info.plist $(APP_BUNDLE)/Contents/
	@echo "Build complete: $(APP_BUNDLE)"

clean:
	rm -rf $(BUILD_DIR)
