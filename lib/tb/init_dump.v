//`define dump_top  mac_tb
//`ifndef dump_top
//	`define dump_top tb
//`endif

`ifndef dump_level
	`define dump_level 10
`endif

initial
begin
	
	#1;

  `ifdef VCS_DUMP
    $display("Start Recording Waveform in VPD format!");
    $vcdpluson();
    $vcdplustraceon;
  `endif
  
  `ifdef FSDB_DUMP
    $display("Start Recording Waveform in FSDB format!");
    $fsdbDumpfile("dump.fsdb");
    $fsdbDumpvars(`dump_level);
    
    //$fsdbDumpMemOnChange
    //
  `endif
  
  `ifdef NC_DUMP
    $recordsetup("dump", "version=1", "run=1","directory=.");
    $recordvars("depth=6");
  `endif
  
  `ifdef VCD_DUMP
    $display("Start Recording Waveform in VCD format!");
    $dumpfile("dump.vcd");
    $dumpvars(`dump_level);
  `endif
end
