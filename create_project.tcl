# Vivado: Tools > Run Tcl Script... > pick this file
# (or batch:  vivado -mode batch -source create_project.tcl)
set proj_dir [file normalize [file dirname [info script]]]
create_project lab5_group $proj_dir/vivado -part xc7a35tcpg236-1 -force
set_property target_language Verilog [current_project]

add_files -norecurse [list \
  $proj_dir/src/top_system.v $proj_dir/src/state_controller.v \
  $proj_dir/src/countdown_unit.v $proj_dir/src/switches.v \
  $proj_dir/src/leds.v $proj_dir/src/seg7_decoder.v]
add_files -fileset constrs_1 -norecurse $proj_dir/constr/basys3.xdc
add_files -fileset sim_1 -norecurse [list $proj_dir/sim/tb_top_system.v $proj_dir/sim/tb_report_cases.v]
set_property top top_system [get_filesets sources_1]
set_property top tb_top_system [get_filesets sim_1]
update_compile_order -fileset sources_1

launch_runs synth_1 -jobs 4
wait_on_run synth_1
open_run synth_1
report_timing_summary -file $proj_dir/timing_summary.rpt
puts "Synthesis done. See timing_summary.rpt for WNS."
# Uncomment for the on-board part (Task 4):
# launch_runs impl_1 -to_step write_bitstream -jobs 4
# wait_on_run impl_1
