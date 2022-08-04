# HELP MESSAGE:
#
# if [$@ != "h"]; then
#     printf "Build to uf2 image, upload the firmware, run the monitor.\n"
#     printf " Syntax: run.sh [*|h]\n"
#     printf " Options:\n"
#     printf "\n *    insert any argument for running monitor only"
#     printf "\n h    print help message\n\n"
#     exit;

if [$1 = ""]; then
    printf "Building...\n"

    if pio run; then
        printf "Done."
    else
        printf "Build failed: exiting."
        exit;
    fi

    printf "\n\nGenerating UF2 image...\n"

    if ~/.platformio/packages/tool-rp2040tools/elf2uf2 ./.pio/build/nanorp2040connect/firmware.elf ./.pio/build/nanorp2040connect/firmware.elf.uf2; then
        printf "Done."
    else
        printf "Process failed: exiting."
        exit;
    fi

    while true
    do
        printf "\n\nCopying firmware...\n"
        
        if cp ./.pio/build/nanorp2040connect/firmware.elf.uf2 /media/"$USER"/RPI-RP2/; then
            printf "Done."
            break;
        else
            printf "Copy failed.\n\nPress any key to try again..."
        fi

        read -n 1 -s
    done

    printf "\n\nMonitor service: press any key to start...\n"
    read -n 1 -s
fi

pio run -t monitor

printf "\n"
