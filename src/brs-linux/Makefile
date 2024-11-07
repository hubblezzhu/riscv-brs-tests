.ONESHELL:
SHELL = /bin/bash
.SHELLFLAGS += -e

BRS_LINUX_CROSS_COMPILE = riscv64-linux-gnu-
BRS_LINUX_TARGET = brs-linux
BRS_LINUX_REPOURL = git@github.com:vlsunil/linux.git
BRS_LINUX_BRANCH = brs-test
BRS_LINUX_BRANCH_REMOTE = origin/acpi_b2_v2_riscv_aia_v11
# BRS_LINUX_COMMIT = ac5e19d018afa8a37761510bd233ca319a763c42

.PHONY: brs-linux
brs-linux:
	@echo "Building BRS Linux..."
	@if [ ! -d "linux" ]; then
		echo "Cloning BRS linux source..."
		git clone --progress $(BRS_LINUX_REPOURL) linux

		pushd linux
		git checkout -b $(BRS_LINUX_BRANCH) $(BRS_LINUX_BRANCH_REMOTE)
		popd
	fi

	@pushd linux
	@echo "Compiling Linux kernel..."
	@make ARCH=riscv CROSS_COMPILE=$(BRS_LINUX_CROSS_COMPILE) defconfig
	@make ARCH=riscv CROSS_COMPILE=$(BRS_LINUX_CROSS_COMPILE) -j$(nproc)

	@echo "BRS Linux build complete."
	popd

.PHONY: clean
clean:
	@echo "Cleaning Linux build..."
	@echo "Removing Linux directory..."
	@rm -rf linux
	@echo "BRS Linux clean complete."
