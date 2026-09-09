\
# ============================================================
# 04a_power_grid.tcl
# Wrapper for the course-provided/customized PG helper used by the project.
# The helper itself is intentionally not redistributed.
# ============================================================
source [file normalize [file join [file dirname [info script]] .. config project_setup.tcl]]

set PG_HELPER "$COURSE_ASSETS_DIR/create_pg_network.tcl"
if {![file exists $PG_HELPER]} {
    error "Missing local PG helper: $PG_HELPER"
}

source -echo $PG_HELPER

echo "DONE: power-grid helper completed"
