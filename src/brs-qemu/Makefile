.ONESHELL:
SHELL = /bin/bash
.SHELLFLAGS += -e

BRS_QEMU_CROSS_COMPILE = riscv64-linux-gnu-
BRS_QEMU_TARGET = brs-qemu
BRS_QEMU_REPOURL = git@github.com:vlsunil/qemu.git
BRS_QEMU_BRANCH = riscv_acpi_b2_v7
BRS_QEMU_COMMIT = 15ecd5f3774b63a5893adb0c0ff657a9b316cb56

.PHONY: brs-qemu
brs-qemu:
	@echo "Building BRS QEMU..."
	@if [ ! -d "qemu" ]; then \
		git clone --progress $(BRS_QEMU_REPOURL) qemu; \
	fi

	@pushd qemu
	@git fetch origin
	@git checkout $(BRS_QEMU_BRANCH)
	@git reset --hard $(BRS_QEMU_COMMIT)

	@git submodule update --init --recursive

	@echo "Configuring QEMU..."
	./configure  --enable-slirp --enable-debug --target-list=riscv64-softmmu

	@echo "Compiling QEMU..."
	make -j$(nproc)

	@echo "BRS QEMU build complete."
	@popd

.PHONY: clean
clean:
	@echo "Cleaning QEMU build..."
	@echo "Removing QEMU directory..."
	@rm -rf qemu
