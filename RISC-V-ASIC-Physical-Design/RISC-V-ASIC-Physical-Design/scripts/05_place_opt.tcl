\
# ============================================================
# 05_place_opt.tcl
# Placement and placement optimization.
# ============================================================
source [file normalize [file join [file dirname [info script]] .. config project_setup.tcl]]

open_lib $DESIGN_LIB
open_block ${TOP_MODULE}/floorplan_pg_corrected

set_parasitics_parameters -early_spec CMIN -late_spec CMAX -corners [get_corners *]

set_app_options -name place.coarse.continue_on_missing_scandef -value true
set_app_options -name place_opt.final_place.effort          -value high
set_app_options -name place_opt.place.congestion_effort     -value high
set_app_options -name opt.common.user_instance_name_prefix  -value place_opt

set_lib_cell_purpose -include none [get_lib_cells -quiet {*/*_AO21* */*V2LP*}]

place_opt

redirect -tee -file "$REPORT_DIR/place_legality.rpt"        { check_legality }
redirect -tee -file "$REPORT_DIR/place_congestion.rpt"      { report_congestion -rerun_global_router }
redirect -tee -file "$REPORT_DIR/place_utilization.rpt"     { report_utilization }
redirect -file "$REPORT_DIR/place_qor.rpt"                  { report_qor }
redirect -file "$REPORT_DIR/place_area.rpt"                 { report_area }
redirect -file "$REPORT_DIR/place_power.rpt"                { report_power }
redirect -file "$REPORT_DIR/place_setup_timing.rpt"         { report_timing -delay_type max -max_paths 20 }
redirect -file "$REPORT_DIR/place_hold_timing.rpt"          { report_timing -delay_type min -max_paths 20 }
redirect -tee -file "$REPORT_DIR/place_pg_connectivity.rpt" { check_pg_connectivity }
redirect -tee -file "$REPORT_DIR/place_pg_drc.rpt"          { check_pg_drc }

save_block -as ${TOP_MODULE}/place_opt
save_lib

echo "DONE: Placement saved as ${TOP_MODULE}/place_opt"
