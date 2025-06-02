`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/23/2025 12:49:04 PM
// Design Name: 
// Module Name: tinyrisc_mac_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

`include "defines.v"

// select one option only
`define TEST_PROG  1

module tinyrisc_mac_tb;
 reg clk;
    reg rst;


    always #10 clk = ~clk;     // 50MHz
      wire [`RegBus] if_inst_i = tinyriscv_soc_top_0.u_tinyriscv.rib_pc_data_i;  // Test Custom MAC
     wire [`RegBus] if_inst_d = tinyriscv_soc_top_0.u_tinyriscv.if_inst_o;   // Test Custom MAC
     wire [`RegBus] ex_inst_o = tinyriscv_soc_top_0.u_tinyriscv.ie_inst_o;
    wire   macl_start = tinyriscv_soc_top_0.u_tinyriscv.ie_is_macl_o;
    wire   macl_busy = tinyriscv_soc_top_0.u_tinyriscv.mac_load_busy;  
     wire   macl_done = tinyriscv_soc_top_0.u_tinyriscv.mac_load_done;
     wire holdEnable = tinyriscv_soc_top_0.u_tinyriscv.ex_hold_flag_o;
     wire [`RegBus] mac_addr1 = tinyriscv_soc_top_0.u_tinyriscv.load_reg.addr1; 
     wire [`RegBus] mac_addr2 = tinyriscv_soc_top_0.u_tinyriscv.load_reg.addr2;
     wire [`RegBus] mdata1 = tinyriscv_soc_top_0.u_tinyriscv.load_reg.rf1_wdata;
     wire [`RegBus] mdata2 = tinyriscv_soc_top_0.u_tinyriscv.load_reg.rf2_wdata;
     wire [`RegBus] memd= tinyriscv_soc_top_0.u_tinyriscv.load_reg.mem_data;
     wire [7:0] idx= tinyriscv_soc_top_0.u_tinyriscv.load_reg.idx;
     wire [`RegBus] acc = tinyriscv_soc_top_0.u_tinyriscv.load_reg.acc;
      wire [2:0] state = tinyriscv_soc_top_0.u_tinyriscv.load_reg.state;
     wire [`RegBus] acc_out = tinyriscv_soc_top_0.u_tinyriscv.macl_acc_out;
     wire [`RegBus]ex_addr_i = tinyriscv_soc_top_0.u_tinyriscv.macl_reg_waddr_o;
          wire [`RegBus]ex_addr_o = tinyriscv_soc_top_0.u_tinyriscv.ex_reg_waddr_o;
           wire [`RegBus]mac_waddr = tinyriscv_soc_top_0.u_tinyriscv.u_ex.mac_waddr;
           //wire [`RegBus]reg_waddr = tinyriscv_soc_top_0.u_tinyriscv.u_ex.reg_waddr;
      //wire [`RegBus]ex_addr = tinyriscv_soc_top_0.u_tinyriscv.macl_reg_waddr_o;
      wire [`RegBus]ex_reg_data_o = tinyriscv_soc_top_0.u_tinyriscv.ex_reg_wdata_o;
      wire[`RegBus] x6 = tinyriscv_soc_top_0.u_tinyriscv.u_regs.regs[6];
      
     
     //wire   mac_reg_w= tinyriscv_soc_top_0.u_tinyriscv.mac_reg1_we_o;
     //wire [`RegBus] mreg_ad = tinyriscv_soc_top_0.u_tinyriscv.mac_reg1_waddr_o;
     // wire [`RegBus] mreg_data = tinyriscv_soc_top_0.u_tinyriscv.mac_reg1_wdata_o;
    
     //wire[`RegBus] mac_reg0 = tinyriscv_soc_top_0.u_tinyriscv.mreg.regs_a[0];
     //wire   macle_busy = tinyriscv_soc_top_0.u_tinyriscv.u_ex.mac_hold;
   // wire start = tinyriscv_soc_top_0.u_tinyriscv.load_reg.start;
    
       //wire [`RegBus] mreg1 = tinyriscv_soc_top_0.u_tinyriscv.load_reg.rf1_waddr;
       //wire [`RegBus] mdata1 = tinyriscv_soc_top_0.u_tinyriscv.load_reg.rf1_wdata;
       //wire [`RegBus] tmdata1 = tinyriscv_soc_top_0.u_tinyriscv.mac_reg1_wdata_o;
     //wire rib_hold = tinyriscv_soc_top_0.u_tinyriscv.rib_hold_flag_i;
     
     // wire holdE = tinyriscv_soc_top_0.u_tinyriscv.u_ex.hold_flag;
     //wire[2:0] funct3= tinyriscv_soc_top_0.u_tinyriscv.u_ex.funct3 ;
      wire [`RegBus] rib_mem_addr = tinyriscv_soc_top_0.u_tinyriscv.rib_ex_addr_o;
      wire rib_mem_req = tinyriscv_soc_top_0.u_tinyriscv.rib_ex_req_o;
       wire [`RegBus] rib_mem_data = tinyriscv_soc_top_0.u_tinyriscv.rib_ex_data_i;
     /*
     wire[`RegBus] mac_reg = tinyriscv_soc_top_0.u_tinyriscv.mreg.regs_a[0];
      wire [`RegBus]ex_wdata = tinyriscv_soc_top_0.u_tinyriscv.ex_reg_wdata_o;
      wire [`RegBus]ex_waddr = tinyriscv_soc_top_0.u_tinyriscv.ex_reg_waddr_o;
      //wire [`RegBus]ram4 =   tinyriscv_soc_top_0.u_rom._rom[1];
       wire we_i =   tinyriscv_soc_top_0.u_ram.we_i;
      wire write_reg = tinyriscv_soc_top_0.u_tinyriscv.ex_reg_we_o;
      wire write_mem= tinyriscv_soc_top_0.u_tinyriscv.ex_mem_we_o;
      wire write_rib = tinyriscv_soc_top_0.m0_we_i;
       wire write_rom = tinyriscv_soc_top_0.s0_we_o;
        wire write_ram = tinyriscv_soc_top_0.s1_we_o;
         wire [`RegBus] rom_add  =tinyriscv_soc_top_0.s0_addr_o;
        
     wire id_w_data = tinyriscv_soc_top_0.u_tinyriscv.id_reg_we_o;
     wire mem_req_write = tinyriscv_soc_top_0.u_tinyriscv.ex_mem_req_o;
     wire [`RegBus] ram_add  =tinyriscv_soc_top_0.s1_addr_o;
      wire [`RegBus]mem_addr = tinyriscv_soc_top_0.u_tinyriscv.ex_mem_raddr_o;
      wire[`RegBus] x5 = tinyriscv_soc_top_0.u_tinyriscv.u_regs.regs[5];
      wire[`RegBus] x4 = tinyriscv_soc_top_0.u_tinyriscv.u_regs.regs[4];
      
      wire rib_hold = tinyriscv_soc_top_0.u_tinyriscv.rib_hold_flag_i;
     
     wire [`RegBus] if_inst_i = tinyriscv_soc_top_0.u_tinyriscv.rib_pc_data_i;  // Test Custom MAC
     wire [`RegBus] if_inst_d = tinyriscv_soc_top_0.u_tinyriscv.if_inst_o;   // Test Custom MAC
     wire [`RegBus] ex_inst_o = tinyriscv_soc_top_0.u_tinyriscv.ie_inst_o;   // Test Custom MAC
     wire holdEnable = tinyriscv_soc_top_0.u_tinyriscv.ex_hold_flag_o;  // Test Custom MAC
      wire [`RegBus] ie_reg_addr = tinyriscv_soc_top_0.u_tinyriscv.ie_reg_waddr_o; // Test Custom MAC
       wire [`RegBus] ex_reg_addr = tinyriscv_soc_top_0.u_tinyriscv.ex_reg_waddr_o; // Test Custom MAC
    wire   mac_done = tinyriscv_soc_top_0.u_tinyriscv.mac_done;
      wire  mac_valid = tinyriscv_soc_top_0.u_tinyriscv.u_mac.valid; // Test Custom MAC
      wire [`RegBus]mac_acc_out_o= tinyriscv_soc_top_0.u_tinyriscv.mac_acc_out_o; // Test Custom MAC
      wire [`RegBus]ie_acc= tinyriscv_soc_top_0.u_tinyriscv.ie_acc_out_o; // Test Custom MAC
       wire [`RegBus]ex_wdata = tinyriscv_soc_top_0.u_tinyriscv.ex_reg_wdata_o; // Test Custom MAC
      wire [`RegBus]id_r1 = tinyriscv_soc_top_0.u_tinyriscv.id_reg1_rdata_o; // Test Custom MAC
      wire [`RegBus]id_r2= tinyriscv_soc_top_0.u_tinyriscv.id_reg2_rdata_o; // Test Custom MAC
      wire [`RegBus]ie_r1= tinyriscv_soc_top_0.u_tinyriscv.ie_reg1_rdata_o; // Test Custom MAC
      wire [`RegBus]ie_r2= tinyriscv_soc_top_0.u_tinyriscv.ie_reg2_rdata_o; // Test Custom MAC
      wire [`RegBus]ex_reg_data_o = tinyriscv_soc_top_0.u_tinyriscv.ex_reg_wdata_o; // Test Custom MAC
      //wire [`RegBus]mac_product= tinyriscv_soc_top_0.u_tinyriscv.u_mac.product;
     //wire [`RegBus] pc_o = tinyriscv_soc_top_0.u_tinyriscv.pc_pc_o;
       wire holdEnable = tinyriscv_soc_top_0.u_tinyriscv.ex_hold_flag_o; // Test Custom MAC
      */
      
       wire[`RegBus] x3 = tinyriscv_soc_top_0.u_tinyriscv.u_regs.regs[3];
    wire[`RegBus] x26 = tinyriscv_soc_top_0.u_tinyriscv.u_regs.regs[26];
    wire[`RegBus] x25 = tinyriscv_soc_top_0.u_tinyriscv.u_regs.regs[25];
    wire[`RegBus] x27 = tinyriscv_soc_top_0.u_tinyriscv.u_regs.regs[27];

    /*
    wire[`RegBus] x4 = tinyriscv_soc_top_0.u_tinyriscv.u_regs.regs[4]; // Test Custom MAC
    wire[`RegBus] x5 = tinyriscv_soc_top_0.u_tinyriscv.u_regs.regs[5]; // Test Custom MAC
     wire[`RegBus] x6 = tinyriscv_soc_top_0.u_tinyriscv.u_regs.regs[6]; // Test Custom MAC
    */

    integer r;

