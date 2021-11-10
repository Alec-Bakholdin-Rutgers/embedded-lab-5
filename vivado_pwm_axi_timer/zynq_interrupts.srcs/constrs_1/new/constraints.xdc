set_property PACKAGE_PIN M14 [get_ports {pwm0_0}]
set_property IOSTANDARD LVCMOS33 [get_ports {pwm0_0}]

##Pmod Header JA (XADC)
set_property -dict { PACKAGE_PIN N15   IOSTANDARD LVCMOS33 } [get_ports { vpush_buttons_tri_i[0] }]; #IO_L21P_T3_DQS_AD14P_35 Sch=JA1_R_p
set_property -dict { PACKAGE_PIN L14   IOSTANDARD LVCMOS33 } [get_ports { vpush_buttons_tri_i[1] }]; #IO_L22P_T3_AD7P_35 Sch=JA2_R_P
set_property -dict { PACKAGE_PIN K16   IOSTANDARD LVCMOS33 } [get_ports { vpush_buttons_tri_i[2] }]; #IO_L24P_T3_AD15P_35 Sch=JA3_R_P
set_property -dict { PACKAGE_PIN K14   IOSTANDARD LVCMOS33 } [get_ports { vpush_buttons_tri_i[3] }]; #IO_L20P_T3_AD6P_35 Sch=JA4_R_P
set_property -dict { PACKAGE_PIN N16   IOSTANDARD LVCMOS33 } [get_ports { vslide_switches_tri_i[0] }]; #IO_L21N_T3_DQS_AD14N_35 Sch=JA1_R_N
set_property -dict { PACKAGE_PIN L15   IOSTANDARD LVCMOS33 } [get_ports { vslide_switches_tri_i[1] }]; #IO_L22N_T3_AD7N_35 Sch=JA2_R_N
set_property -dict { PACKAGE_PIN J16   IOSTANDARD LVCMOS33 } [get_ports { vslide_switches_tri_i[2] }]; #IO_L24N_T3_AD15N_35 Sch=JA3_R_N
set_property -dict { PACKAGE_PIN J14   IOSTANDARD LVCMOS33 } [get_ports { vslide_switches_tri_i[3] }]; #IO_L20N_T3_AD6N_35 Sch=JA4_R_N