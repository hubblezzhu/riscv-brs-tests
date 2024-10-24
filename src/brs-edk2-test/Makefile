.ONESHELL:
SHELL = /bin/bash
.SHELLFLAGS += -e

BRS_EDK2_TEST_CROSS_COMPILE = riscv64-linux-gnu-
BRS_EDK2_TEST_TARGET = brs-edk2-test
BRS_EDK2_TEST_REPOURL = https://github.com/tianocore/edk2-test.git
BRS_EDK2_TEST_BRANCH = master
BRS_EDK2_TEST_COMMIT = master

.PHONY: brs-edk2-test
brs-edk2-test:
	@echo "Building BRS EDK2-Test..."
	@if [ ! -d "edk2-test" ]; then \
		git clone --progress $(BRS_EDK2_TEST_REPOURL) edk2-test; \
	fi
	@cd edk2-test && \
	git fetch origin && \
	git checkout $(BRS_EDK2_TEST_BRANCH) && \
	git reset --hard $(BRS_EDK2_TEST_COMMIT)

	@echo "Initializing EDK2-Test submodules..."
	@cd edk2-test && \
	git submodule update --init

	@echo "Setting up EDK2-Test build environment..."
	@cd edk2-test && \
	. edksetup.sh

	@echo "Building BaseTools..."
	@cd edk2-test && \
	make -C BaseTools

	@echo "Compiling EDK2-Test..."
	@cd edk2-test && \
	build -a RISCV64 -t GCC5 -p SctPkg/UEFI/SCT.dsc

	@echo "BRS EDK2-Test build complete."

.PHONY: clean
clean:
	@echo "Cleaning EDK2-Test build..."
	@echo "Removing EDK2-Test directory..."
	@rm -rf edk2-test
