#!/bin/bash

################################################################
## * This script builds available configurations of QMCPACK   ##
##   on OIC5, at Oak Ridge National Lab.                      ##
##                                                            ##
## * Execute this script in trunk/                            ##
##   ./config/build_ornl_oic.sh                               ##
##                                                            ##
## Last modified: Oct 6, 2017                                 ##
################################################################


module () 
{ 
    eval `/opt/modules/3.1.6/bin/modulecmd bash $*`
}
module purge
module load gcc/4.9.3
module load mpi/openmpi-1.4.5-gcc4
module load hdf5/1.8.8-gcc4-parallel

export LIBXML2_HOME=/home/j1k/share/oic5_gcc4/libxml2-2.7.6/build

CMAKE_FLAGS="-DCMAKE_C_COMPILER=mpicc \ 
             -DCMAKE_CXX_COMPILER=mpicxx"

# Configure and build cpu real AoS
echo ""
echo ""
echo "building qmcpack for cpu AoS real for oic5"
mkdir -p build_cpu_AoS_real_oic
cd build_cpu_AoS_real_oic
cmake $CMAKE_FLAGS ..
make -j 32 
cd ..
ln -sf ./build_cpu_AoS_real_oic/bin/qmcpack ./qmcpack_cpu_AoS_real_oic

# Configure and build cpu complex AoS
echo ""
echo ""
echo "building qmcpack for cpu AoS complex for oic5"
mkdir -p build_cpu_AoS_comp_oic
cd build_cpu_AoS_comp_oic
cmake -DQMC_COMPLEX=1 $CMAKE_FLAGS ..
make -j 32 
cd ..
ln -sf ./build_cpu_AoS_comp_oic/bin/qmcpack ./qmcpack_cpu_AoS_comp_oic


# Configure and build cpu real SoA
echo ""
echo ""
echo "building qmcpack for cpu SoA real for oic5"
mkdir -p build_cpu_SoA_real_oic
cd build_cpu_SoA_real_oic
cmake -DENABLE_SOA=1 $CMAKE_FLAGS ..
make -j 32 
cd ..
ln -sf ./build_cpu_SoA_real_oic/bin/qmcpack ./qmcpack_cpu_SoA_real_oic

# Configure and build cpu complex SoA
echo ""
echo ""
echo "building qmcpack for cpu SoA complex for oic5"
mkdir -p build_cpu_SoA_comp_oic
cd build_cpu_SoA_comp_oic
cmake -DQMC_COMPLEX=1 -DENABLE_SOA=1 $CMAKE_FLAGS ..
make -j 32 
cd ..
ln -sf ./build_cpu_SoA_comp_oic/bin/qmcpack ./qmcpack_cpu_SoA_comp_oic




