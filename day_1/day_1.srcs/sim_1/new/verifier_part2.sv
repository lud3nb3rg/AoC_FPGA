`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 22.07.2026 19:28:13
// Design Name: 
// Module Name: verifier_part2
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


module solver_part2_tb;

    logic [31:0] current;
    logic [31:0] change;
    logic [31:0] dial;
    logic        bool_direction;
    logic [31:0] zeros_passed;

    integer zero_count;
    integer file;
    integer value;

    reg [8*32-1:0] line;
    reg [7:0] direction;


    // DUT instantiation
    solver_part2 dut (
        .current(current),
        .change(change),
        .direction(bool_direction),
        .dial(dial),
        .zeros_passed(zeros_passed)
    );


    initial begin
        // Initial dial position
        current = 32'd50;

        // Initialize variables
        change = 0;
        bool_direction = 1'b0;
        zero_count = 0;

        // Open input file
        file = $fopen("day1_input.txt", "r");

        if (file == 0) begin
            $display("ERROR: Could not open day1_input.txt");
            $finish;
        end


        // Read every line
        while ($fgets(line, file)) begin

            if ($sscanf(line, "%c%d", direction, value) == 2) begin

                // Set movement amount
                change = value;

                // Set direction
                if (direction == "L") begin
                    bool_direction = 1'b1;
                end
                else if (direction == "R") begin
                    bool_direction = 1'b0;
                end
                else begin
                    $display("ERROR: Invalid direction %c", direction);
                    $finish;
                end


                // Wait for combinational logic to update
                #0

                // Accumulate zeros crossed
                zero_count = zero_count + zeros_passed;

                // Move dial to new position
                current = dial;


                $display(
                    "Move %c%0d -> dial=%0d, zeros=%0d, total=%0d",
                    direction,
                    value,
                    dial,
                    zeros_passed,
                    zero_count
                );

            end
            else begin
                $display("WARNING: Could not parse line: %s", line);
            end

        end


        $fclose(file);

        $display("--------------------------------");
        $display("Number of zeros = %0d", zero_count);
        $display("--------------------------------");

        $finish;
    end

endmodule