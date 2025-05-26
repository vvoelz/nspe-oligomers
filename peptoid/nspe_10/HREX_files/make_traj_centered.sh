#!/bin/bash
# Need to make adjustment of the input number 
module load gromacs/2021.2

for dir in state_*/; do
  cd "$dir" || continue
  echo "Processing $dir"
  gmx trjconv -f HREMD.part0001.xtc -s HREMD.tpr -n index.ndx -center -pbc whole -o HREMD.part0001_intact.xtc << EOF
22 
22 
EOF
  cd ..
done
