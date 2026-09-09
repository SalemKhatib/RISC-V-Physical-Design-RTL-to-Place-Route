# Implementation notes

## Library and parasitics

The Fusion Compiler library was built against the SAED14 educational technology using LVT, RVT and HVT reference libraries. CMIN and CMAX TLU+ data were loaded and assigned as early/late parasitic specifications.

## RTL and constraints

The supplied design was elaborated with top module `riscv_core`. The RTL and SDC are intentionally omitted from this public repository because they were provided as course inputs.

Signal routing directions used by the implementation:

- Vertical: M1, M3, M5, M7, M9
- Horizontal: M2, M4, M6, M8 (and MRDL where applicable)

## Floorplan

The automatic floorplan was configured with:

- Target core utilization: **60%**
- Core offset: **5**
- Shape: rectangular, **1:1** side ratio
- Signal pins: **M3/M4**, all four sides
- Clock pin `clk_i`: **M5**, top side

The measured post-placement utilization was **59.15%**.

## Power distribution used in the submitted run

The implementation run used a PG configuration with:

- M1 standard-cell rails
- M5 vertical straps
- M6 horizontal straps
- M7 vertical straps
- M6/M7 VDD/VSS ring
- Explicit PG vias between M5→M1, M6→M5 and M7→M6
- VDD/VSS hierarchical pin connection followed by PG connectivity and PG DRC checks

The project handout supplied a `create_pg_network.tcl` helper as course collateral. The exact helper source is therefore not redistributed here. The description above documents the configuration present in the submitted implementation without claiming the supplied helper source as original work.

## Placement

Placement used `place_opt` with high final-placement effort and high congestion effort. The run was configured to continue without a scan DEF, and selected library-cell patterns were excluded from optimization use.

## Clock Tree Synthesis

CTS was performed with `clock_opt`, followed by propagated-clock timing analysis and clock-skew reporting. The worst setup skew in the final report was **70 ps**.

## Routing

The public orchestration script invokes the course routing-rule helper and then runs:

1. `check_routability`
2. `route_auto`
3. `route_opt`
4. route, legality, PG, timing, power, congestion and clock-skew reports

The final route check found **0 open nets** and **0 routing DRC violations**.

## Filler and final checks

Filler-cell selection/insertion came from a course-provided helper. After filler insertion, the flow reconnects VDD/VSS and reruns legality, route, PG, setup/hold, QoR, area, power and clock-skew checks before saving the final checkpoint.
