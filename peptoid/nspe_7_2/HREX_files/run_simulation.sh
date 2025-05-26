# Load the necessary modules
module load gromacs/2021.2
module load mpi/openmpi

# Define the state directories for the multidir flag
state_dirs=$(echo state_{0..3} | tr ' ' ' ')

# Run the GROMACS mdrun with MPI
mpirun -np 4 mdrun_mpi -deffnm HREMD -dhdl dhdl.xvg -replex 5000 -multidir $state_dirs -noappend
