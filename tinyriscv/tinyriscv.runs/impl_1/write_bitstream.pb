
_
Command: %s
53*	vivadotcl2.
,write_bitstream -force tinyriscv_soc_top.bitZ4-113h px� 

@Attempting to get a license for feature '%s' and/or device '%s'
308*common2
Implementation2	
xc7a35tZ17-347h px� 
o
0Got license for feature '%s' and/or device '%s'
310*common2
Implementation2	
xc7a35tZ17-349h px� 
f
,Running DRC as a precondition to command %s
1349*	planAhead2
write_bitstreamZ12-1349h px� 
>
IP Catalog is up to date.1232*coregenZ19-1839h px� 
>
Running DRC with %s threads
24*drc2
8Z23-27h px� 
�
�Missing CFGBVS and CONFIG_VOLTAGE Design Properties: Neither the CFGBVS nor CONFIG_VOLTAGE voltage property is set in the current_design.  Configuration bank voltage select (CFGBVS) must be set to VCCO or GND, and CONFIG_VOLTAGE must be set to the correct configuration voltage, in order to determine the I/O voltage support for the pins in bank 0.  It is suggested to specify these either using the 'Edit Device Properties' function in the GUI or directly in the XDC file using the following syntax:

 set_property CFGBVS value1 [current_design]
 #where value1 is either VCCO or GND

 set_property CONFIG_VOLTAGE value2 [current_design]
 #where value2 is the voltage provided to configuration bank 0

Refer to the device configuration user guide for more information.%s*DRC2
 DRC|Pin Planning8ZCFGBVS-1h px� 
�
fInput pipelining: DSP %s input %s is not pipelined. Pipelining DSP48 input will improve performance.%s*DRC2<
 "8
u_tinyriscv/u_ex/mul_temp	u_tinyriscv/u_ex/mul_temp2F
 "B
!u_tinyriscv/u_ex/mul_temp/A[29:0]u_tinyriscv/u_ex/mul_temp/A2+
 %DRC|Netlist|Instance|Pipeline|DSP48E18ZDPIP-1h px� 
�
fInput pipelining: DSP %s input %s is not pipelined. Pipelining DSP48 input will improve performance.%s*DRC2<
 "8
u_tinyriscv/u_ex/mul_temp	u_tinyriscv/u_ex/mul_temp2F
 "B
!u_tinyriscv/u_ex/mul_temp/B[17:0]u_tinyriscv/u_ex/mul_temp/B2+
 %DRC|Netlist|Instance|Pipeline|DSP48E18ZDPIP-1h px� 
�
fInput pipelining: DSP %s input %s is not pipelined. Pipelining DSP48 input will improve performance.%s*DRC2B
 ">
u_tinyriscv/u_ex/mul_temp__0	u_tinyriscv/u_ex/mul_temp__02L
 "H
$u_tinyriscv/u_ex/mul_temp__0/A[29:0]u_tinyriscv/u_ex/mul_temp__0/A2+
 %DRC|Netlist|Instance|Pipeline|DSP48E18ZDPIP-1h px� 
�
fInput pipelining: DSP %s input %s is not pipelined. Pipelining DSP48 input will improve performance.%s*DRC2B
 ">
u_tinyriscv/u_ex/mul_temp__0	u_tinyriscv/u_ex/mul_temp__02L
 "H
$u_tinyriscv/u_ex/mul_temp__0/B[17:0]u_tinyriscv/u_ex/mul_temp__0/B2+
 %DRC|Netlist|Instance|Pipeline|DSP48E18ZDPIP-1h px� 
�
fInput pipelining: DSP %s input %s is not pipelined. Pipelining DSP48 input will improve performance.%s*DRC2B
 ">
u_tinyriscv/u_ex/mul_temp__1	u_tinyriscv/u_ex/mul_temp__12L
 "H
$u_tinyriscv/u_ex/mul_temp__1/A[29:0]u_tinyriscv/u_ex/mul_temp__1/A2+
 %DRC|Netlist|Instance|Pipeline|DSP48E18ZDPIP-1h px� 
�
fInput pipelining: DSP %s input %s is not pipelined. Pipelining DSP48 input will improve performance.%s*DRC2B
 ">
u_tinyriscv/u_ex/mul_temp__1	u_tinyriscv/u_ex/mul_temp__12L
 "H
$u_tinyriscv/u_ex/mul_temp__1/B[17:0]u_tinyriscv/u_ex/mul_temp__1/B2+
 %DRC|Netlist|Instance|Pipeline|DSP48E18ZDPIP-1h px� 
�
fInput pipelining: DSP %s input %s is not pipelined. Pipelining DSP48 input will improve performance.%s*DRC2B
 ">
