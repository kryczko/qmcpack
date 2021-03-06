#/bin/bash

SRC="${BASH_SOURCE[0]}"
SRC_DIR="$( cd -P "$( dirname "$SRC" )" >/dev/null 2>&1 && pwd )"
. ${SRC_DIR}/start_spack_env.sh

#temporary change from clang$llvm_vnew

spack load gcc@$gcc_vnew
spack load boost@$boost_vnew%gcc@$gcc_vnew
spack load gcc@$gcc_vnew
spack load hdf5@$hdf5_vnew%gcc@$gcc_vnew~mpi
spack load cmake@$cmake_vnew%gcc@$gcc_vnew
spack load -r openmpi@$ompi_vnew%gcc@$gcc_vnew
spack load fftw@$fftw_vnew%gcc@$gcc_vnew

# GCC_TOOLCHAIN_PATH=$(spack find -p gcc@$gcc_vnew | awk -v gcc_version="gcc@$gcc_vnew" -e '{ if ($1 == gcc_version) { print $2 }}')
# CXXFLAGS="--gcc-toolchain=${GCC_TOOLCHAIN_PATH} -stdlib=libstdc++"
# CFLAGS="--gcc-toolchain=${GCC_TOOLCHAIN_PATH}"
# LDFLAGS="-L${GCC_TOOLCHAIN_PATH}/lib64 -Wl,-rpath,${GCC_TOOLCHAIN_PATH}/lib64"

QMC_IMMUTABLE_FLAGS="-DBUILD_AFQMC=1"
