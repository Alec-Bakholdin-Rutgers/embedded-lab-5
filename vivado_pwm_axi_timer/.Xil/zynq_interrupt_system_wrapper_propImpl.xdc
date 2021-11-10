set_property SRC_FILE_INFO {cfile:c:/lab4/vivado_pwm_axi_timer/zynq_interrupts.gen/sources_1/bd/zynq_interrupt_system/ip/zynq_interrupt_system_processing_system7_0_0/zynq_interrupt_system_processing_system7_0_0.xdc rfile:../zynq_interrupts.gen/sources_1/bd/zynq_interrupt_system/ip/zynq_interrupt_system_processing_system7_0_0/zynq_interrupt_system_processing_system7_0_0.xdc id:1 order:EARLY scoped_inst:zynq_interrupt_system_i/processing_system7_0/inst} [current_design]
set_property SRC_FILE_INFO {cfile:C:/lab4/vivado_pwm_axi_timer/zynq_interrupts.srcs/constrs_1/new/constraints.xdc rfile:../zynq_interrupts.srcs/constrs_1/new/constraints.xdc id:2} [current_design]
current_instance zynq_interrupt_system_i/processing_system7_0/inst
set_property src_info {type:SCOPED_XDC file:1 line:21 export:INPUT save:INPUT read:READ} [current_design]
set_input_jitter clk_fpga_0 0.3
current_instance
set_property src_info {type:XDC file:2 line:9 export:INPUT save:INPUT read:READ} [current_design]
set_property -dict { PACKAGE_PIN N16   IOSTANDARD LVCMOS33 } [get_ports { vslide_switches_tri_i[0] }]; #IO_L21N_T3_DQS_AD14N_35 Sch=JA1_R_N
set_property src_info {type:XDC file:2 line:10 export:INPUT save:INPUT read:READ} [current_design]
set_property -dict { PACKAGE_PIN L15   IOSTANDARD LVCMOS33 } [get_ports { vslide_switches_tri_i[1] }]; #IO_L22N_T3_AD7N_35 Sch=JA2_R_N
set_property src_info {type:XDC file:2 line:11 export:INPUT save:INPUT read:READ} [current_design]
set_property -dict { PACKAGE_PIN J16   IOSTANDARD LVCMOS33 } [get_ports { vslide_switches_tri_i[2] }]; #IO_L24N_T3_AD15N_35 Sch=JA3_R_N
set_property src_info {type:XDC file:2 line:12 export:INPUT save:INPUT read:READ} [current_design]
set_property -dict { PACKAGE_PIN J14   IOSTANDARD LVCMOS33 } [get_ports { vslide_switches_tri_i[3] }]; #IO_L20N_T3_AD6N_35 Sch=JA4_R_N
