.ONESHELL:
SHELL = /bin/bash
.SHELLFLAGS += -e

BRS_GRUB_CROSS_COMPILE = riscv64-linux-gnu-
BRS_GRUB_TARGET = brs-grub
BRS_GRUB_REPOURL = https://git.savannah.gnu.org/git/grub.git
BRS_GRUB_BRANCH = brs-test
BRS_GRUB_TAG = grub-2.12

BRS_GRUB_PLAT_CONFIG_FILE = ../config/grub_prefix.cfg

.PHONY: brs-grub
brs-grub:
	@echo "Building BRS GRUB..."
	@if [ ! -d "grub" ]; then
		echo "Cloning BRS grub source..."
		git clone --progress $(BRS_GRUB_REPOURL) grub

		pushd grub
		git checkout -b $(BRS_GRUB_BRANCH) $(BRS_GRUB_TAG)

		@echo "Applying patches..."
		@if ! command -v stg &> /dev/null; then
			echo "stg command not found. Please install stgit to apply patches."
			exit 1
		fi

		stg init
		stg import -s ../patches/series

		popd
	fi

	pushd grub
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
		--prefix=`pwd`/output \
		--disable-werror

	@echo "Compiling GRUB..."
	make -j$(nproc)
	make install
	output/bin/grub-mkimage -v -c ${BRS_GRUB_PLAT_CONFIG_FILE} \
	-o output/grubriscv64.efi -O riscv64-efi --disable-shim-lock -p "" \
	part_gpt part_msdos ntfs ntfscomp hfsplus fat ext2 normal chain \
	boot configfile linux help  terminal terminfo configfile \
	lsefi search normal gettext loadenv read search_fs_file search_fs_uuid search_label \
	pgp gcry_sha512 gcry_rsa tpm

	@echo "BRS GRUB build complete."
	popd

.PHONY: clean
clean:
	@echo "Cleaning GRUB build..."
	@echo "Removing GRUB directory..."
	@rm -rf grub