`ifdef TEST_JTAG
    reg TCK;
    reg TMS;
    reg TDI;
    wire TDO;

    integer i;
    reg[39:0] shift_reg;
    reg in;
    wire[39:0] req_data = tinyriscv_soc_top_0.u_jtag_top.u_jtag_driver.dtm_req_data;
    wire[4:0] ir_reg = tinyriscv_soc_top_0.u_jtag_top.u_jtag_driver.ir_reg;
    wire dtm_req_valid = tinyriscv_soc_top_0.u_jtag_top.u_jtag_driver.dtm_req_valid;
    wire[31:0] dmstatus = tinyriscv_soc_top_0.u_jtag_top.u_jtag_dm.dmstatus;
`endif

    initial begin
        clk = 0;
        rst = `RstEnable;
`ifdef TEST_JTAG
        TCK = 1;
        TMS = 1;
        TDI = 1;
`endif
        $display("test running...");
        #40
        rst = `RstDisable;
        #200

`ifdef TEST_PROG
        wait(x26 == 32'b1)   // wait sim end, when x26 == 1
        #100
        if (x27 == 32'b1) begin
            $display("~~~~~~~~~~~~~~~~~~~ TEST_PASS ~~~~~~~~~~~~~~~~~~~");
            $display("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
            $display("~~~~~~~~~ #####     ##     ####    #### ~~~~~~~~~");
            $display("~~~~~~~~~ #    #   #  #   #       #     ~~~~~~~~~");
            $display("~~~~~~~~~ #    #  #    #   ####    #### ~~~~~~~~~");
            $display("~~~~~~~~~ #####   ######       #       #~~~~~~~~~");
            $display("~~~~~~~~~ #       #    #  #    #  #    #~~~~~~~~~");
            $display("~~~~~~~~~ #       #    #   ####    #### ~~~~~~~~~");
            $display("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
            for (r = 0; r < 32; r = r + 1)
                $display("x%2d = 0x%x", r, tinyriscv_soc_top_0.u_tinyriscv.u_regs.regs[r]);
            $display("No of cycles executed = Ox%x",x25);
        end else begin
            $display("~~~~~~~~~~~~~~~~~~~ TEST_FAIL ~~~~~~~~~~~~~~~~~~~~");
            $display("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
            $display("~~~~~~~~~~######    ##       #    #     ~~~~~~~~~~");
            $display("~~~~~~~~~~#        #  #      #    #     ~~~~~~~~~~");
            $display("~~~~~~~~~~#####   #    #     #    #     ~~~~~~~~~~");
            $display("~~~~~~~~~~#       ######     #    #     ~~~~~~~~~~");
            $display("~~~~~~~~~~#       #    #     #    #     ~~~~~~~~~~");
            $display("~~~~~~~~~~#       #    #     #    ######~~~~~~~~~~");
            $display("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
            $display("fail testnum = %2d", x3);
            for (r = 0; r < 32; r = r + 1)
                $display("x%2d = 0x%x", r, tinyriscv_soc_top_0.u_tinyriscv.u_regs.regs[r]);
        end
`endif

