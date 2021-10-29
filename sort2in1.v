/* -------------
Project: Sort all data with heap method
always keep max 16 values
Author: liqh
Date: 2021-10-29

--------------*/
module sort2in1 
#(parameter W =12 ) 
(
    input clk,
    input synrst,
    input DataEn,
    input [W-1:0]DataIn,
    output     [W-1:0] DataMax,
    output reg [W+4-1:0]DataSumOut
    );

    reg [W-1:0]R00;
    reg [W-1:0]R01;
    reg [W-1:0]R02;
    reg [W-1:0]R03;
    reg [W-1:0]R04;
    reg [W-1:0]R05;
    reg [W-1:0]R06;
    reg [W-1:0]R07;
    reg [W-1:0]R08;
    reg [W-1:0]R09;
    reg [W-1:0]R10;
    reg [W-1:0]R11;
    reg [W-1:0]R12;
    reg [W-1:0]R13;
    reg [W-1:0]R14;
    reg [W-1:0]R15;

    reg [W-1:0]R00_next;
    reg [W-1:0]R01_next;
    reg [W-1:0]R02_next;
    reg [W-1:0]R03_next;
    reg [W-1:0]R04_next;
    reg [W-1:0]R05_next;
    reg [W-1:0]R06_next;
    reg [W-1:0]R07_next;
    reg [W-1:0]R08_next;
    reg [W-1:0]R09_next;
    reg [W-1:0]R10_next;
    reg [W-1:0]R11_next;
    reg [W-1:0]R12_next;
    reg [W-1:0]R13_next;
    reg [W-1:0]R14_next;
    reg [W-1:0]R15_next;

assign DataMax=R15;
always@(posedge clk)
    if(synrst)begin
        R00<=0;
        R01<=0;
        R02<=0;
        R03<=0;
        R04<=0;
        R05<=0;
        R06<=0;
        R07<=0;
        R08<=0;
        R09<=0;
        R10<=0;
        R11<=0;
        R12<=0;
        R13<=0;
        R14<=0;
        R15<=0;
    end
    else if(DataEn)begin
        R00<=R00_next;
        R01<=R01_next;
        R02<=R02_next;
        R03<=R03_next;
        R04<=R04_next;
        R05<=R05_next;
        R06<=R06_next;
        R07<=R07_next;
        R08<=R08_next;
        R09<=R09_next;
        R10<=R10_next;
        R11<=R11_next;
        R12<=R12_next;
        R13<=R13_next;
        R14<=R14_next;
        R15<=R15_next;
    end

wire  R00_flag=DataIn>=R00;
wire  R01_flag=DataIn>=R01;
wire  R02_flag=DataIn>=R02;
wire  R03_flag=DataIn>=R03;
wire  R04_flag=DataIn>=R04;
wire  R05_flag=DataIn>=R05;
wire  R06_flag=DataIn>=R06;
wire  R07_flag=DataIn>=R07;
wire  R08_flag=DataIn>=R08;
wire  R09_flag=DataIn>=R09;
wire  R10_flag=DataIn>=R10;
wire  R11_flag=DataIn>=R11;
wire  R12_flag=DataIn>=R12;
wire  R13_flag=DataIn>=R13;
wire  R14_flag=DataIn>=R14;
wire  R15_flag=DataIn>=R15;

wire R00_shift_flag;
wire R01_shift_flag;
wire R02_shift_flag;
wire R03_shift_flag;
wire R04_shift_flag;
wire R05_shift_flag;
wire R06_shift_flag;
wire R07_shift_flag;
wire R08_shift_flag;
wire R09_shift_flag;
wire R10_shift_flag;
wire R11_shift_flag;
wire R12_shift_flag;
wire R13_shift_flag;
wire R14_shift_flag;
wire R15_shift_flag;

assign  R00_shift_flag=R01_shift_flag | R01_flag;
assign  R01_shift_flag=R02_shift_flag | R02_flag;
assign  R02_shift_flag=R03_shift_flag | R03_flag;
assign  R03_shift_flag=R04_shift_flag | R04_flag;
assign  R04_shift_flag=R05_shift_flag | R05_flag;
assign  R05_shift_flag=R06_shift_flag | R06_flag;
assign  R06_shift_flag=R07_shift_flag | R07_flag;
assign  R07_shift_flag=R08_shift_flag | R08_flag;
assign  R08_shift_flag=R09_shift_flag | R09_flag;
assign  R09_shift_flag=R10_shift_flag | R10_flag;
assign  R10_shift_flag=R11_shift_flag | R11_flag;
assign  R11_shift_flag=R12_shift_flag | R12_flag;
assign  R12_shift_flag=R13_shift_flag | R13_flag;
assign  R13_shift_flag=R14_shift_flag | R14_flag;
assign  R14_shift_flag=R15_shift_flag | R15_flag;
assign  R15_shift_flag=1'b0;


