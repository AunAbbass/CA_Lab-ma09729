# Lab 5 - group design (top_system / state_controller / countdown_unit)

Open: Vivado > Tools > Run Tcl Script... > create_project.tcl, then Run Simulation.
- Simulation top: tb_top_system (as in the report). Set tb_report_cases as top to see the
  three test cases (switch 4, switch 13, reset mid-count) from the report's waveforms.
- Board: sw = switches, btnC = reset. The seven-segment (rightmost digit) shows the count.

Code from the report is used as shown. switches.v, leds.v and seg7_decoder.v were not
in the report, so they were written to match the ports used by top_system.v.
NOTE: the count tick is every 8 clocks (3-bit divider), i.e. ~12.5 MHz steps on the board,
and the controller restarts immediately if a switch is still on after reaching 0.
