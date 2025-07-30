# Running Workflow

This document outlines the complete procedure for setting up and running restrained molecular dynamics (MD) simulations, including topology generation, energy minimization, restraint preparation, lambda optimization, and replica exchange molecular dynamics (REMD) simulations.

---

## Step-by-Step Instructions

### 1. Generate Amber Topology Files

- Run the `runme` script in the current directory.
- The topology file `nspe_7_1.top` is generated from STEPs residues.
- ACPYPE is used to convert the molecular structure into Amber-compatible topology and coordinate files.

### 2. Energy Minimization and Equilibration

- Navigate to the `minimization/` directory and run the `runme` script.
- This script performs:

  - **EM**: Energy minimization  
  - **NVT**: Constant volume and temperature equilibration  
  - **NPT**: Constant pressure and temperature equilibration

These steps prepare the system for stable MD under realistic simulation conditions.

### 3. Short MD Production Run

- Navigate to the `1ns/` directory and run the `runme` script.
- Use the output structure from the NPT step to run a 1 ns production MD simulation.
- This trajectory will be used for restraint validation and initial lambda optimization.

### 4. Restraint File Preparation

- Use the notebook at `../untils/restraints_editor.ipynb` to convert human-readable restraint CSV files into atom-indexed formats.

Additional tasks:
- Manually edit omega angle biases if required.
- Generate distance restraint files for HREX simulations using the converted outputs.

### 5. Lambda Optimization and HREX RUN for 200 ns 

- Run the `pylambda` optimizer twice, each followed by a 1 ns HREX simulation.
- The optimized lambda values obtained are reused for the final REMD simulation.
- All input files for HREX are organized in the `HREX_files/` directory.
- 

### 6. REMD Productive Simulation

- Perform the REMD production run using the topologies and coordinates prepared during the HREX step.
- The resulting backbone and omega angle conformations should match those expected from NMR structural data.
- All input and configuration files for REMD are stored in the `REMD_files/` directory.

### 7. Analysis

- All post-simulation analyses are performed in the `analysis/` directory.

---

## Notes

- Ensure consistent use of lambda windows across both HREX and REMD.
- Restraint files and bias parameters should align with experimental data (e.g., NOEs, J-couplings).
