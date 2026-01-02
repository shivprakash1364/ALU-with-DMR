`timescale 1ns / 1ps

module ALU #(
    parameter WIDTH = 8
)(
    input  wire [WIDTH-1:0] A,
    input  wire [WIDTH-1:0] B,
    input  wire [2:0]       Opcode,
    output reg  [WIDTH-1:0] Result
);

    always @(*) begin
        case (Opcode)
            3'b000: Result = A + B;        // ADD
            3'b001: Result = A - B;        // SUB
            3'b010: Result = A & B;        // AND
            3'b011: Result = A | B;        // OR
            3'b100: Result = A ^ B;        // XOR
            3'b101: Result = ~A;           // NOT A
            3'b110: Result = A << 1;       // Logical left shift by 1
            3'b111: Result = A >> 1;       // Logical right shift by 1
          default: Result = {WIDTH{1'b0}};
        endcase
    end

endmodule

// ------------------------------------------------------------
// 2nd Module: DMR_ALU

module dmr_alu #(
    parameter WIDTH = 8
)(
    input  wire [WIDTH-1:0] A,
    input  wire [WIDTH-1:0] B,
    input  wire [2:0]       Opcode,
    output wire [WIDTH-1:0] Final_Result,
    output wire             Error_Flag
);

    // Internal ALU outputs
    wire [WIDTH-1:0] result_1;
    wire [WIDTH-1:0] result_2;

    // Primary ALU
    ALU #(.WIDTH(WIDTH)) ALU_INSTANCE_1 (
        .A(A),
        .B(B),
        .Opcode(Opcode),
        .Result(result_1)
    );

    // Redundant ALU
    ALU #(.WIDTH(WIDTH)) ALU_INSTANCE_2 (
        .A(A),
        .B(B),
        .Opcode(Opcode),
        .Result(result_2)
    );

    // Comparator logic
    assign Error_Flag = |(result_1 ^ result_2);

    // Output selected from primary ALU
    assign Final_Result = result_1;

endmodule