// always @(*)
//     if(R15_flag)
//         R15_next=DataIn;
//     else 
//         R15_next=R15 ;

// always @(*)
//     if(R14_shift_flag)
//         R14_next=R15;
//     else if(R14_flag) 
//         R14_next <= DataIn ;
//     else
//         R14_next=R14;

// always_comb @(*)  if(R13_shift_flag)  R13_next=R14;  else if(R13_flag)  R13_next = DataIn ; else R13_next=R13;
always @(*)                                     		 if(R15_flag)  R15_next = DataIn ; else R15_next=R15;
always @(*)  if(R14_shift_flag)  R14_next=R15;  else if(R14_flag)  R14_next = DataIn ; else R14_next=R14;
always @(*)  if(R13_shift_flag)  R13_next=R14;  else if(R13_flag)  R13_next = DataIn ; else R13_next=R13;
always @(*)  if(R12_shift_flag)  R12_next=R13;  else if(R12_flag)  R12_next = DataIn ; else R12_next=R12;
always @(*)  if(R11_shift_flag)  R11_next=R12;  else if(R11_flag)  R11_next = DataIn ; else R11_next=R11;
always @(*)  if(R10_shift_flag)  R10_next=R11;  else if(R10_flag)  R10_next = DataIn ; else R10_next=R10;
always @(*)  if(R09_shift_flag)  R09_next=R10;  else if(R09_flag)  R09_next = DataIn ; else R09_next=R09;
always @(*)  if(R08_shift_flag)  R08_next=R09;  else if(R08_flag)  R08_next = DataIn ; else R08_next=R08;
always @(*)  if(R07_shift_flag)  R07_next=R08;  else if(R07_flag)  R07_next = DataIn ; else R07_next=R07;
always @(*)  if(R06_shift_flag)  R06_next=R07;  else if(R06_flag)  R06_next = DataIn ; else R06_next=R06;
always @(*)  if(R05_shift_flag)  R05_next=R06;  else if(R05_flag)  R05_next = DataIn ; else R05_next=R05;
always @(*)  if(R04_shift_flag)  R04_next=R05;  else if(R04_flag)  R04_next = DataIn ; else R04_next=R04;
always @(*)  if(R03_shift_flag)  R03_next=R04;  else if(R03_flag)  R03_next = DataIn ; else R03_next=R03;
always @(*)  if(R02_shift_flag)  R02_next=R03;  else if(R02_flag)  R02_next = DataIn ; else R02_next=R02;
always @(*)  if(R01_shift_flag)  R01_next=R02;  else if(R01_flag)  R01_next = DataIn ; else R01_next=R01;
always @(*)  if(R00_shift_flag)  R00_next=R01;  else if(R00_flag)  R00_next = DataIn ; else R00_next=R00;

// banlance tree for sum 16 value;
wire [W:0] s_0;
wire [W:0] s_1;
wire [W:0] s_2;
wire [W:0] s_3;
wire [W:0] s_4;
wire [W:0] s_5;
wire [W:0] s_6;
wire [W:0] s_7;

assign s_0={1'b0,R15}+{1'b0,R00};
assign s_1={1'b0,R14}+{1'b0,R01};
assign s_2={1'b0,R13}+{1'b0,R02};
assign s_3={1'b0,R12}+{1'b0,R03};
assign s_4={1'b0,R11}+{1'b0,R04};
assign s_5={1'b0,R10}+{1'b0,R05};
assign s_6={1'b0,R09}+{1'b0,R06};
assign s_7={1'b0,R08}+{1'b0,R07};

wire [W+1:0] s0_0;
wire [W+1:0] s0_1;
wire [W+1:0] s0_2;
wire [W+1:0] s0_3;

assign s0_0={1'b0,s_0}+{1'b0,s_7};
assign s0_1={1'b0,s_1}+{1'b0,s_6};
assign s0_2={1'b0,s_2}+{1'b0,s_5};
assign s0_3={1'b0,s_3}+{1'b0,s_4};

wire [W+2:0] s1_0;
wire [W+2:0] s1_1;

assign s1_0={1'b0,s0_0}+{1'b0,s0_3};
assign s1_1={1'b0,s0_1}+{1'b0,s0_2};

wire [W+3:0] s2_0;                   
                                     
assign s2_0={1'b0,s1_0}+{1'b0,s1_1}; 

// output the max 16 values                                            
always @(clk)
	if(synrst)
		DataSumOut<='b0;
	else
		DataSumOut<=s2_0;

endmodule