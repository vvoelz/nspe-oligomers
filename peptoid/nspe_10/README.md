
# 🧪 Running Workflow: Restrained Molecular Dynamics Simulations

This document outlines the complete procedure for setting up and running restrained molecular dynamics (MD) simulations, including:

- Topology generation  
- Energy minimization  
- Restraint preparation  
- Lambda optimization  
- Replica exchange molecular dynamics (REMD) simulations

---

## ✅ Step-by-Step Instructions

### 1. 📦 Generate Amber Topology Files

- Run the `runme` script in the current directory.
- The topology file `nspe_10.top` is generated from STEPs residues.
- **ACPYPE** is used to convert the molecular structure into Amber-compatible topology and coordinate files.

---

### 2. ⚙️ Energy Minimization & Equilibration

- Navigate to the `minimization/` directory and run the `runme` script.

This performs:
- **EM**: Energy minimization  
- **NVT**: Constant volume and temperature equilibration  
- **NPT**: Constant pressure and temperature equilibration

> These steps ensure a stable MD setup under realistic conditions.

---

### 3. ⏱ Short MD Production Run

- Go to the `1ns/` directory and run the `runme` script.
- Use the output from the NPT step to run a **1 ns production MD**.

> This trajectory is used for restraint validation and initial lambda optimization.

---

### 4. 🧬 Restraint File Preparation

- Open and run the notebook: `../untils/restraints_editor.ipynb`
- Convert human-readable CSV restraint files to atom-indexed format.

Additional tasks:
- Manually edit **omega angle biases** (if needed)
- Generate **distance restraint** files for HREX using the converted outputs

---

### 5. 🔁 Lambda Optimization & HREX (200 ns)

1. Run the `pylambda` optimizer **twice**, each followed by a **1 ns HREX** run.
2. Use the optimized lambda values for the final REMD simulation.
3. All input files are in the `HREX_files/` directory.

```
# Prepare replicas
bash prepare_tpr.sh

# Submit to HPC (or run the commands inside manually)
qsub fep.qsub
```

---

### 6. 🔄 REMD Productive Simulation

- Perform REMD using topologies and coordinates from the HREX step.
- Validate backbone and omega angles against **NMR structural data**.
- Input files are stored in `REMD_files/`.

```
# Prepare REMD replicas
bash prepare_tpr_remd.sh

# Submit to HPC (or run the commands inside manually)
qsub remd.qsub
```

---

### 7. 📊 Analysis

- All post-simulation analysis is performed in the `analysis/` directory.

---

## 📝 Notes

- Keep **lambda windows** consistent across HREX and REMD.
- Ensure restraints and biases align with **experimental data** (e.g., NOEs, J-couplings).
