# Source provenance and redistribution policy

This repository separates **student-authored physical-design orchestration/documentation** from **course-provided inputs and helper collateral**.

## Not redistributed

The course project handout identifies the following as supplied project material, so they are intentionally omitted:

### RTL
- `riscv_core_all.v`
- `riscv_defs.v`

### Constraint file
- `riscv.sdc`

### Helper scripts
- `create_pg_network.tcl`
- `route.tcl`
- `insert_boundary_and_tap_cells.tcl`
- `filler.tcl`

### Technology collateral
- SAED14 technology file
- SAED14 NDM reference libraries
- TLU+ parasitic files

The course assignment PDF itself is also not redistributed.

## Included

This repository includes:

- Path-sanitized flow/orchestration Tcl scripts
- Project-specific floorplan, placement, CTS, routing and reporting configuration written around the supplied inputs
- Selected generated reports from the completed implementation
- Documentation and results summaries

The goal is to demonstrate the physical-design work while avoiding publication of source material that was supplied by the course staff or belongs to the PDK/tool environment.
