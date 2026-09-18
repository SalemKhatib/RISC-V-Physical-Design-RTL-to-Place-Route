# RISC-V ASIC Physical Design

Full RTL-to-routed physical implementation of a **RISC-V processor core** using **Synopsys Fusion Compiler** and the **SAED 14 nm educational technology library**.

The project covers the main ASIC implementation stages from RTL synthesis through floorplanning, power planning, placement, Clock Tree Synthesis (CTS), routing, filler insertion, and final timing/physical verification.

The RISC-V RTL, timing constraints, technology libraries, and several helper scripts were provided as part of the course environment. This repository focuses on the **physical-design flow, automation, implementation, and analysis performed during the project**.

---

## Final Results

| Metric | Result |
|---|---:|
| Technology | **SAED 14 nm** |
| Physical Design Tool | **Synopsys Fusion Compiler** |
| Target Clock | **100 MHz (10 ns)** |
| Final Setup WNS | **+6.98 ns** |
| Final Setup TNS | **0.00 ns** |
| Setup Violations | **0** |
| Worst Reported Hold Slack | **+0.03 ns** |
| Worst Clock Skew | **70 ps** |
| Placement Utilization | **59.15%** |
| Leaf Cells | **11,797** |
| Cell Area | **6,532.93** |
| Open Nets | **0** |
| Routing DRC Violations | **0** |
| Placement Legality Violations | **0** |
| Floating PG Connections | **0** |
| Power-Grid DRC | **Clean** |

### Final Implementation Status

- ✅ Setup timing closed
- ✅ Hold timing clean
- ✅ Clock tree implemented
- ✅ Power grid implemented
- ✅ Placement legal
- ✅ Routing completed
- ✅ 0 open nets
- ✅ 0 routing DRC violations
- ✅ Power/Ground connectivity clean
<img width="498" height="494" alt="layoutt" src="https://github.com/user-attachments/assets/45c7f1dd-0058-4513-bc14-ec5552f48f42" />

---

## What I Implemented

My work focused on building and automating the physical-design flow around the supplied RISC-V RTL.

The implementation included:

- Fusion Compiler design-library and technology setup
- RTL and SDC import
- Design linking
- Initial synthesis and technology mapping
- Logic optimization
- Floorplanning
- Boundary and TAP-cell insertion
- Power-grid generation and verification
- Placement and placement optimization
- Congestion and utilization analysis
- Clock Tree Synthesis
- Clock-skew analysis
- Routing and route optimization
- Filler-cell insertion
- Setup and hold timing analysis
- Area reporting
- Power estimation
- Power/Ground connectivity verification
- PG DRC verification
- Placement legality checks
- Routing checks
- Stage-by-stage Quality of Results (QoR) analysis

---

## ASIC Implementation Flow

```mermaid
flowchart LR
    A[Provided RTL + SDC] --> B[Library Setup]
    B --> C[Synthesis]
    C --> D[Floorplanning]
    D --> E[Power Planning]
    E --> F[Placement]
    F --> G[Clock Tree Synthesis]
    G --> H[Routing]
    H --> I[Filler Cells]
    I --> J[Final Verification]
```

The flow was divided into separate Tcl stages, allowing intermediate Fusion Compiler design checkpoints and reports to be generated throughout the implementation process.

---

## Tools & Technology

| Category | Technology |
|---|---|
| Physical Design | **Synopsys Fusion Compiler** |
| Technology Node | **SAED 14 nm educational PDK** |
| Design | **RISC-V processor core** |
| RTL | Verilog |
| Constraints | SDC |
| Automation | Tcl |
| Timing Analysis | Static Timing Analysis |
| Parasitic Modeling | CMIN / CMAX TLU+ |
| Standard Cells | LVT / RVT / HVT |

---

# Implementation Details

## 1. Technology and Library Setup

The implementation uses the **SAED 14 nm educational technology environment**.

The Fusion Compiler design library is constructed using the provided technology file and standard-cell reference libraries.

Multiple threshold-voltage libraries are available:

- LVT
- RVT
- HVT

Parasitic extraction data is provided through **TLU+ models** for minimum and maximum RC conditions.

The project setup is automated through Tcl configuration scripts rather than relying on manual Fusion Compiler commands.

---

## 2. RTL Import and Synthesis

The supplied RISC-V RTL is read and linked inside Fusion Compiler together with the provided SDC timing constraints.

The design is then synthesized and mapped to the SAED14 standard-cell libraries.

Reports are generated after synthesis to evaluate:

