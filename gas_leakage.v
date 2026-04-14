`timescale 1ns / 1ps
module gas_leak_fsm (
    input clk,
    input reset,
    input gas_sensor,
    output reg alarm,
    output reg valve
);

    // States
    parameter SAFE  = 1'b0;
    parameter ALARM = 1'b1;

    reg state, next_state;
    reg ignore_gas;
    reg [1:0] ignore_counter;

    // State register
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= SAFE;
            ignore_counter <= 2;  // ignore for 2 cycles
        end else begin
            state <= next_state;
    
            if (ignore_counter > 0)
                ignore_counter <= ignore_counter - 1;
        end
    end

    // Next state logic
    always @(*) begin
    case (state)

        SAFE: begin
            if (gas_sensor && (ignore_counter == 0))
                next_state = ALARM;
            else
                next_state = SAFE;
        end

        ALARM: begin
            if (reset)
                next_state = SAFE;
            else
                next_state = ALARM;
        end

        default: next_state = SAFE;
    endcase
end

    // Output logic (Moore)
       always @(*) begin
        if (reset) begin
            alarm = 0;
            valve = 1;
        end else begin
            case (state)
                SAFE: begin
                    alarm = 0;
                    valve = 1;
                end
                ALARM: begin
                    alarm = 1;
                    valve = 0;
                end
            endcase
        end
    end
    
endmodule