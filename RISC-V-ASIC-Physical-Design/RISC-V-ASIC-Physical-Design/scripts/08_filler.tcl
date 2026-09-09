\
# ============================================================
# 08_filler.tcl
# Filler insertion and post-fill checks.
# ============================================================
source [file normalize [file join [file dirname [info script]] .. config project_setup.tcl]]

set FILLER_HELPER "$COURSE_ASSETS_DIR/filler.tcl"
if {![file exists $FILLER_HELPER]} {
    error "Missing course-provided filler helper: $FILLER_HELPER"
}

open_lib $DESIGN_LIB
open_block ${TOP_MODULE}/route

source -echo $FILLER_HELPER

connect_pg_net -net VDD [get_pins -hierarchical */VDD]
connect_pg_net -net VSS [get_pins -hierarchical */VSS]

redirect -tee -file "$REPORT_DIR/filler_legality.rpt"        { check_legality }
redirect -tee -file "$REPORT_DIR/filler_routes.rpt"          { check_routes }
redirect -tee -file "$REPORT_DIR/filler_pg_connectivity.rpt" { check_pg_connectivity }
redirect -tee -file "$REPORT_DIR/filler_pg_drc.rpt"          { check_pg_drc }

set_propagated_clock [all_clocks]
redirect -file "$REPORT_DIR/final_setup_timing.rpt" { report_timing -delay_type max -max_paths 20 }
redirect -file "$REPORT_DIR/final_hold_timing.rpt"  { report_timing -delay_type min -max_paths 20 }
redirect -file "$REPORT_DIR/final_qor.rpt"          { report_qor }
redirect -file "$REPORT_DIR/final_area.rpt"         { report_area }
redirect -file "$REPORT_DIR/final_power.rpt"        { report_power }
redirect -tee -file "$REPORT_DIR/final_clock_skew.rpt" { report_clock_timing -type skew -setup -nworst 10 }

save_block -as ${TOP_MODULE}/filler
save_lib

echo "DONE: Filler insertion saved as ${TOP_MODULE}/filler"
