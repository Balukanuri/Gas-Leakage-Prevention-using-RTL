 Gas Leakage Detection and Prevention System (RTL Design)

 Overview

This project implements a "gas leakage detection and prevention system" using "Verilog HDL". The system continuously monitors a gas sensor input and takes immediate safety action by triggering an alarm and shutting off a valve when a leak is detected.

The design is based on a "Finite State Machine (FSM)" with additional logic to handle reset recovery and avoid false re-triggering.



 Objective
 
To design a reliable hardware system that:

* Detects gas leakage in real time
* Activates an alarm signal
* Closes a safety valve
* Handles reset conditions safely
* Prevents false triggering after reset


 Design Architecture

 Inputs:

* `clk` → System clock
* `reset` → Asynchronous reset
* `gas_sensor` → Gas detection signal

 Outputs:

* `alarm` → Indicates gas leakage
* `valve` → Controls gas flow (1 = open, 0 = closed)



 Functional Description

 Normal Condition:

* `gas_sensor = 0`
* Alarm is OFF
* Valve remains OPEN

 Gas Detected:

* `gas_sensor = 1`
* Alarm turns ON
* Valve is CLOSED immediately

 Reset Condition:

* System returns to SAFE state
* Alarm turns OFF
* Valve opens

 Post-Reset Behavior:

* Gas input is ignored for a few clock cycles
* Prevents immediate re-triggering
* Ensures stable system recovery



 RTL Design Details

* **FSM-based control logic**
* States:

  * `SAFE`
  * `ALARM`
* **Synchronous state transitions**
* **Asynchronous reset handling**
* **2-bit ignore counter** for reset stabilization
* Implemented using:

  * Flip-flops (state registers)
  * Combinational logic (LUTs)
  * Multiplexers (MUX)



 Verification

A structured testbench was developed to validate:

* Normal operation
* Gas detection response
* Reset behavior
* Post-reset stability
* Persistent gas conditions

Simulation was performed using **Xilinx Vivado Simulator**, and waveforms were analyzed to confirm correct functionality.


 Results

* Correct detection of gas leakage
* Immediate valve shutdown
* Stable reset recovery
* No false triggering after reset
* Behavior matches real-world safety systems



 Tools Used

* Verilog HDL
* Xilinx Vivado (Simulation & RTL Analysis)



 Key Learnings

* FSM design and implementation
* Synchronous vs asynchronous behavior
* Reset handling in digital systems
* Timing and clock-based logic
* Hardware-level debugging using waveforms
* Translating RTL into gate-level schematic


 Applications

* Industrial gas safety systems
* Smart home automation
* Chemical plant monitoring
* IoT-based safety controllers



 Future Improvements

* Add multi-level gas detection thresholds
* Integrate real sensor interface (ADC)
* Add buzzer/LED driver modules
* Implement wireless alert system
* Extend to multi-zone monitoring


 Conclusion

This project demonstrates a **real-time safety-critical hardware system** designed using RTL principles. It highlights the importance of reliable control logic, proper reset handling, and system-level thinking in VLSI design.
