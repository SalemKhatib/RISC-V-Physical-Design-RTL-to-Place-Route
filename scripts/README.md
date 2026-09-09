# Flow scripts

These are the public, path-sanitized orchestration scripts used to demonstrate the implementation flow.

The repository intentionally omits course-provided helper source code. The wrappers expect these local files in `course_assets/` (or another directory selected with `COURSE_ASSETS_DIR`):

- `create_pg_network.tcl`
- `insert_boundary_and_tap_cells.tcl`
- `route.tcl`
- `filler.tcl`

The public flow is therefore **not fully runnable from this repository alone**. It is intended to document the student's physical-design work without redistributing course collateral or proprietary PDK content.
