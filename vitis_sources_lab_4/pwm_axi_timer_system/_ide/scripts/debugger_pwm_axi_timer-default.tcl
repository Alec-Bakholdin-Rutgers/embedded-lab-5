# Usage with Vitis IDE:
# In Vitis IDE create a Single Application Debug launch configuration,
# change the debug type to 'Attach to running target' and provide this 
# tcl script in 'Execute Script' option.
# Path of this script: /home/user/lab4/vitis_sources_lab_4/pwm_axi_timer_system/_ide/scripts/debugger_pwm_axi_timer-default.tcl
# 
# 
# Usage with xsct:
# To debug using xsct, launch xsct and run below command
# source /home/user/lab4/vitis_sources_lab_4/pwm_axi_timer_system/_ide/scripts/debugger_pwm_axi_timer-default.tcl
# 
connect -url tcp:127.0.0.1:3121
targets -set -nocase -filter {name =~"APU*"}
rst -system
after 3000
targets -set -filter {jtag_cable_name =~ "Digilent Zybo 210279A79236A" && level==0 && jtag_device_ctx=="jsn-Zybo-210279A79236A-13722093-0"}
fpga -file /home/user/lab4/vitis_sources_lab_4/pwm_axi_timer/_ide/bitstream/zynq_interrupt_system_wrapper.bit
targets -set -nocase -filter {name =~"APU*"}
loadhw -hw /home/user/lab4/vitis_sources_lab_4/zynq_interrupt_system_wrapper/export/zynq_interrupt_system_wrapper/hw/zynq_interrupt_system_wrapper.xsa -mem-ranges [list {0x40000000 0xbfffffff}] -regs
configparams force-mem-access 1
targets -set -nocase -filter {name =~"APU*"}
source /home/user/lab4/vitis_sources_lab_4/pwm_axi_timer/_ide/psinit/ps7_init.tcl
ps7_init
ps7_post_config
targets -set -nocase -filter {name =~ "*A9*#0"}
dow /home/user/lab4/vitis_sources_lab_4/pwm_axi_timer/Debug/pwm_axi_timer.elf
configparams force-mem-access 0
targets -set -nocase -filter {name =~ "*A9*#0"}
con
