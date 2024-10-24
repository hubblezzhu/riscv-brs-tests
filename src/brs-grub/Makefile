.ONESHELL:
SHELL = /bin/bash
.SHELLFLAGS += -e

BRS_GRUB_CROSS_COMPILE = riscv64-linux-gnu-
BRS_GRUB_TARGET = brs-grub
BRS_GRUB_REPOURL = https://git.savannah.gnu.org/git/grub.git
BRS_GRUB_BRANCH = grub-2.12
BRS_GRUB_TAG = grub-2.12
BRS_GRUB_COMMIT = 5ca9db22e8ed0dbebb2aec53722972de0680a463

.PHONY: brs-grub
brs-grub:
	@echo "Building BRS GRUB..."
	@if [ ! -d "grub" ]; then \
		git clone --progress $(BRS_GRUB_REPOURL) grub; \
	fi

	@pushd grub
	@git fetch origin
	@git checkout -b $(BRS_GRUB_BRANCH) $(BRS_GRUB_TAG) || true
	@git reset --hard $(BRS_GRUB_COMMIT)

	@echo "Applying patches..."
	@if ! command -v stg &> /dev/null; then \
		echo "stg command not found. Please install stgit to apply patches."; \
		exit 1; \
	fi

	stg init || true
	stg import -s ../patches/series

	@echo "Configuring GRUB..."
	@mkdir -p output
	@if [ -e bootstrap ]; then \
		if [ ! -e grub-core/lib/gnulib/stdlib.in.h ]; then \
			./bootstrap
		fi
	fi

	./autogen.sh
	./configure --target=riscv64-linux-gnu \
		--with-platform=efi \
		--prefix=$TOP_DIR/$GRUB_PATH/output/ \
		--disable-werror

	@echo "Compiling GRUB..."
	make -j$(nproc)

	@echo "BRS GRUB build complete."
	@popd

.PHONY: clean
clean:
	@echo "Cleaning GRUB build..."
	@echo "Removing GRUB directory..."
	@rm -rf grub
