`timescale 1ns/1ps
module tb_mux;

    // Testbench signals
    reg  [15:0] in0, in1;
    reg         sel;
    wire [15:0] out;

    // Instantiate the 2:1 MUX
    mux #(16) uut (
        .in0(in0),
        .in1(in1),
        .sel(sel),
        .out(out)
    );

    initial begin
        // Initial values
        in0 = 16'hAAAA; 
        in1 = 16'h5555; 
        sel = 0;        
        #10; // Expect out = 0xAAAA

        sel = 1;        
        #10; // Expect out = 0x5555

        // Change inputs
        in0 = 16'h1234; 
        in1 = 16'hABCD; 
        sel = 0;        
        #10; // Expect out = 0x1234

        sel = 1;        
        #10; // Expect out = 0xABCD

        $stop; // End simulation
    end

endmodule
