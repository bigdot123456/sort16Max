//`define dump_top  mac_tb
//`ifndef dump_top
//	`define dump_top tb
//`endif

`ifndef dump_level
	`define dump_level 10
`endif

module waveform_record;
parameter dump_name="";

reg [63*8:1] wrt_name;

initial
begin
	
	#1;

  `ifdef VCS_DUMP
    $display("Start Recording Waveform in VPD format!");
    $vcdpluson(`dump_top);
    $vcdplustraceon;
  `endif
  
  `ifdef FSDB_DUMP
    $display("Start Recording Waveform in FSDB format!");
	  wrt_name = {"dump",dump_name,".fsdb"};
    $fsdbDumpfile(wrt_name);
    $fsdbDumpvars(`dump_level,`dump_top);
    
    //$fsdbDumpMemOnChange
    //
  `endif
  
  `ifdef NC_DUMP
	  wrt_name = {"design=dump",dump_name};
    $recordsetup(wrt_name, "version=1", "run=1","directory=.");
    $recordvars(`dump_top,"depth=6");
  `endif
  
  `ifdef VCD_DUMP
	  wrt_name = {"dump",dump_name,".vcd"};
    $display("Start Recording Waveform in VCD format!");
    $dumpfile(wrt_name);
    $dumpvars(`dump_level,`dump_top);
  `endif
end
endmodule
