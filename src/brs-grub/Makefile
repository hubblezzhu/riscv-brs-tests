.ONESHELL:
SHELL = /bin/bash
.SHELLFLAGS += -e

BRS_GRUB_CROSS_COMPILE = riscv64-linux-gnu-
BRS_GRUB_TARGET = brs-grub
BRS_GRUB_REPOURL = https://git.savannah.gnu.org/git/grub.git
BRS_GRUB_BRANCH = master
BRS_GRUB_COMMIT = 5ca9db22e8ed0dbebb2aec53722972de0680a463

.PHONY: brs-grub
brs-grub:
	@echo "Building BRS GRUB..."
	@if [ ! -d "grub" ]; then \
		git clone --progress $(BRS_GRUB_REPOURL) grub; \
	fi
	@cd grub && \
	git fetch origin && \
	git checkout $(BRS_GRUB_BRANCH) && \
	git reset --hard $(BRS_GRUB_COMMIT)

	@echo "Applying patches..."
	@if ! command -v stg &> /dev/null; then \
		echo "stg command not found. Please install stgit to apply patches."; \
		exit 1; \
	fi
	@cd grub && \
	stg init && \
	stg import -s ../patches/series

	@echo "Configuring GRUB..."
	@cd grub && \
	./autogen.sh && \
	./configure --target=riscv64-linux-gnu --with-platform=efi

	@echo "Compiling GRUB..."
	@cd grub && \
	make -j$(nproc)

	@echo "BRS GRUB build complete."

.PHONY: clean
clean:
	@echo "Cleaning GRUB build..."
	@echo "Removing GRUB directory..."
	@rm -rf grub
