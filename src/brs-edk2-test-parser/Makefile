.ONESHELL:
SHELL = /bin/bash
.SHELLFLAGS += -e

BRS_EDK2_TEST_PARSER_CROSS_COMPILE = riscv64-linux-gnu-
BRS_EDK2_TEST_PARSER_TARGET = brs-edk2-test-parser
BRS_EDK2_TEST_PARSER_SRC = edk2-test-parser.c

.PHONY: brs-edk2-test-parser
brs-edk2-test-parser:
	@echo "Building BRS EDK2 Test Parser..."
	@$(BRS_EDK2_TEST_PARSER_CROSS_COMPILE)gcc -o $(BRS_EDK2_TEST_PARSER_TARGET) $(BRS_EDK2_TEST_PARSER_SRC)
	@echo "BRS EDK2 Test Parser build complete."

.PHONY: clean
clean:
	@echo "Cleaning EDK2 Test Parser build..."
	@rm -f $(BRS_EDK2_TEST_PARSER_TARGET)
