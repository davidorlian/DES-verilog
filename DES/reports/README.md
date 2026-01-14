# Reports

This folder contains FPGA tool reports/artifacts captured during the course workflow.
They are kept for reference and are not required to run the ModelSim simulations.

## Files (typical meaning)
- `des_top_area.rep` — area / resource summary for the design.
- `des_top_utilization_placed.rpt` — placed utilization report (resource usage after placement).
- `des_top_io_placed.rpt` — IO placement / pinout-related report.
- `des_top_timing.rep` — timing report produced during the tool flow.
- `des_top_timing_summary_routed.rpt` — routed timing summary (post-routing).

Note: The exact report contents/format depend on the tool version and run configuration used when they were generated.