u_tinyriscv/u_ex/mul_temp__2	u_tinyriscv/u_ex/mul_temp__22L
 "H
$u_tinyriscv/u_ex/mul_temp__2/A[29:0]u_tinyriscv/u_ex/mul_temp__2/A2+
 %DRC|Netlist|Instance|Pipeline|DSP48E18ZDPIP-1h px� 
�
fInput pipelining: DSP %s input %s is not pipelined. Pipelining DSP48 input will improve performance.%s*DRC2B
 ">
u_tinyriscv/u_ex/mul_temp__2	u_tinyriscv/u_ex/mul_temp__22L
 "H
$u_tinyriscv/u_ex/mul_temp__2/B[17:0]u_tinyriscv/u_ex/mul_temp__2/B2+
 %DRC|Netlist|Instance|Pipeline|DSP48E18ZDPIP-1h px� 
�
�PREG Output pipelining: DSP %s output %s is not pipelined (PREG=0). Pipelining the DSP48 output will improve performance and often saves power so it is suggested whenever possible to fully pipeline this function.  If this DSP48 function was inferred, it is suggested to describe an additional register stage after this function.  If the DSP48 was instantiated in the design, it is suggested to set the PREG attribute to 1.%s*DRC2<
 "8
u_tinyriscv/u_ex/mul_temp	u_tinyriscv/u_ex/mul_temp2F
 "B
!u_tinyriscv/u_ex/mul_temp/P[47:0]u_tinyriscv/u_ex/mul_temp/P2+
 %DRC|Netlist|Instance|Pipeline|DSP48E18ZDPOP-1h px� 
�
�PREG Output pipelining: DSP %s output %s is not pipelined (PREG=0). Pipelining the DSP48 output will improve performance and often saves power so it is suggested whenever possible to fully pipeline this function.  If this DSP48 function was inferred, it is suggested to describe an additional register stage after this function.  If the DSP48 was instantiated in the design, it is suggested to set the PREG attribute to 1.%s*DRC2B
 ">
u_tinyriscv/u_ex/mul_temp__0	u_tinyriscv/u_ex/mul_temp__02L
 "H
$u_tinyriscv/u_ex/mul_temp__0/P[47:0]u_tinyriscv/u_ex/mul_temp__0/P2+
 %DRC|Netlist|Instance|Pipeline|DSP48E18ZDPOP-1h px� 
�
�PREG Output pipelining: DSP %s output %s is not pipelined (PREG=0). Pipelining the DSP48 output will improve performance and often saves power so it is suggested whenever possible to fully pipeline this function.  If this DSP48 function was inferred, it is suggested to describe an additional register stage after this function.  If the DSP48 was instantiated in the design, it is suggested to set the PREG attribute to 1.%s*DRC2B
 ">
u_tinyriscv/u_ex/mul_temp__1	u_tinyriscv/u_ex/mul_temp__12L
 "H
$u_tinyriscv/u_ex/mul_temp__1/P[47:0]u_tinyriscv/u_ex/mul_temp__1/P2+
 %DRC|Netlist|Instance|Pipeline|DSP48E18ZDPOP-1h px� 
�
�PREG Output pipelining: DSP %s output %s is not pipelined (PREG=0). Pipelining the DSP48 output will improve performance and often saves power so it is suggested whenever possible to fully pipeline this function.  If this DSP48 function was inferred, it is suggested to describe an additional register stage after this function.  If the DSP48 was instantiated in the design, it is suggested to set the PREG attribute to 1.%s*DRC2B
 ">
u_tinyriscv/u_ex/mul_temp__2	u_tinyriscv/u_ex/mul_temp__22L
 "H
$u_tinyriscv/u_ex/mul_temp__2/P[47:0]u_tinyriscv/u_ex/mul_temp__2/P2+
 %DRC|Netlist|Instance|Pipeline|DSP48E18ZDPOP-1h px� 
�
�MREG Output pipelining: DSP %s multiplier stage %s is not pipelined (MREG=0). Pipelining the multiplier function will improve performance and will save significant power so it is suggested whenever possible to fully pipeline this function.  If this multiplier was inferred, it is suggested to describe an additional register stage after this function.  If there is no registered adder/accumulator following the multiply function, two pipeline stages are suggested to allow both the MREG and PREG registers to be used.  If the DSP48 was instantiated in the design, it is suggested to set both the MREG and PREG attributes to 1 when performing multiply functions.%s*DRC2<
 "8
u_tinyriscv/u_ex/mul_temp	u_tinyriscv/u_ex/mul_temp2F
 "B
