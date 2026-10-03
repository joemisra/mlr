/* Inserted into the bundled linker layout by build.py. */
    .rnbo_arena (NOLOAD) :
    {
        . = ALIGN(16);
        *(.rnbo_arena)
        . = ALIGN(16);
    } > SRAM
