\
# ============================================================
# 04_boundary_tap.tcl
# Student flow wrapper around the course-provided boundary/TAP helper.
# ============================================================
source [file normalize [file join [file dirname [info script]] .. config project_setup.tcl]]

set BOUNDARY_TAP_HELPER "$COURSE_ASSETS_DIR/insert_boundary_and_tap_cells.tcl"
if {![file exists $BOUNDARY_TAP_HELPER]} {
    error "Missing course-provided helper: $BOUNDARY_TAP_HELPER"
}

open_lib $DESIGN_LIB
copy_block -from ${TOP_MODULE}/floorplan -to ${TOP_MODULE}/floorplan_tap
open_block ${TOP_MODULE}/floorplan_tap

set_parasitics_parameters \
    -early_spec CMIN \
    -late_spec CMAX \
    -corners [get_corners *]

# Include M5 so the dedicated clock-pin constraint is compatible.
set_block_pin_constraints -self \
    -allowed_layers {M3 M4 M5} \
    -sides {1 2 3 4} \
    -pin_spacing_distance 1 \
    -width 0.11 \
    -length 0.11

set_individual_pin_constraints \
    -ports [get_ports clk_i] \
    -sides 2 \
    -allowed_layers M5

place_pins -self
source -echo $BOUNDARY_TAP_HELPER
check_legality

save_block
save_lib

echo "DONE: boundary and tap cells saved as ${TOP_MODULE}/floorplan_tap"
