# 
# Usage: To re-create this platform project launch xsct with below options.
# xsct /home/user/lab4/vitis_sources_lab_4/zynq_interrupt_system_wrapper/platform.tcl
# 
# OR launch xsct and run below command.
# source /home/user/lab4/vitis_sources_lab_4/zynq_interrupt_system_wrapper/platform.tcl
# 
# To create the platform in a different location, modify the -out option of "platform create" command.
# -out option specifies the output directory of the platform project.

platform create -name {zynq_interrupt_system_wrapper}\
-hw {/home/user/lab4/vivado_zynq_interrupts/zynq_interrupt_system_wrapper.xsa}\
-out {/home/user/lab4/vitis_sources_lab_4}

platform write
domain create -name {standalone_ps7_cortexa9_0} -display-name {standalone_ps7_cortexa9_0} -os {standalone} -proc {ps7_cortexa9_0} -runtime {cpp} -arch {32-bit} -support-app {empty_application}
platform generate -domains 
platform active {zynq_interrupt_system_wrapper}
domain active {zynq_fsbl}
domain active {standalone_ps7_cortexa9_0}
platform generate -quick
platform generate
platform clean
platform generate
platform active {zynq_interrupt_system_wrapper}
platform config -updatehw {/home/user/lab-5/vivado_zynq_interrupts/zynq_interrupt_system_wrapper.xsa}
platform generate
platform config -updatehw {/home/user/lab-5/vivado_zynq_interrupts/zynq_interrupt_system_wrapper.xsa}
platform generate -domains 
platform generate
platform generate -domains standalone_ps7_cortexa9_0 
platform generate -domains standalone_ps7_cortexa9_0 
platform config -updatehw {/home/user/lab4/vivado_zynq_interrupts/zynq_interrupt_system_wrapper.xsa}
