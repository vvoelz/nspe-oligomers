
# 🧬 NSPE-Oligomers

**Structural and analytical data repository for N-substituted polyethylenimines (NSPE) oligomers.**

This repository serves as a centralized hub for NMR assignments, trajectory analysis, and computational utilities for distance-restrained Hamiltonian Replica Exchange (HREX) simulations.

---

## 🏗️ Chemical Structure

*Overview of the NSPE scaffold and side-chain configurations.*

---

## 📂 Repository Organization

| Directory | Content Description |
| --- | --- |
| [`/nmr_assignment`](https://www.google.com/search?q=./nmr_assignment/) | NMR restraint calculations and intensity assignment Excel sheets. |
| [`/peptoid`](https://www.google.com/search?q=./peptoid/) | Trajectory analysis scripts for specific sequences (`nspe-7-1`, `nspe-7-2`, `nspe-10`). |
| [`/STEPs`](https://www.google.com/search?q=./STEPs/) | Building blocks and truncated STEP files for peptoid construction. |
| [`/utils`](https://www.google.com/search?q=./utils/) | Scripts for data parsing and HREX simulation setup. |

---

## 🧪 Peptoid Construction from STEPs

To streamline the workflow, we utilize truncated **STEP files** to assemble the oligomer chains.

> [!NOTE]
> The files in the `./STEPs` directory are truncated versions intended for demonstration of the assembly logic and parameterization.

---

## 📊 Analysis & Simulation Workflow

### NMR Assignments

Detailed mapping of chemical shifts and NOE-derived distance restraints:

* **Calculations:** Automated restraint derivation from peak intensities.
* **Assignments:** High-resolution mapping of the NSPE backbone and side-chains.

### Trajectory Analysis

Post-processing scripts are provided for the following validated structures:

1. **nspe-7-1** & **nspe-7-2**: (Heptamers)
2. **nspe-10**: (Decamer)

### Computational Utilities

Located in `/utils`, these scripts automate the preparation of:

* Input data parsing for MD engines.
* **HREX Setup:** Generation of topology and restraint files for distance-restrained HREX simulations.

---

## 📬 Contact & Citation


