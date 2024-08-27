SL_CONAN_CONFIG_VERSION	:= 4.0

# Default PROFILE values based on OS
#ifeq ($(OS),Windows_NT)
#    DEFAULT_PROFILE := x86_64-windows
#else
#    UNAME_S := $(shell uname -s)
#    ifeq ($(UNAME_S),Linux)
#        DEFAULT_PROFILE := x86_64-linux-gnu
#    endif
#    ifeq ($(UNAME_S),Darwin)
#        DEFAULT_PROFILE := x86_64-macos
#    endif
#endif

#PROFILE ?= $(DEFAULT_PROFILE)
BUILD_TYPE ?= Debug

HOST_PROFILE ?= $(PROFILE)
TARGET_PROFILE ?= $(PROFILE)

# Required hack for Windows. Some of our dependencies use nmake on windows which cannot parse Makefile variables.
# Makefile variables are set in MAKEOVERRIDES so we clear them here so they don't propagate.
MAKEOVERRIDES =

.PHONY: all clean

all: conan-config
	conan export .
# On Linux, enable devtoolset-11 for CentOS 7
ifeq ($(UNAME_S),Linux)
	scl enable devtoolset-11 'conan install . --build="*" --no-remote -pr:h=$(HOST_PROFILE) -pr:b=$(TARGET_PROFILE) -of build -s build_type=$(BUILD_TYPE)'
else
	conan install . --build="*" --no-remote -pr:h=$(HOST_PROFILE) -pr:b=$(TARGET_PROFILE) -of build -s build_type=$(BUILD_TYPE)
endif

#list-profiles: conan-config
	@#CONAN_HOME=`pwd` conan profile list -f json

#update-lockfile: conan-config
	#conan lock create --lockfile-out=conan.lock --lockfile-clean .
#	$(foreach profile, $(shell make list-profiles | jq -r '.[]'), \
#		echo "Profile: $(profile)"; \
#		conan lock create --lockfile-out=$(profile)-conan.lock -pr:h=$(profile) -pr:b=$(profile) .; \
#		conan lock merge --lockfile=conan.lock --lockfile=$(profile)-conan.lock --lockfile-out=conan.lock; \
#		rm $(profile)-conan.lock; \
#	)

conan-config:
	@conan config install-pkg sl-conan-config/$(SL_CONAN_CONFIG_VERSION)
