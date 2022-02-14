#!/sbin/sh

fix_symlinks() {
    # Save original paths (for later usage)
    REAL_LK=`readlink -f /dev/block/platform/soc/11230000.mmc/by-name/lk`
    REAL_TEE1=`readlink -f /dev/block/platform/soc/11230000.mmc/by-name/tee1`
    REAL_TEE2=`readlink -f /dev/block/platform/soc/11230000.mmc/by-name/tee2`

    # Remove critical blocks
    rm /dev/block/platform/soc/11230000.mmc/by-name/lk
    rm /dev/block/platform/soc/11230000.mmc/by-name/tee1
    rm /dev/block/platform/soc/11230000.mmc/by-name/tee2

    # Relocate critical blocks
    ln -s $REAL_LK /dev/block/platform/soc/11230000.mmc/by-name/lk_real
    ln -s $REAL_TEE1 /dev/block/platform/soc/11230000.mmc/by-name/tee1_real
    ln -s $REAL_TEE2 /dev/block/platform/soc/11230000.mmc/by-name/tee2_real

    # Fake critical blocks
    ln -s /dev/null /dev/block/platform/soc/11230000.mmc/by-name/lk
    ln -s /dev/null /dev/block/platform/soc/11230000.mmc/by-name/tee1
    ln -s /dev/null /dev/block/platform/soc/11230000.mmc/by-name/tee2
}

fix_bootpatch() {
    # Read current headers
    dd if=/dev/block/platform/soc/11230000.mmc/by-name/recovery of=/tmp/recovery_amonet.hdr bs=512 count=2
    dd if=/dev/block/platform/soc/11230000.mmc/by-name/boot of=/tmp/boot_amonet.hdr bs=512 count=2
    dd if=/dev/block/platform/soc/11230000.mmc/by-name/boot of=/tmp/boot_amonet.hdr2 bs=512 count=2 skip=2

    # Verify current headers (restore if needed)
    diff /tmp/recovery_amonet.hdr /tmp/boot_amonet.hdr
    if [ $? -ne 0 ] ; then
        echo "Detected old or overwritten boot-exploit, restoring from recovery" > /tmp/restore_bootpatch.log
        grep "ANDROID!" /tmp/boot_amonet.hdr2
        if [ $? -ne 0 ] ; then
    	    echo "Copy header to block 2" >> /tmp/restore_bootpatch.log
    	    dd if=/tmp/boot_amonet.hdr of=/dev/block/platform/soc/11230000.mmc/by-name/boot bs=512 count=2 seek=2
        fi

        dd if=/tmp/recovery_amonet.hdr of=/dev/block/platform/soc/11230000.mmc/by-name/boot bs=512 count=2
    fi
}

fix_symlinks
fix_bootpatch
