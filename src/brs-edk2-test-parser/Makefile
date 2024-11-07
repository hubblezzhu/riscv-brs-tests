.ONESHELL:
SHELL = /bin/bash
.SHELLFLAGS += -e

BRS_EDK2_TEST_PARSER_CROSS_COMPILE = riscv64-linux-gnu-
BRS_EDK2_TEST_PARSER_TARGET = brs-edk2-test-parser
BRS_EDK2_TEST_PARSER_REPOURL = https://git.gitlab.arm.com/systemready/edk2-test-parser.git
BRS_EDK2_TEST_PARSER_BRANCH = brs-test
BRS_EDK2_TEST_PARSER_COMMIT = 5082b6dedd93cd9c786455cc27aaa7b5105c5567

.PHONY: brs-edk2-test-parser
brs-edk2-test-parser:
	@echo "Building BRS EDK2-TEST-PARSER..."
	@if [ ! -d "edk2-test-parser" ]; then
		echo "Cloning BRS edk2-test-parser source..."
		git clone --progress $(BRS_EDK2_TEST_PARSER_REPOURL) edk2-test-parser

		pushd edk2-test-parser
		git checkout -b $(BRS_EDK2_TEST_PARSER_BRANCH) $(BRS_EDK2_TEST_PARSER_COMMIT)
		popd
	fi

	pushd edk2-test-parser
	@echo "Initializing edk2-test-parser submodules..."
	git submodule update --init --recursive --progress

	@echo "Setting up edk2-test-parser build environment..."

	@echo "Compiling edk2-test-parser..."

	@echo "BRS EDK2-TEST build complete."
	popd


.PHONY: clean
clean:
	@echo "Cleaning edk2-test-parser build..."
	@echo "Removing edk2-test-parser directory..."
	@rm -rf edk2-test-parser
