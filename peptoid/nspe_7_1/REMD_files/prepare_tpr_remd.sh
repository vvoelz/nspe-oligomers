#!/bin/bash

# Load GROMACS and MPI modules
module load gromacs/2021.2
module load mpi/openmpi

# Number of replicas
n=16

# Minimum and maximum temperature
min_temp=300.0
max_temp=450.0

# Compute inverse temperature spacing (like NumPy)
declare -a temps
inv_min=$(awk "BEGIN {print 1.0/$min_temp}")
inv_max=$(awk "BEGIN {print 1.0/$max_temp}")

for ((i=0; i<n; i++)); do
    frac=$(awk "BEGIN {print $i/($n-1)}")
    inv_temp=$(awk "BEGIN {print $inv_min + ($inv_max - $inv_min)*$frac}")
    temp=$(awk "BEGIN {printf \"%.2f\", 1.0/$inv_temp}")
    temps[$i]=$temp
done

# Print the temperature schedule
echo "replica  temp (K)"
for ((i=0; i<n; i++)); do
    echo "$i      ${temps[$i]}"
done

# Loop over the states
for ((i=0; i<n; i++)); do
  mkdir -p state_${i}
  cd state_${i} || exit 1

  # Copy required files
  #cp ../nspe_7_1.gro .
  mv HREMD.part0001.gro nspe_7_1.gro  ## Uncomment for continuous simulation
  cp ../nspe_7_1_nodistre_yesomegas.itp .
  cp ../nspe_7_1.top .
  cp ../chloroform_320_box.itp .
  cp ../prod_remd.mdp .
  cp ../index.ndx .

  # Check file existence
  required_files=(
    "nspe_7_1.gro"
    "nspe_7_1_nodistre_yesomegas.itp"
    "nspe_7_1.top"
    "chloroform_320_box.itp"
    "prod_remd.mdp"
    "index.ndx"
  )
  for file in "${required_files[@]}"; do
    if [ ! -f "$file" ]; then
      echo "Error: Missing file '$file' in state_${i}!"
      exit 1
    fi
  done

  # Modify .mdp file
  temp=${temps[$i]}
  sed -i -e "s/^init-lambda-state[[:space:]]*=.*/init-lambda-state        = ${i}/" prod_remd.mdp
  sed -i -e "s/^ref_t[[:space:]]*=.*/ref_t                   = $temp    $temp/" prod_remd.mdp

  # Run GROMACS preprocessor
  gmx grompp -f prod_remd.mdp -c nspe_7_1.gro -p nspe_7_1.top -n index.ndx -o HREMD.tpr -maxwarn 1

  # Show last 10 lines of .mdp
  echo "Contents of prod_remd.mdp in state_${i}:"
  tail -n 10 prod_remd.mdp

  cd ..
done

