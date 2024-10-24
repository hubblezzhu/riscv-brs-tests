.ONESHELL:
SHELL = /bin/bash
.SHELLFLAGS += -e

BRS_SBI_TEST_CROSS_COMPILE = riscv64-linux-gnu-
BRS_SBI_TEST_TARGET = brs-sbi-test
BRS_SBI_TEST_SRC = sbi-test.c

.PHONY: brs-sbi-test
brs-sbi-test:
	@echo "Building BRS SBI Test..."
	@$(BRS_SBI_TEST_CROSS_COMPILE)gcc -o $(BRS_SBI_TEST_TARGET) $(BRS_SBI_TEST_SRC)
	@echo "BRS SBI Test build complete."

.PHONY: clean
clean:
	@echo "Cleaning SBI Test build..."
	@rm -f $(BRS_SBI_TEST_TARGET)
