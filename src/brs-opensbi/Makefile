.ONESHELL:
SHELL = /bin/bash
.SHELLFLAGS += -e

BRS_OPENSBI_CROSS_COMPILE = riscv64-linux-gnu-
BRS_OPENSBI_TARGET = brs-opensbi
BRS_OPENSBI_REPOURL = https://github.com/riscv-software-src/opensbi.git
BRS_OPENSBI_BRANCH = master
BRS_OPENSBI_COMMIT = v1.2

.PHONY: brs-opensbi
brs-opensbi:
	@echo "Building BRS OpenSBI..."
	@if [ ! -d "opensbi" ]; then \
		git clone --progress $(BRS_OPENSBI_REPOURL) opensbi; \
	fi
	@cd opensbi && \
	git fetch origin && \
	git checkout $(BRS_OPENSBI_BRANCH) && \
	git reset --hard $(BRS_OPENSBI_COMMIT)

	@echo "Applying patches..."
	@if ! command -v stg &> /dev/null; then \
		echo "stg command not found. Please install stgit to apply patches."; \
		exit 1; \
	fi
	@cd opensbi && \
	stg init && \
	stg import -s ../patches/series

	@echo "Compiling OpenSBI..."
	@cd opensbi && \
	make PLATFORM=generic CROSS_COMPILE=$(BRS_OPENSBI_CROSS_COMPILE) -j$(nproc)

	@echo "BRS OpenSBI build complete."

.PHONY: clean
clean:
	@echo "Cleaning OpenSBI build..."
	@echo "Removing OpenSBI directory..."
	@rm -rf opensbi
