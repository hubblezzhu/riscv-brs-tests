.ONESHELL:
SHELL = /bin/bash
.SHELLFLAGS += -e

# BRS_QEMU_CROSS_COMPILE = riscv64-linux-gnu-
BRS_QEMU_TARGET = brs-qemu
BRS_QEMU_REPOURL = git@github.com:vlsunil/qemu.git
BRS_QEMU_BRANCH = brs-test
BRS_QEMU_BRANCH_REMOTE = origin/riscv_acpi_b2_v7
# BRS_QEMU_COMMIT = 15ecd5f3774b63a5893adb0c0ff657a9b316cb56

.PHONY: brs-qemu
brs-qemu:
	@echo "Building BRS QEMU..."
	@if [ ! -d "qemu" ]; then
		echo "Cloning BRS qemu source..."
		git clone --progress $(BRS_QEMU_REPOURL) qemu

		pushd qemu
		@git checkout -b $(BRS_QEMU_BRANCH) $(BRS_QEMU_BRANCH_REMOTE)

		@echo "Applying patches..."
		@if ! command -v stg &> /dev/null; then
			echo "stg command not found. Please install stgit to apply patches."
			exit 1
		fi

		stg init
		stg import -s ../patches/series
		popd
	fi

	pushd qemu
	@git submodule update --init --recursive --progress

	@if [ ! -d "roms/edk2" ]; then
		echo "Copying edk2 source..."
		cp -r ../../brs-edk2/edk2 roms/edk2
	fi

	@echo "Configuring QEMU..."
	./configure --enable-slirp --enable-debug --target-list=riscv64-softmmu

	@echo "Compiling QEMU..."
	make -j$(nproc)

	@echo "BRS QEMU build complete."
	popd

.PHONY: clean
clean:
	@echo "Cleaning QEMU build..."
	@echo "Removing QEMU directory..."
	@rm -rf qemu
