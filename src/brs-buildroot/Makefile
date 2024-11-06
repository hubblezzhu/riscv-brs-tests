.ONESHELL:
SHELL = /bin/bash
.SHELLFLAGS += -e

# BRS_BUILDROOT_CROSS_COMPILE = riscv64-linux-gnu-
BRS_BUILDROOT_TARGET = brs-buildroot
BRS_BUILDROOT_REPOURL = git@github.com:buildroot/buildroot.git
BRS_BUILDROOT_TAG = 2023.11
BRS_BUILDROOT_BRANCH = brs-test
BRS_BUILDROOT_OUPUT_PATH = output

.PHONY: brs-buildroot
brs-buildroot:
	@echo "Building BRS Buildroot..."
	@if [ ! -d "buildroot" ]; then
		echo "Cloning BRS Buildroot source..."
		git clone --progress $(BRS_BUILDROOT_REPOURL) buildroot

		pushd buildroot
		git checkout -b $(BRS_BUILDROOT_BRANCH) $(BRS_BUILDROOT_TAG)

		@echo "Applying patches..."
		@if ! command -v stg &> /dev/null; then
			echo "stg command not found. Please install stgit to apply patches."
			exit 1
		fi

		stg init
		stg import -s ../patches/series

		popd
	fi

	pushd buildroot
	@echo "Installing fwts patches..."
	cp ../patches/fwts/*.patch package/fwts/

	@echo "Configuring Buildroot..."
	cp ../config/buildroot_defconfig configs/
	mkdir -p `pwd`/$(BRS_BUILDROOT_OUPUT_PATH)

	@echo "Compiling Buildroot..."
	make O=`pwd`/$(BRS_BUILDROOT_OUPUT_PATH) buildroot_defconfig
	make O=`pwd`/$(BRS_BUILDROOT_OUPUT_PATH) -j$(nproc)
	rm `pwd`/configs/buildroot_defconfig

	@echo "BRS Buildroot build complete."
	popd

.PHONY: clean
clean:
	@echo "Cleaning Buildroot build..."
	@echo "Removing Buildroot directory..."
	@rm -rf buildroot
