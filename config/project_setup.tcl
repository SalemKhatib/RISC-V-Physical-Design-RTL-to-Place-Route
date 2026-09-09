\
# ============================================================
# Public project configuration
# ============================================================
# This repository intentionally does not redistribute the course RTL,
# SDC, helper scripts, or the SAED14 PDK. Point these variables at an
# authorized local installation before running the flow.

set REPO_ROOT [file normalize [file join [file dirname [info script]] ..]]

proc env_or_default {name default_value} {
    if {[info exists ::env($name)] && $::env($name) ne ""} {
        return $::env($name)
    }
    return $default_value
}

set PROJECT_ROOT      [env_or_default PROJECT_ROOT $REPO_ROOT]
set WORK_DIR          "$PROJECT_ROOT/work"
set REPORT_DIR        "$PROJECT_ROOT/reports"
set DESIGN_LIB        "$WORK_DIR/riscv.dlib"
set TOP_MODULE        "riscv_core"
set RTL_DIR           "$PROJECT_ROOT/rtl"
set SDC_FILE          "$PROJECT_ROOT/constraints/riscv.sdc"
set COURSE_ASSETS_DIR [env_or_default COURSE_ASSETS_DIR "$PROJECT_ROOT/course_assets"]

# Set SAED14_ROOT to the authorized SAED14 EDK installation.
# Example in a university environment:
#   export SAED14_ROOT=/path/to/SAED14_EDK
if {![info exists ::env(SAED14_ROOT)] || $::env(SAED14_ROOT) eq ""} {
    error "SAED14_ROOT is not set. Point it to your authorized SAED14 EDK installation."
}
set SAED14_ROOT $::env(SAED14_ROOT)

set TECH_FILE "$SAED14_ROOT/SAED14nm_EDK_TECH_DATA/tf/saed14nm_1p9m.tf"
set REF_LIBS [list \
    "$SAED14_ROOT/SAED14nm_EDK_STD_LVT/ndm/saed14lvt_base_frame_timing.ndm" \
    "$SAED14_ROOT/SAED14nm_EDK_STD_RVT/ndm/saed14rvt_base_frame_timing.ndm" \
    "$SAED14_ROOT/SAED14nm_EDK_STD_HVT/ndm/saed14hvt_base_frame_timing.ndm" \
]
set TLUP_MAX "$SAED14_ROOT/SAED14nm_EDK_TECH_DATA/tlup/saed14nm_1p9m_Cmax.tlup"
set TLUP_MIN "$SAED14_ROOT/SAED14nm_EDK_TECH_DATA/tlup/saed14nm_1p9m_Cmin.tlup"

file mkdir $WORK_DIR
file mkdir $REPORT_DIR
