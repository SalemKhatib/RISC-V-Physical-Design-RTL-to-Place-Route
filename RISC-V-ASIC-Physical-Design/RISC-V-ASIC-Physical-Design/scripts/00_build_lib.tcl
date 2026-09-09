\
# ============================================================
# 00_build_lib.tcl
# Build the Fusion Compiler design library and load parasitic tech.
# ============================================================
source [file normalize [file join [file dirname [info script]] .. config project_setup.tcl]]

if {[file exists $DESIGN_LIB]} {
    error "Design library already exists: $DESIGN_LIB. Remove it before rebuilding."
}

create_lib $DESIGN_LIB \
    -technology $TECH_FILE \
    -ref_libs $REF_LIBS

report_ref_libs

set_attribute [get_site_defs unit] is_default true
set_attribute [get_site_defs unit] symmetry Y

read_parasitic_tech -tlup $TLUP_MAX -name CMAX
read_parasitic_tech -tlup $TLUP_MIN -name CMIN

save_lib
echo "DONE: created $DESIGN_LIB"