- Timing
- Cell count
- Area
- Design QoR

The initial mapped design achieved positive setup slack before physical implementation.

---

## 3. Floorplanning

An automatic floorplan was generated with a target core utilization of approximately:

**60%**

The floorplanning stage included:

- Core/die generation
- Pin constraints
- Placement preparation
- Boundary-cell insertion
- TAP-cell insertion
- Power-grid preparation

The final placement utilization after physical optimization was:

**59.15%**

---

## 4. Power Planning

A multi-layer Power Delivery Network (PDN) was implemented for **VDD** and **VSS**.

The power network included:

- Standard-cell power rails
- Higher-metal power straps
- Power rings
- Power/Ground via connections
- Core power distribution

Power routing uses several metal layers to distribute current across the design.

Final PG verification reported:

- **0 floating VDD/VSS connections**
- **No PG DRC errors**

---

## 5. Placement

Standard cells were placed and optimized using Fusion Compiler's placement optimization flow.

The stage focused on balancing:

- Timing
- Congestion
- Density
- Cell legality
- Area

Final placement utilization:

**59.15%**

Final legality verification reported:

**0 placement legality violations**

---

## 6. Clock Tree Synthesis

Clock Tree Synthesis was performed after placement.

CTS introduced the physical clock distribution network and optimized clock delivery to the sequential elements.

The clock network was analyzed for:

- Clock latency
- Clock skew
- Setup timing
- Hold timing

Worst reported final clock skew:

**70 ps**

The design remained timing-clean after CTS.

---

## 7. Routing

Signal routing was completed after clock-tree implementation.

The routing stage included:

- Global routing
- Detailed routing
- Route optimization
- Timing optimization
- Routing verification

Final routing checks reported:

- **0 open nets**
- **0 routing DRC violations**

This indicates that the routed design completed without reported routing connectivity or design-rule violations.

---

## 8. Filler Cell Insertion

Filler cells were inserted after routing to complete standard-cell rows and maintain continuity of:

- Well structures
- Power rails
- Physical manufacturing requirements

Final verification was then performed on the completed implementation.

---

# QoR Through the Physical Design Flow

One of the goals of the project was to track how implementation stages affected timing, area, and design complexity.

| Stage | Setup WNS | Leaf Cells | Cell Area |
|---|---:|---:|---:|
| Initial Mapping | +6.33 ns | 11,837 | 6,399.37 |
| Logic Optimization / Floorplan | +7.77 ns | 11,539 | 6,553.93 |
| Placement | +6.88 ns | 11,781 | 6,452.52 |
| Clock Tree Synthesis | +6.91 ns | 11,797 | 6,528.80 |
| Routing | **+6.98 ns** | **11,797** | **6,532.93** |

The design maintained **positive setup slack throughout the implementation flow**.

After routing, the final design achieved:

- **Setup WNS: +6.98 ns**
- **Setup TNS: 0.00 ns**
- **Setup violations: 0**

---

# Timing Results

## Setup Timing

Final setup timing:

```text
WNS = +6.98 ns
TNS = 0.00 ns
Violating paths = 0
```

The target clock period was:

```text
10 ns
```

corresponding to a target frequency of:

```text
100 MHz
```

---

## Hold Timing

The final detailed hold analysis reported a worst hold slack of approximately:

```text
+0.03 ns
```

with no reported hold violations.

---

# Clock Results

Worst reported clock skew:

```text
0.07 ns
```

or approximately:

```text
70 ps
```

The clock network was successfully propagated and analyzed after CTS.

---

# Area and Cell Count

Final routed implementation:

```text
Leaf Cells : 11,797
Cell Area  : 6,532.93
```

The cell count increased slightly during the physical stages as Fusion Compiler introduced cells required for physical implementation and timing optimization.

---

# Power Estimate

The final Fusion Compiler power report estimated approximately:

| Component | Power |
|---|---:|
| Dynamic Power | **0.498 mW** |
| Leakage Power | **0.169 mW** |

These values are **tool-generated implementation estimates** and should not be interpreted as post-silicon measured power.

---

# Physical Verification

Final implementation checks produced the following results:

| Check | Result |
|---|---|
| Open Nets | **0** |
| Routing DRC | **0 violations** |
| Placement Legality | **0 violations** |
| Floating PG Connections | **0** |
| PG DRC | **Clean** |
| Setup Timing | **PASS** |
| Hold Timing | **PASS** |

---

# Repository Structure

