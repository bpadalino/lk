#
# The TARGET is expected to indicate which *specific* AT91SAM3U chip
# is being used, since features and memory vary from chip to chip
#
#             chip       ram   rom
# AT91CHIP := sam3u1c    20k   64k
# AT91CHIP := sam3u1e    20k   64k
# AT91CHIP := sam3u2c    36k  128k
# AT91CHIP := sam3u2e    36k  128k
# AT91CHIP := sam3u4c    60k  256k
# AT91CHIP := sam3u4e    60k  256k
#

# ROMBASE, MEMBASE, and MEMSIZE are required for the linker script
ROMBASE := 0x0
MEMBASE := 0x200000

TMP_CFG := bad
ifeq ($(AT91CHIP), sam3u1c)
DEFINES += AT91_SAM3U=1 
DEFINES += AT91_RAMSIZE=65536
DEFINES += AT91_ROMSIZE=262144
MEMSIZE := 65536
TMP_CFG := ok
endif
ifeq ($(AT91CHIP), sam3u1e)
DEFINES += AT91_SAM3U=1 
DEFINES += AT91_RAMSIZE=65536
DEFINES += AT91_ROMSIZE=262144
MEMSIZE := 65536
TMP_CFG := ok
endif
ifeq ($(AT91CHIP), sam3u2c)
DEFINES += AT91_SAM3U=1 
DEFINES += AT91_RAMSIZE=16384
DEFINES += AT91_ROMSIZE=65536
MEMSIZE := 16384
TMP_CFG := ok
endif
ifeq ($(AT91CHIP), sam3u2e)
DEFINES += AT91_SAM3U=1
DEFINES += AT91_RAMSIZE=16384
DEFINES += AT91_ROMSIZE=65536
MEMSIZE := 16384
TMP_CFG := ok
endif
ifeq ($(AT91CHIP), sam3u4c)
DEFINES += AT91_SAM3U=1
DEFINES += AT91_RAMSIZE=16384
DEFINES += AT91_ROMSIZE=65536
MEMSIZE := 16384
TMP_CFG := ok
endif
ifeq ($(AT91CHIP), sam3u4e)
DEFINES += AT91_SAM3U=1
DEFINES += AT91_RAMSIZE=16384
DEFINES += AT91_ROMSIZE=65536
MEMSIZE := 16384
TMP_CFG := ok
endif

ifeq ($(TMP_CFG), bad)
$(error The AT91SAM3U platform requires AT91CHIP be set by the target)
endif

LOCAL_DIR := $(GET_LOCAL_DIR)

ARCH := arm
ARM_CPU := cortex-m3

DEFINES += AT91_MCK_MHZ=96000000

INCLUDES += \
	-I$(LOCAL_DIR)/include

OBJS += \
	$(LOCAL_DIR)/debug.o \
	$(LOCAL_DIR)/interrupts.o \
	$(LOCAL_DIR)/platform_early.o \
	$(LOCAL_DIR)/platform.o \
	$(LOCAL_DIR)/timer.o \
	$(LOCAL_DIR)/init_clock.o \
	$(LOCAL_DIR)/init_clock_48mhz.o \
	$(LOCAL_DIR)/mux.o

# use a two segment memory layout, where all of the read-only sections 
# of the binary reside in rom, and the read/write are in memory. The 
# ROMBASE, MEMBASE, and MEMSIZE make variables are required to be set 
# for the linker script to be generated properly.
#
LINKER_SCRIPT += \
	$(BUILDDIR)/system-twosegment.ld

