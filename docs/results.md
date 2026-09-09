# Results

## Final implementation summary

| Metric | Result |
|---|---:|
| Technology | SAED 14 nm educational PDK |
| Tool | Synopsys Fusion Compiler V-2023.12-SP3 |
| Clock period | 10.00 ns |
| Clock frequency | 100 MHz |
| Final setup WNS (`clk_i`) | **+6.98 ns** |
| Final setup TNS | **0.00 ns** |
| Setup violating paths | **0** |
| Worst detailed hold slack | **+0.03 ns** |
| Hold violations | **0** |
| Worst reported clock skew | **0.07 ns (70 ps)** |
| Placement utilization | **59.15%** |
| Leaf cells | **11,797** |
| Sequential cells | **2,319** |
| Netlist cell area | **6,532.93** |
| Open nets | **0** |
| Routing DRC violations | **0** |
| Placement legality violations | **0** |
| PG DRC | **No errors found** |
| Floating VDD/VSS wires/vias/cells | **0** |

## Optimization progression

| Stage | Setup WNS (`clk_i`) | Leaf cells | Netlist cell area |
|---|---:|---:|---:|
| Initial mapping | +6.33 ns | 11,837 | 6,399.37 |
| Logic optimization / floorplan | +7.77 ns | 11,539 | 6,553.93 |
| Placement | +6.88 ns | 11,781 | 6,452.52 |
| Clock Tree Synthesis | +6.91 ns | 11,797 | 6,528.80 |
| Routing | **+6.98 ns** | **11,797** | **6,532.93** |

## Power estimate

The final Fusion Compiler power report used propagated activity rather than a user-provided simulation trace. At the report condition of **0.71 V and 125 °C**, it estimated:

- Cell internal power: `3.70e+08 pW`
- Net switching power: `1.27e+08 pW`
- Total dynamic power: `4.98e+08 pW` ≈ **0.498 mW**
- Leakage power: `1.69e+08 pW` ≈ **0.169 mW**

These numbers should be treated as a **vectorless/propgated-activity implementation estimate**, not measured silicon power.

## Verification scope note

The final route check reports **0 open nets** and **0 routing DRC violations**. It also explicitly states that **no antenna rules were defined**, so antenna analysis was skipped. No antenna-clean claim is made here.
