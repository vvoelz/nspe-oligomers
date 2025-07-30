# Utils

This directory contains utility scripts and notebooks for preparing distance-restrained HREX simulations and processing NMR restraint data.

---

## Restraints Editor

### File: `restraints_editor.ipynb`

This Jupyter notebook reads NMR restraint files in a human-readable format and outputs atom-indexed restraint files suitable for use in HREX simulations.

### Input

Files located in `restraints_file/`:

- `nspe_7_1_res.csv`
- `nspe_7_2_res.csv`
- `nspe_10_res.csv`

Each file contains proton pairs and distance restraints in a human-readable format.

### Output

Generated restraint files:

- `nspe_7_1_restraints.csv`
- `nspe_7_2_restraints.csv`
- `nspe_10_restraints.csv`

These files map the proton pairs to their corresponding atomic indices and include the restraint values. They are formatted for direct use in simulation input.
