# Selected reports

Only the reports that best demonstrate the implementation outcome are kept here. The full course run generated many intermediate reports; this repository intentionally keeps a smaller recruiter-friendly set.

## Final reports

- `final_qor.rpt` — timing summary, cell counts and netlist area
- `final_area.rpt` — final cell/area breakdown
- `final_power.rpt` — propagated-activity power estimate
- `final_setup_timing.rpt` / `final_hold_timing.rpt` — detailed timing paths
- `final_clock_skew.rpt` — post-CTS/final clock skew
- `final_route_check.rpt` — opens and routing DRC summary
- `final_pg_drc.rpt` — power-grid DRC
- `final_pg_connectivity.rpt` — VDD/VSS connectivity
- `final_legality.rpt` — placement legality
- `place_utilization.rpt` — placement utilization

`stage_qor/` contains one QoR report from each major optimization stage so the progression can be inspected directly.

> Note: the route report states that no antenna rules were defined, so antenna analysis was not performed. The repository therefore does not claim antenna-clean signoff.
