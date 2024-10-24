.ONESHELL:
SHELL = /bin/bash
.SHELLFLAGS += -e

BRS_BUILDROOT_CROSS_COMPILE = riscv64-linux-gnu-
BRS_BUILDROOT_TARGET = brs-buildroot
BRS_BUILDROOT_REPOURL = https://github.com/buildroot/buildroot.git
BRS_BUILDROOT_BRANCH = master
BRS_BUILDROOT_COMMIT = master

.PHONY: brs-buildroot
brs-buildroot:
	@echo "Building BRS Buildroot..."
	@if [ ! -d "buildroot" ]; then \
		git clone --progress $(BRS_BUILDROOT_REPOURL) buildroot; \
	fi
	@cd buildroot && \
	git fetch origin && \
	git checkout $(BRS_BUILDROOT_BRANCH) && \
	git reset --hard $(BRS_BUILDROOT_COMMIT)

	@echo "Configuring Buildroot..."
	@cd buildroot && \
	make qemu_riscv64_virt_defconfig

	@echo "Compiling Buildroot..."
	@cd buildroot && \
	make

	@echo "BRS Buildroot build complete."

.PHONY: clean
clean:
	@echo "Cleaning Buildroot build..."
	@echo "Removing Buildroot directory..."
	@rm -rf buildroot
