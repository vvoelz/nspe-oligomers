#!/bin/bash

# Load GROMACS and MPI modules
module load gromacs/2021.2
module load mpi/openmpi

# Number of alchemical intermediate states
n=8

# Define fep-lambdas values
fep_lambdas=(0.00  0.10  0.20  0.32  0.46  0.62  0.80  1.0)

# Loop over the states
for ((i=0; i<n; i++))
do
  # Create a directory for each state and change into it
  mkdir -p state_${i} && cd state_${i}

  # Copy the necessary input files into the directory
  cp ../nspe_7_1.gro .
  # mv HREMD.part0001.gro nspe_7_1.gro  ## Uncomment for continuous simulation
  cp ../nspe_7_1_re.itp .
  cp ../nspe_7_1.top .
  cp ../chloroform_320_box.itp .
  cp ../prod_fep.mdp .
  cp ../index.ndx .  

  # Check if all required files exist
  required_files=(
    "nspe_7_1.gro"
    "nspe_7_1_re.itp"
    "nspe_7_1.top"
    "chloroform_320_box.itp"
    "prod_fep.mdp"
    "index.ndx"
  )

  for file in "${required_files[@]}"; do
    if [ ! -f "$file" ]; then
      echo "Error: Missing file '$file' in state_${i} directory!"
      exit 1
    fi
  done

  # Get the lambda value for the current state (not strictly used but optional)
  lambda_value=${fep_lambdas[$i]}

  # Modify the init-lambda-state in the prod_fep.mdp file
  sed -i -e "s/^init-lambda-state[[:space:]]*=.*/init-lambda-state        = ${i}/" prod_fep.mdp
  
  # Run the GROMACS preprocessor
  gmx grompp -f prod_fep.mdp -c nspe_7_1.gro -p nspe_7_1.top -n index.ndx -o HREMD.tpr -maxwarn 1

  # Print out the last few lines of the modified prod_fep.mdp file
  echo "Contents of prod_fep.mdp in state_${i}:"
  tail prod_fep.mdp

  # Navigate back to the parent directory
  cd ..
done