`ifdef TEST_JTAG
        // reset
        for (i = 0; i < 8; i++) begin
            TMS = 1;
            TCK = 0;
            #100
            TCK = 1;
            #100
            TCK = 0;
        end

        // IR
        shift_reg = 40'b10001;

        // IDLE
        TMS = 0;
        TCK = 0;
        #100
        TCK = 1;
        #100
        TCK = 0;

        // SELECT-DR
        TMS = 1;
        TCK = 0;
        #100
        TCK = 1;
        #100
        TCK = 0;

        // SELECT-IR
        TMS = 1;
        TCK = 0;
        #100
        TCK = 1;
        #100
        TCK = 0;

        // CAPTURE-IR
        TMS = 0;
        TCK = 0;
        #100
        TCK = 1;
        #100
        TCK = 0;

        // SHIFT-IR
        TMS = 0;
        TCK = 0;
        #100
        TCK = 1;
        #100
        TCK = 0;

        // SHIFT-IR & EXIT1-IR
        for (i = 5; i > 0; i--) begin
            if (shift_reg[0] == 1'b1)
                TDI = 1'b1;
            else
                TDI = 1'b0;

            if (i == 1)
                TMS = 1;

            TCK = 0;
            #100
            in = TDO;
            TCK = 1;
            #100
            TCK = 0;

            shift_reg = {{(35){1'b0}}, in, shift_reg[4:1]};
        end

        // PAUSE-IR
        TMS = 0;
        TCK = 0;
        #100
        TCK = 1;
        #100
        TCK = 0;

        // EXIT2-IR
        TMS = 1;
        TCK = 0;
        #100
        TCK = 1;
        #100
        TCK = 0;

        // UPDATE-IR
        TMS = 1;
        TCK = 0;
        #100
        TCK = 1;
        #100
        TCK = 0;

        // IDLE
        TMS = 0;
        TCK = 0;
        #100
        TCK = 1;
        #100
        TCK = 0;

        // IDLE
        TMS = 0;
        TCK = 0;
        #100
        TCK = 1;
        #100
        TCK = 0;

        // IDLE
        TMS = 0;
        TCK = 0;
        #100
        TCK = 1;
        #100
        TCK = 0;

        // IDLE
        TMS = 0;
        TCK = 0;
        #100
        TCK = 1;
        #100
        TCK = 0;

        // dmi write
        shift_reg = {6'h10, {(32){1'b0}}, 2'b10};

        // SELECT-DR
        TMS = 1;
        TCK = 0;
        #100
        TCK = 1;
        #100
        TCK = 0;

        // CAPTURE-DR
        TMS = 0;
        TCK = 0;
        #100
        TCK = 1;
        #100
        TCK = 0;

        // SHIFT-DR
        TMS = 0;
        TCK = 0;
        #100
        TCK = 1;
        #100
        TCK = 0;

        // SHIFT-DR & EXIT1-DR
        for (i = 40; i > 0; i--) begin
            if (shift_reg[0] == 1'b1)
                TDI = 1'b1;
            else
                TDI = 1'b0;

            if (i == 1)
                TMS = 1;

            TCK = 0;
            #100
            in = TDO;
            TCK = 1;
            #100
            TCK = 0;

            shift_reg = {in, shift_reg[39:1]};
        end

        // PAUSE-DR
        TMS = 0;
        TCK = 0;
        #100
        TCK = 1;
        #100
        TCK = 0;

        // EXIT2-DR
        TMS = 1;
        TCK = 0;
        #100
        TCK = 1;
        #100
        TCK = 0;

        // UPDATE-DR
        TMS = 1;
        TCK = 0;
        #100
        TCK = 1;
        #100
        TCK = 0;

        // IDLE
        TMS = 0;
        TCK = 0;
        #100
        TCK = 1;
        #100
        TCK = 0;

        $display("ir_reg = 0x%x", ir_reg);
        $display("dtm_req_valid = %d", dtm_req_valid);
        $display("req_data = 0x%x", req_data);

        // IDLE
        TMS = 0;
        TCK = 0;
        #100
        TCK = 1;
        #100
        TCK = 0;

        // IDLE
        TMS = 0;
        TCK = 0;
        #100
        TCK = 1;
        #100
        TCK = 0;

        $display("dmstatus = 0x%x", dmstatus);

        // IDLE
        TMS = 0;
        TCK = 0;
        #100
        TCK = 1;
        #100
        TCK = 0;

        // SELECT-DR
        TMS = 1;
        TCK = 0;
        #100
        TCK = 1;
        #100
        TCK = 0;

        // dmi read
        shift_reg = {6'h11, {(32){1'b0}}, 2'b01};

        // CAPTURE-DR
        TMS = 0;
        TCK = 0;
        #100
        TCK = 1;
        #100
        TCK = 0;

        // SHIFT-DR
        TMS = 0;
        TCK = 0;
        #100
        TCK = 1;
        #100
        TCK = 0;

        // SHIFT-DR & EXIT1-DR
        for (i = 40; i > 0; i--) begin
            if (shift_reg[0] == 1'b1)
                TDI = 1'b1;
            else
                TDI = 1'b0;

            if (i == 1)
                TMS = 1;

            TCK = 0;
            #100
            in = TDO;
            TCK = 1;
            #100
            TCK = 0;

            shift_reg = {in, shift_reg[39:1]};
        end

        // PAUSE-DR
        TMS = 0;
        TCK = 0;
        #100
        TCK = 1;
        #100
        TCK = 0;

        // EXIT2-DR
        TMS = 1;
        TCK = 0;
        #100
        TCK = 1;
        #100
        TCK = 0;

        // UPDATE-DR
        TMS = 1;
        TCK = 0;
        #100
        TCK = 1;
        #100
        TCK = 0;

        // IDLE
        TMS = 0;
        TCK = 0;
        #100
        TCK = 1;
        #100
        TCK = 0;

        // IDLE
        TMS = 0;
        TCK = 0;
        #100
        TCK = 1;
        #100
        TCK = 0;

        // IDLE
        TMS = 0;
        TCK = 0;
        #100
        TCK = 1;
        #100
        TCK = 0;

        // IDLE
        TMS = 0;
        TCK = 0;
        #100
        TCK = 1;
        #100
        TCK = 0;

        // SELECT-DR
        TMS = 1;
        TCK = 0;
        #100
        TCK = 1;
        #100
        TCK = 0;

        // dmi read
        shift_reg = {6'h11, {(32){1'b0}}, 2'b00};

        // CAPTURE-DR
        TMS = 0;
        TCK = 0;
        #100
        TCK = 1;
        #100
        TCK = 0;

        // SHIFT-DR
        TMS = 0;
        TCK = 0;
        #100
        TCK = 1;
        #100
        TCK = 0;

        // SHIFT-DR & EXIT1-DR
        for (i = 40; i > 0; i--) begin
            if (shift_reg[0] == 1'b1)
                TDI = 1'b1;
            else
                TDI = 1'b0;

            if (i == 1)
                TMS = 1;

            TCK = 0;
            #100
            in = TDO;
            TCK = 1;
            #100
            TCK = 0;

            shift_reg = {in, shift_reg[39:1]};
        end

        #100

        $display("shift_reg = 0x%x", shift_reg[33:2]);

        if (dmstatus == shift_reg[33:2]) begin
            $display("######################");
            $display("### jtag test pass ###");
            $display("######################");
        end else begin
            $display("######################");
            $display("!!! jtag test fail !!!");
            $display("######################");
        end
`endif

        $finish;
    end

    // sim timeout
    //initial begin
    //    #100000000
    //    $display("Time Out.");
    //    $finish;
    //end

    // read mem data
    initial begin
        $readmemh ("/home/sidharth/RISC-V/tinyriscv/sim/mload_t.data", tinyriscv_soc_top_0.u_rom._rom); // Test Custom MAC
    end
    
    
    // Test Custom MAC 
    initial begin
    tinyriscv_soc_top_0.u_tinyriscv.u_regs.regs[4] =32'h10001000; // Test Custom MAC
    tinyriscv_soc_top_0.u_tinyriscv.u_regs.regs[5] =32'h10001020; // Test Custom MAC
   
    end
    integer i;
    initial begin
    //for (i = 0; i < 4096; i = i + 1) begin
      tinyriscv_soc_top_0.u_ram._ram[1024] = 32'd7 ;
      tinyriscv_soc_top_0.u_ram._ram[1025] = 32'd6 ;
      tinyriscv_soc_top_0.u_ram._ram[1032] = 32'd8 ;
      tinyriscv_soc_top_0.u_ram._ram[1033] = 32'd9 ;
    //end
    end


    // generate wave file, used by gtkwave
    initial begin
        $dumpfile("tinyrisc_mac_tb.vcd");
        $dumpvars(0, tinyrisc_mac_tb);
    end

    tinyriscv_soc_top tinyriscv_soc_top_0(
        .clk(clk),
        .rst(rst),
        .uart_debug_pin(1'b0)
`ifdef TEST_JTAG
        ,
        .jtag_TCK(TCK),
        .jtag_TMS(TMS),
        .jtag_TDI(TDI),
        .jtag_TDO(TDO)
`endif
    );
endmodule
