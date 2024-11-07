.ONESHELL:
SHELL = /bin/bash
.SHELLFLAGS += -e

BRS_SBI_TEST_CROSS_COMPILE = riscv64-linux-gnu-
BRS_SBI_TEST_TARGET = brs-sbi-test
BRS_SBI_TEST_REPOURL = https://gitlab.com/jones-drew/kvm-unit-tests.git
BRS_SBI_TEST_BRANCH = brs-test
BRS_SBI_TEST_BRANCH_REMOTE = riscv/x-tests
# BRS_SBI_TEST_COMMIT = bbd7e8faa2b31ebb44c54fa6e5d7ee371c56cd11

.PHONY: brs-sbi-test
brs-sbi-test:
	@echo "Building BRS SBI TEST..."
	@if [ ! -d "sbi-test" ]; then \
		git clone --progress $(BRS_SBI_TEST_REPOURL) sbi-test;
		pushd sbi-test
		@git checkout -b $(BRS_SBI_TEST_BRANCH)
		@git branch --set-upstream-to=origin/$(BRS_SBI_TEST_BRANCH_REMOTE) $(BRS_SBI_TEST_BRANCH)
		@git pull --rebase

		popd
	fi

	pushd sbi-test
	@git submodule update --init --recursive --progress

	@echo "Configuring SBI TEST..."
	@./configure --arch=riscv64 --cross-prefix=$(BRS_SBI_TEST_CROSS_COMPILE)

	@echo "Compiling SBI TEST..."
	@make -j$(nproc)

	@echo "BRS SBI TEST build complete."
	popd


.PHONY: clean
clean:
	@echo "Cleaning SBI Test build..."
	@rm -f sbi-test
