module seq_detector (
    input clk,
    input reset,
    input in_bit,
    output reg detected
);
    // State encoding
    parameter S0=0, S1=1, S2=2, S3=3, S4=4;
    reg [2:0] state, next_state;

    // State Register
    always @(posedge clk or posedge reset) begin
        if (reset) state <= S0;
        else state <= next_state;
    end

    // Next State Logic
    always @(*) begin
        case(state)
            S0: next_state = in_bit ? S1 : S0;
            S1: next_state = in_bit ? S1 : S2;
            S2: next_state = in_bit ? S3 : S0;
            S3: next_state = in_bit ? S4 : S2;
            S4: next_state = in_bit ? S1 : S2; // Sequence 1011 detected
            default: next_state = S0;
        endcase
    end

    // Output Logic (Moore Machine)
    always @(*) begin
        detected = (state == S4) ? 1'b1 : 1'b0;
    end
endmodule
