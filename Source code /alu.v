
`timescale 1ns / 1ps

module alu (
    input  wire [7:0] A,
    input  wire [7:0] B,
    input  wire [2:0] ALU_SEL,
    output reg  [7:0] ALU_OUT,
    output reg  Z,
    output reg  C,
    output reg  N,
    output reg  V
);
    reg [8:0] TEMP;
    always @(*) begin
        ALU_OUT = 8'b00000000;
        TEMP    = 9'b000000000;
        C = 1'b0;
        V= 1'b0;
        case (ALU_SEL)
            3'b000: begin
                TEMP = {1'b0, A} + {1'b0, B};
                ALU_OUT = TEMP[7:0];
                C = TEMP[8];
                V = (~(A[7] ^ B[7])) &
                     (A[7] ^ ALU_OUT[7]);
            end
            3'b001: 
            begin
                ALU_OUT = A - B;
                C = (A >= B);  
                V = (A[7] ^ B[7]) &
                    (A[7] ^ ALU_OUT[7]);
            end
            3'b010: 
            begin
                ALU_OUT = A & B;
            end
            3'b011: begin
                ALU_OUT = A | B;
            end
            3'b100: begin
                ALU_OUT = A ^ B;
            end
            3'b101: begin
                ALU_OUT = ~(A ^ B);
            end
            3'b110: begin
                ALU_OUT = A * B;
            end
            default: begin
                ALU_OUT = 8'b00000000;
            end
        endcase
        Z = (ALU_OUT == 8'b00000000);
        N = ALU_OUT[7];
    end
endmodule

