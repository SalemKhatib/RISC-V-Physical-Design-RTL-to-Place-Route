\
# ============================================================
# 03_logic_opto_floorplan.tcl
# Logic optimization plus automatic floorplan generation.
# ============================================================
source [file normalize [file join [file dirname [info script]] .. config project_setup.tcl]]

open_lib $DESIGN_LIB
open_block ${TOP_MODULE}/initial_map

set_parasitics_parameters \
    -early_spec CMIN \
    -late_spec CMAX \
    -corners [get_corners *]

set_app_options -name compile.auto_floorplan.enable -value true

# Floorplan target used in the implementation.
set_auto_floorplan_constraints \
    -control_type core \
    -core_utilization 0.60 \
    -core_offset 5 \
    -shape R \
    -side_ratio {1 1} \
    -flip_first_row true

# General signal pins on M3/M4; clock pin isolated to top side on M5.
set_block_pin_constraints -self \
    -allowed_layers {M3 M4} \
    -sides {1 2 3 4} \
    -pin_spacing_distance 1 \
    -width 0.11 \
    -length 0.11

set_individual_pin_constraints \
    -ports [get_ports clk_i] \
    -sides 2 \
    -allowed_layers M5

report_auto_floorplan_constraints
report_block_pin_constraints -self

compile_fusion -from initial_map -to logic_opto
place_pins -self

redirect -file "$REPORT_DIR/logic_opto_qor.rpt"          { report_qor }
redirect -file "$REPORT_DIR/logic_opto_area.rpt"         { report_area }
redirect -file "$REPORT_DIR/logic_opto_timing_setup.rpt" { report_timing -delay_type max -max_paths 20 }
redirect -file "$REPORT_DIR/logic_opto_congestion.rpt"   { report_congestion -rerun_global_router }

check_timing
save_block -as ${TOP_MODULE}/floorplan
save_lib

echo "DONE: logic optimization and floorplan saved as ${TOP_MODULE}/floorplan"
