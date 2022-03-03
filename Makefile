TARGET    := go-cli
VERSION   := v0.14.0
BUILD     := $(shell date -u +%Y-%m-%d.%H:%M)

PKG       := github.com/ahmedmkamal/go-cli

SRC_DIR   := .
BUILD_DIR := build
EXE       := $(BUILD_DIR)/$(TARGET)

GO        ?= go
LDFLAGS   += -X $(PKG)/v1.AppName=$(TARGET)
LDFLAGS   += -X $(PKG)/v1.AppVersion=$(VERSION)
LDFLAGS   += -X $(PKG)/v1.AppBuild=$(BUILD)

all: clean build

.PHONY: build

build:
	$(GO) build -ldflags "$(LDFLAGS)" -o $(EXE) $(SRC_DIR)

.PHONY: build/debug

build/debug:
	$(GO) build -tags debug -ldflags "$(LDFLAGS)" -o $(EXE) $(SRC_DIR)

.PHONY: test

test:
	go test -bench -v ./...

.PHONY: clean

clean:
	$(RM) -rf $(BUILD_DIR)
