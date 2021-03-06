# 
# Usage: To re-create this platform project launch xsct with below options.
# xsct /home/user/lab4/vitis_sources_lab_4/zynq_interrupt_system_wrapper_1/platform.tcl
# 
# OR launch xsct and run below command.
# source /home/user/lab4/vitis_sources_lab_4/zynq_interrupt_system_wrapper_1/platform.tcl
# 
# To create the platform in a different location, modify the -out option of "platform create" command.
# -out option specifies the output directory of the platform project.

platform create -name {zynq_interrupt_system_wrapper_1}\
-hw {/home/user/lab4/vivado_zynq_interrupts/zynq_interrupt_system_wrapper.xsa}\
-out {/home/user/lab4/vitis_sources_lab_4}

platform write
domain create -name {standalone_ps7_cortexa9_0} -display-name {standalone_ps7_cortexa9_0} -os {standalone} -proc {ps7_cortexa9_0} -runtime {cpp} -arch {32-bit} -support-app {empty_application}
platform generate -domains 
platform active {zynq_interrupt_system_wrapper_1}
domain active {zynq_fsbl}
domain active {standalone_ps7_cortexa9_0}
platform generate -quick
catch {platform remove zynq_interrupt_system_wrapper}
platform generate
platform clean
