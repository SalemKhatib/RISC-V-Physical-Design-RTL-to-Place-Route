\
# ============================================================
# 06_clock_opt.tcl
# Clock Tree Synthesis and post-CTS checks.
# ============================================================
source [file normalize [file join [file dirname [info script]] .. config project_setup.tcl]]

open_lib $DESIGN_LIB
open_block ${TOP_MODULE}/place_opt

set_parasitics_parameters -early_spec CMIN -late_spec CMAX -corners [get_corners *]

clock_opt
set_propagated_clock [all_clocks]

redirect -tee -file "$REPORT_DIR/clock_skew.rpt" { report_clock_timing -type skew -setup -nworst 10 }
redirect -file "$REPORT_DIR/clock_setup_timing.rpt" { report_timing -delay_type max -max_paths 20 }
redirect -file "$REPORT_DIR/clock_hold_timing.rpt"  { report_timing -delay_type min -max_paths 20 }
redirect -file "$REPORT_DIR/clock_qor.rpt"          { report_qor }
redirect -file "$REPORT_DIR/clock_area.rpt"         { report_area }
redirect -file "$REPORT_DIR/clock_power.rpt"        { report_power }
redirect -tee -file "$REPORT_DIR/clock_legality.rpt"        { check_legality }
redirect -tee -file "$REPORT_DIR/clock_pg_connectivity.rpt" { check_pg_connectivity }
redirect -tee -file "$REPORT_DIR/clock_pg_drc.rpt"          { check_pg_drc }

save_block -as ${TOP_MODULE}/clock_opt
save_lib

echo "DONE: Clock Tree Synthesis saved as ${TOP_MODULE}/clock_opt"
