\
# ============================================================
# 01_read_rtl_sdc.tcl
# Analyze/elaborate the course-provided RTL and read constraints.
# ============================================================
source [file normalize [file join [file dirname [info script]] .. config project_setup.tcl]]

set RTL_FILE  "$RTL_DIR/riscv_core_all.v"
set DEFS_FILE "$RTL_DIR/riscv_defs.v"

foreach required_file [list $RTL_FILE $DEFS_FILE $SDC_FILE] {
    if {![file exists $required_file]} {
       error "Missing required local asset: $required_file"
    }
}

open_lib $DESIGN_LIB

# riscv_core_all.v includes riscv_defs.v in the supplied source tree.
set_app_var search_path [concat $search_path [list $RTL_DIR]]

suppress_message VER-130
analyze -format verilog $RTL_FILE
unsuppress_message VER-130

elaborate $TOP_MODULE
set_top_module $TOP_MODULE

# Signal routing-direction convention used in this implementation.
set_attribute [get_layers {M1 M3 M5 M7 M9}] routing_direction vertical
set_attribute [get_layers {M2 M4 M6 M8 MRDL}] routing_direction horizontal

source $SDC_FILE

current_block
report_ref_libs
report_clocks
check_timing

save_block -as ${TOP_MODULE}/rtl_read
save_lib

echo "DONE: RTL read, linked, constrained, and saved as ${TOP_MODULE}/rtl_read"
