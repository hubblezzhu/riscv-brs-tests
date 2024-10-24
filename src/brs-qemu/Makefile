.ONESHELL:
SHELL = /bin/bash
.SHELLFLAGS += -e

BRS_QEMU_CROSS_COMPILE = riscv64-linux-gnu-
BRS_QEMU_TARGET = brs-qemu
BRS_QEMU_REPOURL = https://github.com/qemu/qemu.git
BRS_QEMU_BRANCH = master
BRS_QEMU_COMMIT = v8.0.0

.PHONY: brs-qemu
brs-qemu:
	@echo "Building BRS QEMU..."
	@if [ ! -d "qemu" ]; then \
		git clone --progress $(BRS_QEMU_REPOURL) qemu; \
	fi
	@cd qemu && \
	git fetch origin && \
	git checkout $(BRS_QEMU_BRANCH) && \
	git reset --hard $(BRS_QEMU_COMMIT)

	@echo "Applying patches..."
	@if ! command -v stg &> /dev/null; then \
		echo "stg command not found. Please install stgit to apply patches."; \
		exit 1; \
	fi
	@cd qemu && \
	stg init && \
	stg import -s ../patches/series

	@echo "Configuring QEMU..."
	@cd qemu && \
	./configure --target-list=riscv64-softmmu --enable-kvm

	@echo "Compiling QEMU..."
	@cd qemu && \
	make -j$(nproc)

	@echo "BRS QEMU build complete."

.PHONY: clean
clean:
	@echo "Cleaning QEMU build..."
	@echo "Removing QEMU directory..."
	@rm -rf qemu
