`timescale 1 ns / 1 ps

`include "defines.v"

// select one option only
`define TEST_PROG  1
//`define TEST_JTAG  1

//0252102B

// testbench module
module tinyriscv_soc_tb;

    reg clk;
    reg rst;


    always #10 clk = ~clk;     // 50MHz
    wire [`RegBus] if_inst_i = tinyriscv_soc_top_0.u_tinyriscv.rib_pc_data_i;  // Test Custom MAC
     wire [`RegBus] id_inst_d = tinyriscv_soc_top_0.u_tinyriscv.if_inst_o;   // Test Custom MAC
     wire [`RegBus] ex_inst_o = tinyriscv_soc_top_0.u_tinyriscv.ie_inst_o;
     wire hold = tinyriscv_soc_top_0.u_tinyriscv.ex_hold_flag_o;
     
     wire [`RegBus] product = tinyriscv_soc_top_0.u_tinyriscv.u_power.product;
       wire [`RegBus] acc = tinyriscv_soc_top_0.u_tinyriscv.u_avg.acc;
       wire [`RegBus] S = tinyriscv_soc_top_0.u_tinyriscv.u_avg.S;
       wire [2:0] state = tinyriscv_soc_top_0.u_tinyriscv.u_avg.state;
       wire[`RegBus] dest_reg = tinyriscv_soc_top_0.u_tinyriscv.u_regs.regs[10];
  
  
    //wire [`RegBus] rib_mem_data = tinyriscv_soc_top_0.u_tinyriscv.rib_ex_data_i;
     //wire [`RegBus] rib_mem_addr = tinyriscv_soc_top_0.u_tinyriscv.rib_ex_addr_o;
      //wire [`RegBus] final_avg = tinyriscv_soc_top_0.u_tinyriscv.u_avg.avg_out;
       wire [`RegBus] exec_wdata = tinyriscv_soc_top_0.u_tinyriscv.u_ex.custom_wdata;
       wire [`RegBus] reg_wdata = tinyriscv_soc_top_0.u_tinyriscv.ex_reg_wdata_o;
        wire reg_we= tinyriscv_soc_top_0.u_tinyriscv.ex_reg_we_o;
        wire [`RegAddrBus] reg_waddr= tinyriscv_soc_top_0.u_tinyriscv.ex_reg_waddr_o;
      // wire [`RegBus] exec_addr = tinyriscv_soc_top_0.u_tinyriscv.u_ex.reg_waddr_o;
       // wire [`RegBus] ex_addr = tinyriscv_soc_top_0.u_tinyriscv.u_avg.mac_dst_reg_addr_o;
       //wire exec_write= tinyriscv_soc_top_0.u_tinyriscv.u_ex.reg_we_o;
       //wire [`RegBus] exec_avg = tinyriscv_soc_top_0.u_tinyriscv.exec_avg_out_o;
       //wire mem_req= tinyriscv_soc_top_0.u_tinyriscv.power_mem_req_o;
       /*
       wire [`RegBus] product = tinyriscv_soc_top_0.u_tinyriscv.u_power.product;
       wire [`RegBus] acc = tinyriscv_soc_top_0.u_tinyriscv.u_power.acc;
       wire [`RegBus] power = tinyriscv_soc_top_0.u_tinyriscv.u_power.power;
       wire [2:0] state = tinyriscv_soc_top_0.u_tinyriscv.u_power.state;
       wire[`RegBus] dest_reg = tinyriscv_soc_top_0.u_tinyriscv.u_regs.regs[10];
      */
       wire [`RegBus]mem_data_in = tinyriscv_soc_top_0.u_tinyriscv.rib_ex_data_i;
        wire [`RegBus]mem_data = tinyriscv_soc_top_0.u_tinyriscv.u_power.mem_data;
       wire [`RegBus] avg_out = tinyriscv_soc_top_0.u_tinyriscv.exec_power_out_o;
        wire [`RegBus] mem_addr = tinyriscv_soc_top_0.u_tinyriscv.u_power.mem_addr;
        wire [`RegBus] r2_wdata = tinyriscv_soc_top_0.u_tinyriscv.ie_reg2_rdata_o;
        wire [`RegBus] fixed_inv = tinyriscv_soc_top_0.u_tinyriscv.u_power.fixed_inv;
        /*
         wire [`RegBus] acc= tinyriscv_soc_top_0.u_tinyriscv.load_reg.acc;
           
       wire [2:0] state = tinyriscv_soc_top_0.u_tinyriscv.load_reg.state;
   wire [`RegBus] r3_wdata = tinyriscv_soc_top_0.u_tinyriscv.ie_reg2_rdata_o
   wire [`RegBus] count = tinyriscv_soc_top_0.u_tinyriscv.load_reg.count;
     
    wire mac_start = tinyriscv_soc_top_0.u_tinyriscv.ie_is_macl_o;
    wire mac_ready = tinyriscv_soc_top_0.u_tinyriscv.mac_load_done;
       wire mac_busy= tinyriscv_soc_top_0.u_tinyriscv.mac_load_busy;
        wire mem_req= tinyriscv_soc_top_0.u_tinyriscv.mac_mem_req_o;
        */
       // wire[2:0] funct3 = tinyriscv_soc_top_0.u_tinyriscv.u_id.funct3;
       // wire[6:0] opcode = tinyriscv_soc_top_0.u_tinyriscv.u_id.opcode;
        //wire[6:0] funct7 = tinyriscv_soc_top_0.u_tinyriscv.u_id.funct7;
        //wire avg_id= tinyriscv_soc_top_0.u_tinyriscv.u_id.is_mov_avg_o;
      wire avg_start = tinyriscv_soc_top_0.u_tinyriscv.ie_is_avg_filter_o;
      wire avg_ready = tinyriscv_soc_top_0.u_tinyriscv.exec_avg_done;
       wire avg_busy= tinyriscv_soc_top_0.u_tinyriscv.exec_avg_busy;
        wire mem_req= tinyriscv_soc_top_0.u_tinyriscv.avg_mem_req_o;
        /*
        wire p_start = tinyriscv_soc_top_0.u_tinyriscv.ie_is_power_est_o;
      wire p_ready = tinyriscv_soc_top_0.u_tinyriscv.exec_power_done;
       wire p_busy= tinyriscv_soc_top_0.u_tinyriscv.exec_power_busy;
        wire mem_req= tinyriscv_soc_top_0.u_tinyriscv.power_mem_req_o;
       */
    //wire[`RegBus] x1 = tinyriscv_soc_top_0.u_tinyriscv.u_regs.regs[1];
    //wire[`RegBus] x2 = tinyriscv_soc_top_0.u_tinyriscv.u_regs.regs[2];

    //wire[`RegBus] mac_c = tinyriscv_soc_top_0.u_tinyriscv.mreg.mac_count;
    
    wire[`RegBus] x3 = tinyriscv_soc_top_0.u_tinyriscv.u_regs.regs[3];
    wire[`RegBus] x26 = tinyriscv_soc_top_0.u_tinyriscv.u_regs.regs[26];
    wire[`RegBus] x25 = tinyriscv_soc_top_0.u_tinyriscv.u_regs.regs[25];
    wire[`RegBus] x27 = tinyriscv_soc_top_0.u_tinyriscv.u_regs.regs[27];

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
            $display("No of cycles executed = Ox%x",x25); // Custom instruction -MAC
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

     //sim timeout
    //initial begin
       // #100000000
      // #10
        //$display("Time Out.");
        //$finish;
    //end

    // read mem data
    initial begin
          $display("test running...");
        $readmemh ("/home/sidharth/RISC-V/tinyriscv/sim/avg.data", tinyriscv_soc_top_0.u_rom._rom);
    end
    //mac_c.data
    /*
      initial begin
    tinyriscv_soc_top_0.u_tinyriscv.u_regs.regs[6] =32'd200; // Test Custom MAC
    tinyriscv_soc_top_0.u_tinyriscv.u_regs.regs[5] =32'd5; // Test Custom MAC
    tinyriscv_soc_top_0.u_tinyriscv.u_regs.regs[7] =32'd50; 
    end
    */
