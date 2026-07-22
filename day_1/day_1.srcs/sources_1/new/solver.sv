`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 22.07.2026 15:19:19
// Design Name: 
// Module Name: solver
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


module solver_part1(
    input [31:0] current,
    input [31:0] change,
    output [31:0] dial
    );
    assign dial = (current + change) % 100;
endmodule

module solver_part2(
    input  [31:0] current,
    input  [31:0] change,
    input         direction,      // 1 = Left, 0 = Right
    output reg [31:0] dial,
    output reg [31:0] zeros_passed
);

    reg [31:0] final_change;

    always @(*) begin
        // Number of complete revolutions
        zeros_passed = change / 100;

        // Remaining movement
        final_change = change % 100;

        if (direction) begin
            // Left
            if (current != 0 && final_change >= current)
                zeros_passed = zeros_passed + 1;

            if (final_change <= current)
                dial = current - final_change;
            else
                dial = current + 100 - final_change;
        end
        else begin
            // Right
            if (current + final_change >= 100)
                zeros_passed = zeros_passed + 1;

            if (current + final_change < 100)
                dial = current + final_change;
            else
                dial = current + final_change - 100;
        end
    end

endmodule