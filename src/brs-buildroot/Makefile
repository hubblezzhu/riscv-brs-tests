.ONESHELL:
SHELL = /bin/bash
.SHELLFLAGS += -e

# BRS_BUILDROOT_CROSS_COMPILE = riscv64-linux-gnu-
BRS_BUILDROOT_TARGET = brs-buildroot
BRS_BUILDROOT_REPOURL = git@github.com:buildroot/buildroot.git
BRS_BUILDROOT_TAG = 2023.11

.PHONY: brs-buildroot
brs-buildroot:
	@echo "Building BRS Buildroot..."
	@if [ ! -d "buildroot" ]; then \
		git clone --progress $(BRS_BUILDROOT_REPOURL) buildroot; \
	fi

	@pushd buildroot
	@git fetch origin
	@git checkout $(BRS_BUILDROOT_TAG)

	@echo "Applying patches..."
	@if ! command -v stg &> /dev/null; then \
		echo "stg command not found. Please install stgit to apply patches."; \
		exit 1; \
	fi

	stg init || true
	stg import -s ../patches/series

	@echo "Configuring Buildroot..."
	make qemu_riscv64_virt_defconfig

	# stg init || true
	# stg import -s ../patches/series

	@echo "Compiling Buildroot..."
	@cd buildroot && \
	make

	@echo "BRS Buildroot build complete."
	@popd

.PHONY: clean
clean:
	@echo "Cleaning Buildroot build..."
	@echo "Removing Buildroot directory..."
	@rm -rf buildroot
