\
# ============================================================
# 02_initial_synthesis.tcl
# Initial technology mapping and baseline QoR reports.
# ============================================================
source [file normalize [file join [file dirname [info script]] .. config project_setup.tcl]]

open_lib $DESIGN_LIB
open_block ${TOP_MODULE}/rtl_read

set_parasitics_parameters \
    -early_spec CMIN \
    -late_spec CMAX \
    -corners [get_corners *]

compile_fusion -check_only
compile_fusion -to initial_map

redirect -file "$REPORT_DIR/initial_map_qor.rpt"          { report_qor }
redirect -file "$REPORT_DIR/initial_map_area.rpt"         { report_area }
redirect -file "$REPORT_DIR/initial_map_power.rpt"        { report_power }
redirect -file "$REPORT_DIR/initial_map_timing_setup.rpt" { report_timing -delay_type max -max_paths 20 }
redirect -file "$REPORT_DIR/initial_map_timing_hold.rpt"  { report_timing -delay_type min -max_paths 20 }

check_timing
save_block -as ${TOP_MODULE}/initial_map
save_lib

echo "DONE: initial synthesis saved as ${TOP_MODULE}/initial_map"
