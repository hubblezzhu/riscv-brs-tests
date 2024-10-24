


REALEASE_TYPE:= Debug
TARGET_DIR = build/$(REALEASE_TYPE)

create_build_dir()
{
    echo "Creating target directory..."
    mkdir -p "${TARGET_DIR}"
    if [ $? -eq 0 ]; then
        echo "Target directory created successfully: ${TARGET_DIR}"
    else
        echo "Failed to create target directory: ${TARGET_DIR}"
        exit 1
    fi
}

brs_build()
{

}


brs_install()
{

}


main()
{
    create_build_dir()

    brs_build()
    brs_install()
}


main
