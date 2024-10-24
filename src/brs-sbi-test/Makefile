.ONESHELL:
SHELL = /bin/bash
.SHELLFLAGS += -e

BRS_SBI_TEST_CROSS_COMPILE = riscv64-linux-gnu-
BRS_SBI_TEST_TARGET = brs-sbi-test
BRS_SBI_TEST_REPOURL = https://gitlab.com/jones-drew/kvm-unit-tests.git
BRS_SBI_TEST_BRANCH = riscv/x-tests
BRS_SBI_TEST_COMMIT = bbd7e8faa2b31ebb44c54fa6e5d7ee371c56cd11

.PHONY: brs-sbi-test
brs-sbi-test:
	@echo "Building BRS SBI TEST..."
	@if [ ! -d "qemu" ]; then \
		git clone --progress $(BRS_SBI_TEST_REPOURL) sbi-test; \
	fi

	@pushd sbi-test
	@git fetch origin
	@git checkout -b x-tests $(BRS_SBI_TEST_BRANCH) || true
	@git reset --hard $(BRS_SBI_TEST_COMMIT)

	@git submodule update --init --recursive --progress

	@echo "Configuring SBI TEST..."
	./configure --arch=riscv64 --cross-prefix=$(BRS_SBI_TEST_CROSS_COMPILE)

	@echo "Compiling SBI TEST..."
	make -j$(nproc)

	@echo "BRS SBI TEST build complete."
	@popd


.PHONY: clean
clean:
	@echo "Cleaning SBI Test build..."
	@rm -f sbi-test
