# Trajectory Extraction and Clustering Workflow

## 1. Extract Trajectory from Simulation

- Extract the trajectory files from simulation outputs.
- Save the processed trajectory data in the `traj_data/` directory.

📘 **Reference:** Follow the code provided in [`traj_analysis.ipynb`](./traj_analysis.ipynb) for detailed steps and parameter settings.

---

## 2. Clustering the Trajectory of State 0 (Unbiased State)

- Focus on the trajectory corresponding to **state 0** (the unbiased ensemble).
- Perform clustering based on **omega** and **phi** dihedral angle features.
- Apply **RMSD-based distance filtering** to refine the clusters.
- Sample representative structures from each cluster for downstream analysis.

📘 **Reference:** Use the procedures outlined in [`clustering_by_angle.ipynb`](./clustering_by_angle.ipynb).

---

## 3. Cluster Selection Assisted by BICePs

- Use **BICePs** to aid in selecting the most representative or relevant clusters.
- Navigate to the `biceps_scripts/` directory and run the provided notebook to perform BICePs-based evaluation and selection.

---
