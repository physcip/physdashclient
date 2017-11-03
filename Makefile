OPTS		:= -std=c++11 -fobjc-arc
FRAMEWORKS	:= -framework Cocoa -framework Webkit
LIBS		:= -lc++
TARGET		:= dashboard
WRAPPER		:= xcrun -r

all: $(TARGET)
	@echo "Compilation successful"

$(TARGET): $(TARGET).mm
	$(WRAPPER) clang++ $(OPTS) $(FRAMEWORKS) $(LIBS) $(TARGET).mm -o $(TARGET)

run: $(TARGET)
	./$(TARGET)

bundle: $(TARGET)
	mkdir -p physdash.app/Contents
	mkdir -p physdash.app/Contents/MacOS
	mkdir -p physdash.app/Contents/Resources
	cp Info.plist physdash.app/Contents
	cp Icon.icns physdash.app/Contents/Resources
	cp $(TARGET) physdash.app/Contents/MacOS

.PHONY: clean
clean:
	$(RM) $(TARGET)
	$(RM) -r physdash.app