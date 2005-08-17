//////////////////////////////////////////////////////////////////
// (c) Copyright 2003  by Jeongnim Kim
//////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////
//   National Center for Supercomputing Applications &
//   Materials Computation Center
//   University of Illinois, Urbana-Champaign
//   Urbana, IL 61801
//   e-mail: jnkim@ncsa.uiuc.edu
//   Tel:    217-244-6319 (NCSA) 217-333-3324 (MCC)
//
// Supported by 
//   National Center for Supercomputing Applications, UIUC
//   Materials Computation Center, UIUC
//////////////////////////////////////////////////////////////////
// -*- C++ -*-
/**@file QMCHamiltonianBase.h
 *@brief Declaration of QMCHamiltonianBase
 */
#ifndef OHMMS_QMC_HAMILTONIANBASE_H
#define OHMMS_QMC_HAMILTONIANBASE_H

#include "Particle/ParticleSet.h"
#include "Utilities/PooledData.h"
#include <bitset>

namespace ohmmsqmc {

  /**@defgroup hamiltonian Hamiltonian group
   * @brief QMCHamiltonian and its component, QMCHamiltonianBase
   */

  class DistanceTableData;

  /** @ingroup hamiltonian
   * @brief An abstract class for Local Energy operators 
   *
   * Return_t is defined as RealTye. 
   * The types should be checked when using complex wave functions.
   */ 
  struct QMCHamiltonianBase: public QMCTraits {
    
    /** type of return value of evaluate
     */
    typedef RealType Return_t;

    enum {PRIMARY, OPTIMIZABLE, RATIOUPDATE};
    bitset<3> UpdateMode;
 
    RealType Tau;
    RealType Value;
   
    ///constructor
    QMCHamiltonianBase():Tau(0.0),Value(0.0){
      UpdateMode.set(PRIMARY,1);
    }

    ///virtual destructor
    virtual ~QMCHamiltonianBase() { }

    /** Evaluate the local energies of an N-particle configuration
     *@param P input configuration containing N particles
     *@return the value of the Hamiltonian
     */
    virtual Return_t evaluate(ParticleSet& P) = 0; 

    /** read the input parameter
     * @param cur xml node for a QMCHamiltonianBase object
     */
    virtual bool put(xmlNodePtr cur)=0;
    
    /** set Tau
     * @param tau time step
     */
    inline void setTau(RealType tau) { Tau = tau;}

    /** return the mode i
     * @param i index among PRIMARY, OPTIMIZABLE, RATIOUPDATE
     */
    inline bool getMode(int i) { return UpdateMode[i];}
  };
}
#endif

/***************************************************************************
 * $RCSfile$   $Author$
 * $Revision$   $Date$
 * $Id$ 
 ***************************************************************************/

