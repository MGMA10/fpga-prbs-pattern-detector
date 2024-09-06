# FPGA Targeted Design: PRBS-15 Block and Pattern Detector

This project involves the design of a Pseudo-Random Binary Sequence (PRBS-15) generator and a Pattern Detector using Verilog: PRBS-15 Block and Pattern Detector


## Table of Contents
- [Project Description](#project-description)
- [Deliverables](#deliverables)
- [Design Overview](#design-overview)
    - [PRBS-15 Block](#prbs-15-block)
    - [Pattern Detector](#pattern-detector)
    - [Top Module](#top-module)
- [Testbenches](#testbenches)
- [Download](#Download)

## Project Description

This project provides an FPGA-targeted design in Verilog, containing:
- A PRBS-15 block that outputs a custom pseudo-random sequence.
- A pattern detector block that identifies when a specific pattern repeats correctly `n` times.

## Deliverables

1. **Custom PRBS-15 Block**:
   - Takes a 4-byte pattern as input.
   - Outputs these 4 bytes after each other `n` times.
   - Implements a custom PRBS equation with XOR of bit 13 and bit 14.
   
2. **Pattern Detector**:
   - FSM-based.
   - Detects if the pattern is correctly repeated `n` times.
   - Raises a flag once the pattern is found.
   
3. **Top Module**:
   - Integrates the PRBS-15 and Pattern Detector blocks.
   
4. **Testbenches**:
   - Provided for each block and the top-level module to validate the functionality.

## Design Overview

### PRBS-15 Block

This module generates a pseudo-random binary sequence using a custom PRBS-15 equation. It accepts a 32-bit input pattern and repeats it `n` times before applying a shift-left operation with XORing of bit 13 and bit 14 to generate the PRBS sequence.

#### Ports:
- **clk**: Clock signal.
- **rst_n**: Active-low reset signal.
- **pattern_in**: 32-bit input pattern.
- **n_repeats**: 8-bit input specifying the number of times to repeat the pattern.
- **prbs_out**: 8-bit output PRBS sequence.

### Pattern Detector

This block uses a finite state machine (FSM) to detect if a given pattern is repeated `n` times in the input data stream. The FSM transitions between IDLE, MATCHING, and FOUND states to ensure that the pattern is correctly detected.

#### Ports:
- **clk**: Clock signal.
- **rst_n**: Active-low reset signal.
- **data_in**: 8-bit input data stream from the PRBS block.
- **pattern**: 32-bit input pattern to detect.
- **n_repeats**: 8-bit input specifying the number of times the pattern should repeat.
- **pattern_found**: Output flag that is asserted when the pattern is detected.

### Top Module

The top module integrates the PRBS-15 block and the Pattern Detector. It connects the `prbs_out` from the PRBS block to the `data_in` of the Pattern Detector, ensuring that the detector checks the PRBS sequence for repeated patterns.

#### Ports:
- **clk**: Clock signal.
- **rst_n**: Active-low reset signal.
- **pattern_in**: 32-bit input pattern.
- **n_repeats**: 8-bit input specifying the number of repeats.
- **pattern_found**: Output flag indicating if the pattern was detected.

## Testbenches

Testbenches are provided for:
1. **PRBS-15 Block**: Validates the PRBS output for different input patterns and repeat counts.
2. **Pattern Detector**: Tests whether the detector correctly identifies patterns.
3. **Top Module**: Verifies the integration of the PRBS-15 and Pattern Detector blocks.

## Download

1. Clone the repository:
   ```bash
   git clone https://github.com/mgma10/fpga-prbs-pattern-detector.git
