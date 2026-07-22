module solver_tb;

    logic [31:0] current;
    logic [31:0] change;
    logic [31:0] dial;

    integer zero_count = 0;

    solver_part1 dut (
        .current(current),
        .change(change),
        .dial(dial)
    );

    integer file;
    integer value;
    integer ret;
    reg [8*32-1:0] line;
    reg [7:0] direction;

    initial begin
        current = 50;

        file = $fopen("day1_input.txt", "r");

        if (file == 0) begin
            $display("ERROR: Could not open input.txt");
            $finish;
        end

        while ($fgets(line, file)) begin

    if ($sscanf(line, "%c%d", direction, value) == 2) begin

        if (direction == "L")
            change = (100 - value % 100) % 100;
        else
            change = value % 100;

        #0;
        current = dial;

        if (current == 0)
            zero_count++;

    end
end

        $fclose(file);

        $display("Number of zeros = %0d", zero_count);

        $finish;
    end

endmodule
    