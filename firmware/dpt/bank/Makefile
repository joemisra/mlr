.DEFAULT_GOAL := all
MEMORY ?= flash
TARGET = mlr_rnbo_bank_$(MEMORY)
override BUILD_DIR = build/$(MEMORY)
CPP_SOURCES = main.cpp generated/daisy_dpt_bank.cpp generated/usb_midi_bank.cpp ../.deps/dpt/dev/DAC7554.cpp
LIBDAISY_DIR = ../.deps/libdaisy
SYSTEM_FILES_DIR = $(LIBDAISY_DIR)/core
OPT = -O3
LDSCRIPT = generated/layout_$(MEMORY).lds
ifeq ($(MEMORY),sram)
C_DEFS += -DBOOT_APP
endif
C_INCLUDES = -I../.deps/dpt -Igenerated/common -I../.deps/libdaisy/Middlewares/ST/STM32_USB_Device_Library/Class/CDC/Inc
include $(SYSTEM_FILES_DIR)/Makefile
vpath %.cpp ../.deps/dpt ../.deps/dpt/dev
CFLAGS := $(filter-out -g -ggdb,$(CFLAGS)) -g1 -fno-strict-aliasing -flto
LDFLAGS += -flto
CPPFLAGS += -fno-rtti -fsingle-precision-constant
$(BUILD_DIR)/main.o: Makefile midi_state.h midi_queue.h usb_protocol.h physical_ranges.h bank_parameters.h channel_knobs.h ../rnbo_allocator.h generated/rnbo_source.h

vpath %.cpp generated
