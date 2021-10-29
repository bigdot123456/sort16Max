

export  NOVAS_HOME=/eda/snps/verdi/Verdi_N-2017.12-SP2
export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:$NOVAS_HOME/share/PLI/lib/LINUX64:$NOVAS_HOME/share/PLI/IUS/LINUX64/boot" 

xmverilog  +define+FSDB_DUMP ./lib/tb/timescale.v -f 1.f -l 1.log +libext+.v +incdir+./lib/tb  -access +rwc -loadpli1 debpli:novas_pli_boot

verdi -sv +define+FSDB_DUMP ./lib/tb/timescale.v -f 1.f -l 1.log +libext+.v +incdir+./lib/tb  -ssf ./dump.fsdb   -nologo 


xmverilog +linedebug +gui  ./lib/tb/timescale.v -f 1.f -l 1.log +libext+.v +incdir+./lib/tb  +define+FSDB_DUMP -access +rwc -loadpli1 debpli:novas_pli_boot

iverilog -f 1.f -l 1.log -I ./lib/tb

irun -access +rwc -loadpli1 debpli:novas_pli_boot -f XXXXXXX.f

Use IUS PLI boot method while FSDB dumping commands specified in Tcl
format, cmd.tcl.
Using "ncvlog", "ncelab", "ncsim" trilogy:
> ncvlog top.v
> ncelab top -access +r -loadpli1 debpli:novas_pli_boot
> ncsim top -i cmd.tcl
Using "ncverilog":
> ncverilog top.v -access +r +tcl+cmd.tcl -loadpli1
debpli:novas_pli_boot
Using "irun":
> irun top.v -access +r +tcl+cmd.tcl -loadpli1
debpli:novas_pli_boot




ncvlog -f verilog.f
ncvhdl -messages -smartorder -V93 -file vhdl.f
ncshell -import verilog -into vhdl -GENERIC worklib.CORE1553BRM
ncelab  WORKLIB.TB_VERIF
ncsim  WORKLIB.TB_VERIF

vhdlcom -93 -smartorder -smartscript vhdl.scr -fv vhdl.f
vericom -2001 -f verilog.f
rm novas.rc
debussy -lib work -smartscript TB_VERIF.scr -top TB_VERIF -ssf TB_VERIF.fsdb -sswr TB_VERIF.rc

vericom -2001 -f test_Cortex_1553B.f
rm novas.rc
debussy -lib work -top Cortex_1553B_tb -ssf dump.fsdb -sswr Cortex_1553B_tb.rc -smartscript Cortex_1553B_tb.scr

ncvlog -f verilog.f -MESSAGES -LINEDEBUG -UPDATE
ncvhdl -smartorder -v93 -file vhdl.f -LINEDEBUG -UPDATE
ncshell -import verilog -into vhdl -GENERIC CORE1553BRM
ncelab WORKLIB.TB_VERIF:TB
ncsim  +linedebug -GUI WORKLIB.TB_VERIF:TB


nlint -gui -2001 -f ../../design/smbus/smbus.f -INCDIR ../../lib -INCDIR ../../lib/soc_bridge
vericom -2001 -f ../../sim/smbus/smbus_tb.f  -f ../../design/smbus/smbus.f -INCDIR ../../lib -INCDIR ../../lib/soc_bridge

rm -f -r INCA_libs
ncvlog -f ../../design/smbus/smbus.f -INCDIR ../../lib -INCDIR ../../lib/soc_bridge
ncvlog -f ../../sim/smbus/smbus_tb.f -INCDIR ../../lib -INCDIR ../../lib/soc_bridge
ncelab WORKLIB.Cortex_1553B_tb
ncsim WORKLIB.Cortex_1553B_tb

vlib work
vlog -f verilog.f
vcom -f vhdl.f
vsim TB_VERIF -c -do "run -all;quit"


vhdlcom -93 -smartorder -smartscript rt_vhdl.scr -fv rt_vhdl.f
vericom -2001 -f rt_core.f
rm novas.rc
debussy -lib work -smartscript TB_VERIF.scr -top TB_VERIF -sswr TB_VERIF.rc

vsim -t 1ps TB_VERIF -c -do "run -all;quit"

vhdlcom -93 igloo.vhd -lib igloo
vhdlcom -93 novas.vhd
vhdlcom -93 -smartorder -smartscript vhdl.scr -fv vhdl_all.f

vcom -work igloo igloo.vhd
vcom novas.vhd
vcom coreparameters.vhd
vcom -93 -f vhdl_all.f
vsim -c TB_VERIF -do "run -all;quit"


; List of dynamically loaded objects for Verilog PLI applications
; Veriuser = veriuser.sl
; use by verilog
;Veriuser = novas.dll
; use by vhdl
Veriuser = novas_fli.dll


process
begin
	fsdbDumpfile("counter.fsdb");
	fsdbDumpvars(0, "counter_tb");
	wait;
end process;