!u_tinyriscv/u_ex/mul_temp/P[47:0]u_tinyriscv/u_ex/mul_temp/P2+
 %DRC|Netlist|Instance|Pipeline|DSP48E18ZDPOP-2h px� 
�
�MREG Output pipelining: DSP %s multiplier stage %s is not pipelined (MREG=0). Pipelining the multiplier function will improve performance and will save significant power so it is suggested whenever possible to fully pipeline this function.  If this multiplier was inferred, it is suggested to describe an additional register stage after this function.  If there is no registered adder/accumulator following the multiply function, two pipeline stages are suggested to allow both the MREG and PREG registers to be used.  If the DSP48 was instantiated in the design, it is suggested to set both the MREG and PREG attributes to 1 when performing multiply functions.%s*DRC2B
 ">
u_tinyriscv/u_ex/mul_temp__0	u_tinyriscv/u_ex/mul_temp__02L
 "H
$u_tinyriscv/u_ex/mul_temp__0/P[47:0]u_tinyriscv/u_ex/mul_temp__0/P2+
 %DRC|Netlist|Instance|Pipeline|DSP48E18ZDPOP-2h px� 
�
�MREG Output pipelining: DSP %s multiplier stage %s is not pipelined (MREG=0). Pipelining the multiplier function will improve performance and will save significant power so it is suggested whenever possible to fully pipeline this function.  If this multiplier was inferred, it is suggested to describe an additional register stage after this function.  If there is no registered adder/accumulator following the multiply function, two pipeline stages are suggested to allow both the MREG and PREG registers to be used.  If the DSP48 was instantiated in the design, it is suggested to set both the MREG and PREG attributes to 1 when performing multiply functions.%s*DRC2B
 ">
u_tinyriscv/u_ex/mul_temp__1	u_tinyriscv/u_ex/mul_temp__12L
 "H
$u_tinyriscv/u_ex/mul_temp__1/P[47:0]u_tinyriscv/u_ex/mul_temp__1/P2+
 %DRC|Netlist|Instance|Pipeline|DSP48E18ZDPOP-2h px� 
�
�MREG Output pipelining: DSP %s multiplier stage %s is not pipelined (MREG=0). Pipelining the multiplier function will improve performance and will save significant power so it is suggested whenever possible to fully pipeline this function.  If this multiplier was inferred, it is suggested to describe an additional register stage after this function.  If there is no registered adder/accumulator following the multiply function, two pipeline stages are suggested to allow both the MREG and PREG registers to be used.  If the DSP48 was instantiated in the design, it is suggested to set both the MREG and PREG attributes to 1 when performing multiply functions.%s*DRC2B
 ">
u_tinyriscv/u_ex/mul_temp__2	u_tinyriscv/u_ex/mul_temp__22L
 "H
$u_tinyriscv/u_ex/mul_temp__2/P[47:0]u_tinyriscv/u_ex/mul_temp__2/P2+
 %DRC|Netlist|Instance|Pipeline|DSP48E18ZDPOP-2h px� 
U
DRC finished with %s
1905*	planAhead2
0 Errors, 17 WarningsZ12-3199h px� 
i
BPlease refer to the DRC report (report_drc) for more information.
1906*	planAheadZ12-3200h px� 
W
)Running write_bitstream with %s threads.
1750*designutils2
8Z20-2272h px� 
?
Loading data files...
1271*designutilsZ12-1165h px� 
>
Loading site data...
1273*designutilsZ12-1167h px� 
?
Loading route data...
1272*designutilsZ12-1166h px� 
?
Processing options...
1362*designutilsZ12-1514h px� 
<
Creating bitmap...
1249*designutilsZ12-1141h px� 
7
Creating bitstream...
7*	bitstreamZ40-7h px� 
V
Writing bitstream %s...
11*	bitstream2
./tinyriscv_soc_top.bitZ40-11h px� 
F
Bitgen Completed Successfully.
1606*	planAheadZ12-1842h px� 
�
�WebTalk data collection is mandatory when using a ULT device. To see the specific WebTalk data collected for your design, open the usage_statistics_webtalk.html or usage_statistics_webtalk.xml file in the implementation directory.698*projectZ1-1876h px� 
H
Releasing license: %s
83*common2
ImplementationZ17-83h px� 
�
G%s Infos, %s Warnings, %s Critical Warnings and %s Errors encountered.
28*	vivadotcl2
1302
202
02
0Z4-41h px� 
O
%s completed successfully
29*	vivadotcl2
write_bitstreamZ4-42h px� 
�
r%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s ; free physical = %s ; free virtual = %s
480*common2
write_bitstream: 2

00:00:142

00:00:162

3504.3712	
282.5162
119712
30935Z17-722h px� 


End Record