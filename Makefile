CFLAGS         := -fobjc-arc
LDFLAGS        := -framework Cocoa -framework Webkit
TARGET         := physdash

all: $(TARGET).app
	@echo "Compilation successful"

run: $(TARGET).app
	./$(TARGET).app/Contents/MacOS/$(TARGET)

$(TARGET).app: $(TARGET) Info.plist Icon.icns
	mkdir -p $(TARGET).app/Contents/MacOS
	mkdir -p $(TARGET).app/Contents/Resources
	cp Info.plist $(TARGET).app/Contents
	cp Icon.icns $(TARGET).app/Contents/Resources
	cp $(TARGET) $(TARGET).app/Contents/MacOS

dmg: $(TARGET).app
	hdiutil create -volname $(TARGET) -srcfolder $(TARGET).app -ov -format UDZO $(TARGET)

.PHONY: clean
clean:
	$(RM) $(TARGET)
	$(RM) -r $(TARGET).app
	$(RM) $(TARGET).dmg