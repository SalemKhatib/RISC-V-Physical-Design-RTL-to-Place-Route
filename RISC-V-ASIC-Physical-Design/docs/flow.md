# Physical-design flow

```mermaid
flowchart LR
    A[Course-provided RTL + SDC] --> B[Build FC library]
    B --> C[RTL read / elaborate / link]
    C --> D[Initial mapping]
    D --> E[Logic optimization + floorplan]
    E --> F[Boundary + TAP cells]
    F --> G[Power grid]
    G --> H[Placement + optimization]
    H --> I[Clock Tree Synthesis]
    I --> J[Routing + route optimization]
    J --> K[Filler insertion]
    K --> L[Final timing / PG / route / legality checks]
```

## Checkpoints

| Stage | Saved Fusion Compiler block |
|---|---|
| RTL read | `riscv_core/rtl_read` |
| Initial mapping | `riscv_core/initial_map` |
| Floorplan | `riscv_core/floorplan` |
| Boundary/TAP | `riscv_core/floorplan_tap` |
| Power grid | `riscv_core/floorplan_pg_corrected` |
| Placement | `riscv_core/place_opt` |
| CTS | `riscv_core/clock_opt` |
| Routing | `riscv_core/route` |
| Filler | `riscv_core/filler` |
| Final | `riscv_core/final` |

The checkpoint-based organization made it possible to inspect QoR after each stage and rerun later stages without rebuilding the complete implementation from RTL.
