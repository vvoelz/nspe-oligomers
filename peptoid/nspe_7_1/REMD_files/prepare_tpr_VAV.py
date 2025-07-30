import os, sys
import shutil
import subprocess
import numpy as np



# Parameters
n = 16
required_files = [
    "nspe_7_1.gro",
    "nspe_7_1_nodistre_yesomegas.itp",
    "nspe_7_1.top",
    "chloroform_320_box.itp",
    "prod_remd.mdp",
    "index.ndx"
]

min_temp, max_temp = 300.0, 450.0   # in K

# linearly space the temps by inverse beta
temps = 1./np.linspace(1./min_temp, 1./max_temp, num=n)   

print('replica\ttemp (K)')
for i in range(n):
    print(f'{i}\t{temps[i]:3.2f}')


# Load modules (if needed, e.g., in a job script, not typical from Python)
subprocess.run(["module", "load", "gromacs/2021.2"], shell=True)
subprocess.run(["module", "load", "mpi/openmpi"], shell=True)

# Loop over states
for i in range(n):
    state_dir = f"state_{i}"
    os.makedirs(state_dir, exist_ok=True)
    os.chdir(state_dir)

    # Move and copy files
    for fname in required_files: 
        src = os.path.join("..", fname)
        try:
            shutil.copy(src, ".")
        except FileNotFoundError:
            print(f"Error: Required file '{src}' not found.")
            sys.exit(1)

    # Check all files are present
    for f in required_files:
        if not os.path.isfile(f):
            print(f"Error: Missing file '{f}' in {state_dir}!")
            sys.exit(1)

    # Modify 'init-lambda-state' line in prod_remd.mdp
    with open("prod_remd.mdp", "r") as f:
        lines = f.readlines()

    with open("prod_remd.mdp", "w") as f:
        for line in lines:
            if line.strip().startswith("init-lambda-state"):
                f.write(f"init-lambda-state        = {i}\n")
            elif line.strip().startswith("ref_t"):
                f.write(f"ref_t                   = {temps[i]:3.2f}    {temps[i]:3.2f}\n")
            else:
                f.write(line)

    # Run grompp
    grompp_cmd = [
        "gmx", "grompp",
        "-f", "prod_remd.mdp",
        "-c", "nspe_7_1.gro",
        "-p", "nspe_7_1.top",
        "-n", "index.ndx",
        "-o", "HREMD.tpr",
        "-maxwarn", "1"
    ]
    subprocess.run(grompp_cmd, check=True)

    # Print last few lines of the .mdp file
    print(f"Contents of prod_remd.mdp in {state_dir}:")
    with open("prod_remd.mdp") as f:
        lines = f.readlines()
        print("".join(lines[-10:]))  # Show last 10 lines

    os.chdir("..")