```text
.
├── README.md
├── NOTICE.md
│
├── config/
│   └── project_setup.tcl
│
├── scripts/
│   ├── 00_build_lib.tcl
│   ├── 01_read_rtl_sdc.tcl
│   ├── 02_initial_synthesis.tcl
│   ├── 03_logic_opto_floorplan.tcl
│   ├── 04_boundary_tap.tcl
│   ├── 04a_power_grid.tcl
│   ├── 05_place_opt.tcl
│   ├── 06_clock_opt.tcl
│   ├── 07_route.tcl
│   ├── 08_filler.tcl
│   └── 09_final_status.tcl
│
├── reports/
│   ├── final_qor.rpt
│   ├── final_setup_timing.rpt
│   ├── final_hold_timing.rpt
│   ├── final_clock_skew.rpt
│   ├── final_route_check.rpt
│   ├── final_pg_drc.rpt
│   ├── final_pg_connectivity.rpt
│   ├── final_power.rpt
│   └── stage_qor/
│
├── docs/
│   ├── flow.md
│   ├── results.md
│   ├── implementation_notes.md
│   └── source_provenance.md
│
├── rtl/
│   └── README.md
│
└── constraints/
    └── README.md
```

---

# Selected Reports

The repository includes selected Fusion Compiler reports used to evaluate the final design.

### Timing

- [`final_setup_timing.rpt`](reports/final_setup_timing.rpt)
- [`final_hold_timing.rpt`](reports/final_hold_timing.rpt)
- [`final_clock_skew.rpt`](reports/final_clock_skew.rpt)

### Quality of Results

- [`final_qor.rpt`](reports/final_qor.rpt)

### Physical Verification

- [`final_route_check.rpt`](reports/final_route_check.rpt)
- [`final_pg_drc.rpt`](reports/final_pg_drc.rpt)
- [`final_pg_connectivity.rpt`](reports/final_pg_connectivity.rpt)

### Power

- [`final_power.rpt`](reports/final_power.rpt)

Additional stage-by-stage reports are available under:

```text
reports/stage_qor/
```

---

# Source Ownership

This repository intentionally does **not redistribute course-provided or licensed design material**.

The following were provided as project inputs and are therefore excluded:

- `riscv_core_all.v`
- `riscv_defs.v`
- `riscv.sdc`
- SAED14 technology files
- SAED14 standard-cell libraries
- TLU+ files
- Selected course-provided helper Tcl scripts

The course project specification identifies the RISC-V RTL and `riscv.sdc` as supplied project inputs and also provides helper scripts for parts of the implementation flow.

This repository instead focuses on my:

- Physical-design flow
- Fusion Compiler automation
- Implementation configuration
- Physical-design decisions
- QoR analysis
- Timing analysis
- Physical-verification results
- Project documentation

See:

[`docs/source_provenance.md`](docs/source_provenance.md)

for additional information.

---

# Reproducibility

This repository is **not completely self-contained** because the following licensed/course materials cannot be redistributed:

- RISC-V project RTL
- Project SDC
- SAED14 PDK
- SAED14 standard-cell libraries
- Course helper scripts

The Tcl flow and reports are provided to demonstrate the implementation methodology and automation used during the project.

Running the complete flow requires access to a compatible Synopsys Fusion Compiler and SAED14 environment.

---

# Signoff Note

The available routing report indicates that antenna rules were not defined in the supplied technology environment, so antenna verification was not performed as part of the reported checks.

Therefore, the verification claims in this repository are limited to checks supported by the generated Fusion Compiler reports, including:

- Setup timing
- Hold timing
- Clock skew
- Routing connectivity
- Routing DRC
- Placement legality
- Power/Ground connectivity
- Power/Ground DRC

This project is an **educational ASIC physical-design implementation**, not a foundry tapeout.

---

# Project Summary

This project provided hands-on experience with a complete modern ASIC physical-design flow using Synopsys Fusion Compiler.

The final RISC-V implementation successfully progressed through:

**Synthesis → Floorplanning → Power Planning → Placement → CTS → Routing → Physical Verification**

while achieving:

- **+6.98 ns final setup WNS**
- **0 setup violations**
- **0 hold violations**
- **70 ps worst clock skew**
- **59.15% placement utilization**
- **0 open nets**
- **0 routing DRC violations**
- **Clean PG connectivity**
- **Clean placement legality**

The project strengthened my experience in **ASIC Physical Design, Static Timing Analysis, Tcl automation, clock-tree implementation, power planning, routing, and physical verification**.
