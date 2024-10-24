.ONESHELL:
SHELL = /bin/bash
.SHELLFLAGS += -e

BRS_LINUX_CROSS_COMPILE = riscv64-linux-gnu-
BRS_LINUX_TARGET = brs-linux
BRS_LINUX_REPOURL = git@github.com:vlsunil/linux.git
BRS_LINUX_BRANCH = acpi_b2_v2_riscv_aia_v11
BRS_LINUX_COMMIT = ac5e19d018afa8a37761510bd233ca319a763c42

.PHONY: brs-linux
brs-linux:
	@echo "Building BRS Linux..."
	@if [ ! -d "linux" ]; then \
		git clone --progress $(BRS_LINUX_REPOURL) linux; \
	fi

	@pushd linux
	@git fetch origin
	@git checkout $(BRS_LINUX_BRANCH)
	@git reset --hard $(BRS_LINUX_COMMIT)

	@echo "Applying patches..."
	@if ! command -v stg &> /dev/null; then \
		echo "stg command not found. Please install stgit to apply patches."; \
		exit 1; \
	fi

	# stg init || true
	# stg import -s ../patches/series

	@echo "Compiling Linux kernel..."
	@make ARCH=riscv defconfig
	@make ARCH=riscv CROSS_COMPILE=$(BRS_LINUX_CROSS_COMPILE) -j$(nproc)

	@echo "BRS Linux build complete."
	@popd

.PHONY: clean
clean:
	@echo "Cleaning Linux build..."
	@echo "Removing Linux directory..."
	@rm -rf linux
	@echo "BRS Linux clean complete."
