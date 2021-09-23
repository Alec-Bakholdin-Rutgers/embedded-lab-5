# 
# Usage: To re-create this platform project launch xsct with below options.
# xsct /home/user/lab-2-Alec-Bakholdin-Rutgers/interrupt_counter/interrupt_counter_2/platform.tcl
# 
# OR launch xsct and run below command.
# source /home/user/lab-2-Alec-Bakholdin-Rutgers/interrupt_counter/interrupt_counter_2/platform.tcl
# 
# To create the platform in a different location, modify the -out option of "platform create" command.
# -out option specifies the output directory of the platform project.

platform create -name {interrupt_counter_2}\
-hw {/home/user/lab-2-Alec-Bakholdin-Rutgers/zynq_interrupts/zynq_interrupt_system_wrapper.xsa}\
-proc {ps7_cortexa9_0} -os {standalone} -out {/home/user/lab-2-Alec-Bakholdin-Rutgers/interrupt_counter}

platform write
platform generate -domains 
platform active {interrupt_counter_2}
catch {platform remove interrupt_counter_2}
platform write