initial begin
    tinyriscv_soc_top_0.u_tinyriscv.u_regs.regs[4] =32'h10001000; // Test Custom MAC
    //tinyriscv_soc_top_0.u_tinyriscv.u_regs.regs[5] =32'h10001020; // Test Custom MAC
     tinyriscv_soc_top_0.u_tinyriscv.u_regs.regs[5] =32'd8; // Test Custom MAC
     tinyriscv_soc_top_0.u_tinyriscv.u_regs.regs[2] =32'd2;
     tinyriscv_soc_top_0.u_tinyriscv.u_regs.regs[6] =32'd0;
      tinyriscv_soc_top_0.u_tinyriscv.u_regs.regs[10] =32'd1;
     tinyriscv_soc_top_0.u_tinyriscv.u_regs.regs[11] =32'd3;
   
    end
    integer i;
    initial begin
    //for (i = 0; i < 4096; i = i + 1) begin
      tinyriscv_soc_top_0.u_ram._ram[1024] = 32'd1 ;
      tinyriscv_soc_top_0.u_ram._ram[1025] = 32'd2 ;
      tinyriscv_soc_top_0.u_ram._ram[1026] = 32'd3 ;
      tinyriscv_soc_top_0.u_ram._ram[1027] = 32'd4 ;
       tinyriscv_soc_top_0.u_ram._ram[1028] = 32'd5 ;
      tinyriscv_soc_top_0.u_ram._ram[1029] = 32'd6 ;
       tinyriscv_soc_top_0.u_ram._ram[1030] = 32'd7 ;
        tinyriscv_soc_top_0.u_ram._ram[1031] = 32'd8 ;
      tinyriscv_soc_top_0.u_ram._ram[1032] = 32'd5 ;
      tinyriscv_soc_top_0.u_ram._ram[1033] = 32'd6 ;
       tinyriscv_soc_top_0.u_ram._ram[1033] = 32'd7 ;
        tinyriscv_soc_top_0.u_ram._ram[1033] = 32'd8 ;
    //end
    end
    
    //0252232B
  //0252202B
  
  //count
  //0252132B
//0252102B
    // generate wave file, used by gtkwave
    initial begin
        $dumpfile("tinyriscv_soc_tb.vcd");
        $dumpvars(0, tinyriscv_soc_tb);
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
