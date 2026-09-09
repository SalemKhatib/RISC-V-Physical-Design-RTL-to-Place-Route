\
# ============================================================
# 07_route.tcl
# Global/detail routing and route optimization.
# ============================================================
source [file normalize [file join [file dirname [info script]] .. config project_setup.tcl]]

set ROUTE_RULES "$COURSE_ASSETS_DIR/route.tcl"
if {![file exists $ROUTE_RULES]} {
    error "Missing course-provided routing helper: $ROUTE_RULES"
}

open_lib $DESIGN_LIB
open_block ${TOP_MODULE}/clock_opt

set_parasitics_parameters -early_spec CMIN -late_spec CMAX -corners [get_corners *]
set_propagated_clock [all_clocks]

source -echo $ROUTE_RULES

redirect -tee -file "$REPORT_DIR/route_routability.rpt" { check_routability }

route_auto
route_opt

redirect -tee -file "$REPORT_DIR/route_check.rpt"           { check_routes }
redirect -tee -file "$REPORT_DIR/route_legality.rpt"        { check_legality }
redirect -tee -file "$REPORT_DIR/route_pg_connectivity.rpt" { check_pg_connectivity }
redirect -tee -file "$REPORT_DIR/route_pg_drc.rpt"          { check_pg_drc }
redirect -file "$REPORT_DIR/route_setup_timing.rpt"         { report_timing -delay_type max -max_paths 20 }
redirect -file "$REPORT_DIR/route_hold_timing.rpt"          { report_timing -delay_type min -max_paths 20 }
redirect -file "$REPORT_DIR/route_qor.rpt"                  { report_qor }
redirect -file "$REPORT_DIR/route_area.rpt"                 { report_area }
redirect -file "$REPORT_DIR/route_power.rpt"                { report_power }
redirect -tee -file "$REPORT_DIR/route_congestion.rpt"      { report_congestion }
redirect -tee -file "$REPORT_DIR/route_clock_skew.rpt"      { report_clock_timing -type skew -setup -nworst 10 }

save_block -as ${TOP_MODULE}/route
save_lib

echo "DONE: Routing saved as ${TOP_MODULE}/route"
