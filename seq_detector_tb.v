module seq_detector_tb;
    reg clk, reset, in_bit;
    wire detected;

    seq_detector uut(clk, reset, in_bit, detected);
    always #5 clk = ~clk;

    initial begin
        clk = 0; reset = 1; in_bit = 0;
        #10 reset = 0;
        
        // Input stream: 1 0 1 1 (Should detect)
        in_bit = 1; #10;
        in_bit = 0; #10;
        in_bit = 1; #10;
        in_bit = 1; #10;
        
        // Extra bits
        in_bit = 0; #10;
        in_bit = 0; #10;
        $finish;
    end
endmodule
