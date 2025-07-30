#!/bin/bash
for dir in state_*/; do
  cd "$dir" || continue
  echo "Processing $dir"

  # Step 1: Center and unwrap the trajectory
  gmx trjconv -f HREMD.part0001.xtc -s HREMD.tpr -n index.ndx -center -pbc whole -o HREMD.part0001_intact.xtc << EOF
22
22
EOF

#  # Step 2: Extract only the peptoid from the corresponding .gro structure
#  gmx trjconv -f HREMD.part0001.gro -s HREMD.tpr -n index.ndx -o HREMD.part0001_peptoid_only.gro << EOF
#22
#EOF

  cd ..
done
