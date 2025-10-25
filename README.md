# ⏱ Two-Mode Timer (Verilog HDL on Intel DE10-Lite FPGA)

## 📌 Overview
The **Two-Mode Timer** is a digital hardware system implemented in **Verilog HDL** using a **hierarchical RTL design framework**. The project is deployed on the **Intel DE10-Lite MAX10 FPGA development board** using the **Intel Quartus Prime toolchain** and verified using **ModelSim**.

The system operates in two selectable modes:
- **Mode A – Stopwatch:** Counts **upwards** from `00.00` to `99.99` using a **100 Hz clock**
- **Mode B – Countdown Timer:** Counts **downwards** from `2:00` to `00:00` using a **1 Hz clock**

A control signal allows the user to **toggle between run and pause**, while a **reset signal** restores the timer to its initial value depending on the selected mode. The output is displayed in real-time using the onboard **seven-segment displays**.

---

## 🎯 Project Objectives
- Demonstrate **digital logic design** using Verilog
- Implement **clock division, counter logic, and display control**
- Apply **structural RTL design methodology** using modular subcomponents
- Gain experience in **FPGA synthesis and simulation-based verification**
- Interface with **hardware displays and physical user inputs**

---

## 🔧 System Architecture
The design is organised into the following modules:

| Module     | Description |
|-----------|-------------|
| **ClockDivider** | Converts 50 MHz input clock into 1 Hz and 100 Hz timing signals |
| **ProgramCounter** | Handles counting with load/reset functionality |
| **TimerCoreLogic** | Integrates program counters and controls timer operation |
| **Reverser** | Changes count direction based on selected mode |
| **SevenSegEncoder** | Converts binary timer output to seven-segment display signals |
| **MainCode (Top Level)** | Connects all submodules and interfaces with FPGA hardware |

---

## 🛠 Tools & Technologies
- **Hardware Description Language:** Verilog
- **FPGA Toolchain:** Intel Quartus Prime Lite
- **Simulation:** ModelSim / Questa
- **Hardware Platform:** Intel DE10-Lite (MAX10 FPGA)
- **Design Methodology:** RTL structural design with hardware testbenches

---

## 🧪 Simulation & Verification
Each module is paired with a dedicated **testbench** to validate:
- Correct counting behaviour in both modes
- Clock signal generation and reset functionality
- Seven-segment display output accuracy
- Module interconnections and hierarchical integration

---

## 🚀 How to Run on FPGA
1. Open the project in **Intel Quartus Prime**
2. Add all Verilog `.v` files and corresponding testbenches
3. Assign pins according to the DE10-Lite pin configuration
4. Compile the project to generate the bitstream
5. Upload the bitstream to the FPGA using USB-Blaster
6. Use hardware switches to control:
   - `ModeSel`: Select stopwatch or countdown mode
   - `StartStop`: Toggle run/pause
   - `Reset`: Return to default time

---

## 📎 File Structure
├── MainCode.v # Top-level module
├── ClockDivider.v # Clock division logic
├── TimerCoreLogic.v # Controls operational modes and timing
├── ProgramCounter.v # Core counter with load/reset
├── Reverser.v # Direction control for count-down mode
├── BCDtoSevenSeg.v # Binary to seven-segment conversion
├── *_tb.v # Testbench files
└── README.md # Project documentation
