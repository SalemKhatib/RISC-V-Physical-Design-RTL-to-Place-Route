\
# ============================================================
# 09_final_status.tcl
# Final timing, physical verification, QoR, area and power reports.
# ============================================================
source [file normalize [file join [file dirname [info script]] .. config project_setup.tcl]]

open_lib $DESIGN_LIB
open_block ${TOP_MODULE}/filler

set_parasitics_parameters -early_spec CMIN -late_spec CMAX -corners [get_corners *]
set_propagated_clock [all_clocks]

redirect -file "$REPORT_DIR/final_timing.rpt" {
    puts "============================================================"
    puts "FINAL SETUP TIMING"
    puts "============================================================"
    report_timing -delay_type max -max_paths 20
    puts ""
    puts "============================================================"
    puts "FINAL HOLD TIMING"
    puts "============================================================"
    report_timing -delay_type min -max_paths 20
}

redirect -tee -file "$REPORT_DIR/final_clock_skew.rpt"      { report_clock_timing -type skew -setup -nworst 10 }
redirect -tee -file "$REPORT_DIR/final_pg_drc.rpt"          { check_pg_drc }
redirect -tee -file "$REPORT_DIR/final_pg_connectivity.rpt" { check_pg_connectivity }
redirect -tee -file "$REPORT_DIR/final_route_check.rpt"     { check_routes }
redirect -tee -file "$REPORT_DIR/final_legality.rpt"        { check_legality }
redirect -file "$REPORT_DIR/final_timing_check.rpt"         { check_timing }
redirect -file "$REPORT_DIR/final_qor.rpt"                  { report_qor }
redirect -file "$REPORT_DIR/final_area.rpt"                 { report_area }
redirect -file "$REPORT_DIR/final_power.rpt"                { report_power }

save_block -as ${TOP_MODULE}/final
save_lib

echo "DONE: Final design saved as ${TOP_MODULE}/final"
echo "DONE: Final reports generated in $REPORT_DIR"
