`timescale 1ns/1ps

module gas_leak_fsm_tb;

    reg clk;
    reg reset;
    reg gas_sensor;

    wire alarm;
    wire valve;

    // DUT
    gas_leak_fsm uut (
        .clk(clk),
        .reset(reset),
        .gas_sensor(gas_sensor),
        .alarm(alarm),
        .valve(valve)
    );

    // Clock (10ns period)
    always #5 clk = ~clk;

    // Task: Apply reset properly
    task apply_reset;
    begin
        reset = 1;
        #20;   // hold reset for 2 cycles
        reset = 0;
    end
    endtask

    initial begin
        // Init
        clk = 0;
        gas_sensor = 0;

        $display("Starting Simulation...");

        // Case 1: Initial reset
        apply_reset();

        // Case 2: Normal condition
        #20 gas_sensor = 0;

        // Case 3: Gas leak
        #20 gas_sensor = 1;

        // Case 4: Reset while gas still present
        #40 apply_reset();

        // Case 5: Gas removed
        #40 gas_sensor = 0;

        // Case 6: Gas again
        #40 gas_sensor = 1;

        #100 $finish;
    end

endmodule