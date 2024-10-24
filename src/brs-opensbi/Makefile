.ONESHELL:
SHELL = /bin/bash
.SHELLFLAGS += -e

BRS_OPENSBI_CROSS_COMPILE = riscv64-linux-gnu-
BRS_OPENSBI_TARGET = brs-opensbi
BRS_OPENSBI_REPOURL = git@github.com:riscv-software-src/opensbi.git
BRS_OPENSBI_BRANCH = v1.3.1
BRS_OPENSBI_COMMIT = 057eb10b6d523540012e6947d5c9f63e95244e94

.PHONY: brs-opensbi
brs-opensbi:
	@echo "Building BRS OpenSBI..."
	@if [ ! -d "opensbi" ]; then \
		git clone --progress $(BRS_OPENSBI_REPOURL) opensbi; \
	fi

	@pushd opensbi
	@git fetch origin
	@git checkout -b $(BRS_OPENSBI_BRANCH) $(BRS_OPENSBI_BRANCH) || true
	@git reset --hard $(BRS_OPENSBI_COMMIT)

	@echo "Compiling OpenSBI..."
	make ARCH=riscv CROSS_COMPILE=$(BRS_OPENSBI_CROSS_COMPILE) PLATFORM=generic -j$(nproc)

	@echo "BRS OpenSBI build complete."
	@popd

.PHONY: clean
clean:
	@echo "Cleaning OpenSBI build..."
	@echo "Removing OpenSBI directory..."
	@rm -rf opensbi
