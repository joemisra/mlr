.DEFAULT_GOAL := all
TARGET = mlr_rnbo_kick
CPP_SOURCES = main.cpp .deps/dpt/daisy_dpt.cpp .deps/dpt/dev/DAC7554.cpp
LIBDAISY_DIR = .deps/libdaisy
SYSTEM_FILES_DIR = $(LIBDAISY_DIR)/core
OPT = -O3
C_INCLUDES = -I.deps/dpt -Igenerated/common
include $(SYSTEM_FILES_DIR)/Makefile
vpath %.cpp .deps/dpt .deps/dpt/dev
# Build through build.py: validates the export and records dependency hashes.
# Flashing is deliberately a separate manual operation after reviewing the binary.

# RNBO signal helpers use type punning; prevent strict-aliasing optimizations.
CFLAGS += -fno-strict-aliasing
build/main.o: Makefile
