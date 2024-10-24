.ONESHELL:
SHELL = /bin/bash
.SHELLFLAGS += -e

BRS_EDK2_CROSS_COMPILE = riscv64-linux-gnu-
BRS_EDK2_TARGET = brs-edk2
BRS_EDK2_REPOURL = git@github.com:tianocore/edk2.git
BRS_EDK2_TAG = edk2-stable202308

.PHONY: brs-edk2
brs-edk2:
	@echo "Building BRS EDK2..."
	@if [ ! -d "edk2" ]; then \
		git clone --progress $(BRS_EDK2_REPOURL) edk2; \
	fi
	@cd edk2 && \
	git fetch origin && \
	git checkout $(BRS_EDK2_TAG)

	@echo "Initializing EDK2 submodules..."
	@cd edk2 && \
	git submodule update --init

	@echo "Setting up EDK2 build environment..."
	@cd edk2 && \
	. edksetup.sh

	@echo "Building BaseTools..."
	@cd edk2 && \
	make -C BaseTools

	@echo "Compiling EDK2..."
	@cd edk2 && \
	build -a RISCV64 -t GCC5 -p OvmfPkg/RiscVVirt/RiscVVirtQemu.dsc

	@echo "BRS EDK2 build complete."

.PHONY: clean
clean:
	@echo "Cleaning EDK2 build..."
	@echo "Removing EDK2 directory..."
	@rm -rf edk2
