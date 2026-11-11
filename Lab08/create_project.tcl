# Vivado Project Recreation Script for Lab08_MemorySystem
# In Vivado TCL Console, cd to this folder and run: source create_project.tcl

create_project -force Lab08_MemorySystem_rebuilt ./Lab08_MemorySystem_rebuilt -part xc7a35tcpg236-1

add_files -norecurse [glob ./Lab08_MemorySystem.srcs/sources_1/new/*.v]
add_files -fileset constrs_1 -norecurse ./Lab08_MemorySystem.srcs/constrs_1/new/basys3_constraints.xdc
add_files -fileset sim_1 -norecurse ./Lab08_MemorySystem.srcs/sim_1/new/MemorySystem_tb.v

set_property top top_fsm_system [get_filesets sources_1]
set_property top MemorySystem_tb [get_filesets sim_1]
update_compile_order -fileset sources_1
update_compile_order -fileset sim_1
