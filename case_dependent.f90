MODULE case_dependent
!
! Author: Jacopo Canton
! E-mail: jcanton@mech.kth.se
! Last revision: 13/6/2014
!
! This module contains routines which are case dependent and can be adapted
! to suit the needs of a particular flow analysis.
! The idea is to have here ALL what is case dependent so that it's more
! difficult to make stupid memory mistakes to the core of the program.
!
   USE global_variables
   USE miscellaneous_subroutines
   USE axisym_boundary_values

!------------------------------------------------------------------------------

   IMPLICIT NONE


CONTAINS
!------------------------------------------------------------------------------

SUBROUTINE case_problemset()
!
! Author: Jacopo Canton
! E-mail: jcanton@mech.kth.se
! Last revision: 13/6/2014
!
! This routine is executed after reading the 'problem_data.in' file

   IMPLICIT NONE
   ! input variables
   ! output variables
   ! local variables

   ! executable statements
   WRITE(*,*) '--> call to: case_problemset'

   !***coaxial jets
   IF (flow_parameters(1) /= 0d0) THEN
      WRITE(*,*) '    assigning velocity ratio based on header input'
      in_bvs_D(1,1,2) = 1d0
      in_bvs_D(1,5,2) = flow_parameters(1)
   ENDIF


   WRITE(*,*) '    done: case_problemset'
   WRITE(*,*)
END SUBROUTINE case_problemset

!------------------------------------------------------------------------------

SUBROUTINE case_preprocess()
!
! Author:
! E-mail:
! Last revision:
!
! This routine is executed before the analysis starts but after the program
! initialization

   IMPLICIT NONE
   ! input variables
   ! output variables
   ! local variables
   ! executable statements

   WRITE(*,*) '--> call to: case_preprocess'
   WRITE(*,*) '    done: case_preprocess'
   WRITE(*,*)
END SUBROUTINE case_preprocess

!++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

SUBROUTINE case_newton_iteprocess()
!
! Author:
! E-mail:
! Last revision:
!
! This routine is called inside the nonlinear solver (Newton's method) before
! the generation of the right-hand side and Jacobian matrix

   IMPLICIT NONE
   ! input variables
   ! output variables
   ! local variables
   REAL(KIND=8) :: Ub
   REAL(KIND=8), DIMENSION(velCmpnnts) :: u_avg
   REAL(KIND=8), SAVE :: f0, Ub0=313d0

   ! executable statements
   WRITE(*,*) '--> call to: case_newton_iteprocess'

   !***torus
   Ub = 1d0
   CALL computeFieldAverage(u0,  u_avg)
   WRITE(*,*) '--> Average velocity field'
   WRITE(*,*) '    avg(u_z) = ', u_avg(1)
   WRITE(*,*) '    avg(u_r) = ', u_avg(2)
   WRITE(*,*) '    avg(u_t) = ', u_avg(3)
   IF (Ub0 /= 313d0) THEN
      ! secant method
      volumeForcing(3,2) = volumeForcing(3,2) - u_avg(3)*(volumeForcing(3,2)-f0)/(u_avg(3)-Ub0)
   ELSE
      volumeForcing(3,2) = volumeForcing(3,2) + (Ub - u_avg(3)) * 0.1
   ENDIF
   f0  = volumeForcing(3,2)
   Ub0 = u_avg(3)
   WRITE(*,*) '    force = ', f0

   WRITE(*,*) '    done: case_newton_iteprocess'
   WRITE(*,*)
END SUBROUTINE case_newton_iteprocess

!++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

SUBROUTINE case_postprocess_analysis1()
!
! Author: Jacopo Canton
! E-mail: jcanton@mech.kth.se
! Last revision: 13/6/2014
!
! This routine is executed after analysis 1:
! Steady state computation

   IMPLICIT NONE
   ! input variables
   ! output variables
   ! local variables
   REAL(KIND=8), DIMENSION(velCmpnnts) :: u_avg

   ! executable statements
   WRITE(*,*) '--> call to: case_postprocess_analysis1'

   !***torus
   CALL computeFieldAverage(uu,  u_avg)
   WRITE(*,*)
   WRITE(*,*) '--> Average velocity field'
   WRITE(*,*) '    avg(u_z) = ', u_avg(1)
   WRITE(*,*) '    avg(u_r) = ', u_avg(2)
   WRITE(*,*) '    avg(u_t) = ', u_avg(3)


   WRITE(*,*) '    done: case_postprocess_analysis1'
   WRITE(*,*)
END SUBROUTINE case_postprocess_analysis1

!------------------------------------------------------------------------------

SUBROUTINE case_postprocess_analysis3()
!
! Author:
! E-mail:
! Last revision:
!
! This routine is executed after analysis 3:
! Eigenvalue computation on an already computed base flow

   IMPLICIT NONE
   ! input variables
   ! output variables
   ! local variables

   ! executable statements
   WRITE(*,*) '--> call to: case_postprocess_analysis3'
   WRITE(*,*) '    done: case_postprocess_analysis3'
   WRITE(*,*)
END SUBROUTINE case_postprocess_analysis3

!------------------------------------------------------------------------------

SUBROUTINE case_postprocess_analysis4()
!
! Author:
! E-mail:
! Last revision:
!
! This routine is executed after analysis 4:
! Structural sensitivity analysis on an already computed base flow, and already
! computed both direct and adjoint eigenvectors

   IMPLICIT NONE
   ! input variables
   ! output variables
   ! local variables

   ! executable statements
   WRITE(*,*) '--> call to: case_postprocess_analysis4'
   WRITE(*,*) '    done: case_postprocess_analysis4'
   WRITE(*,*)
END SUBROUTINE case_postprocess_analysis4

!------------------------------------------------------------------------------

SUBROUTINE case_postprocess_analysis5()
!
! Author:
! E-mail:
! Last revision:
!
! This routine is executed after analysis 5:
! Transient growth computation on an already computed base flow

   IMPLICIT NONE
   ! input variables
   ! output variables
   ! local variables

   ! executable statements
   WRITE(*,*) '--> call to: case_postprocess_analysis5'
   WRITE(*,*) '    done: case_postprocess_analysis5'
   WRITE(*,*)
END SUBROUTINE case_postprocess_analysis5

!------------------------------------------------------------------------------

SUBROUTINE case_postprocess_analysis6()
!
! Author:
! E-mail:
! Last revision:
!
! This routine is executed after analysis 6
! DNS

   IMPLICIT NONE
   ! input variables
   ! output variables
   ! local variables

   ! executable statements
   WRITE(*,*) '--> call to: case_postprocess_analysis6'
   WRITE(*,*) '    done: case_postprocess_analysis6'
   WRITE(*,*)
END SUBROUTINE case_postprocess_analysis6

!------------------------------------------------------------------------------

SUBROUTINE case_postprocess_analysis7()
!
! Author:
! E-mail:
! Last revision:
!
! This routine is executed after analysis 7
! Evolution of optimal linear perturbations an already computed base flow

   IMPLICIT NONE
   ! input variables
   ! output variables
   ! local variables

   ! executable statements
   WRITE(*,*) '--> call to: case_postprocess_analysis7'
   WRITE(*,*) '    done: case_postprocess_analysis7'
   WRITE(*,*)
END SUBROUTINE case_postprocess_analysis7

!++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

SUBROUTINE case_loca_paramout()
!
! Author: Jacopo Canton
! E-mail: jcanton@mech.kth.se
! Last revision: 13/6/2014
!
! This routine is executed when LOCA has converged on a steady solution
! and saves the results

   IMPLICIT NONE
   ! input variables
   ! output variables
   ! local variables
   INTEGER           :: fid = 23
   REAL(KIND=8), DIMENSION(velCmpnnts) :: u_avg

   ! executable statements
   WRITE(*,*) '--> call to: case_loca_paramout'

   !***torus
   CALL extract (xx,  uu)
   CALL computeFieldAverage(uu,  u_avg)
   WRITE(*,*)
   WRITE(*,*) '--> Average velocity field'
   WRITE(*,*) '    avg(u_z) = ', u_avg(1)
   WRITE(*,*) '    avg(u_r) = ', u_avg(2)
   WRITE(*,*) '    avg(u_t) = ', u_avg(3)

   OPEN(UNIT= fid, FILE='./locaOut/paramsUb.dat', ACCESS= 'APPEND')
   WRITE(fid,*) Re, flow_parameters(1), flow_parameters(2), flow_parameters(3), u_avg(1), u_avg(2), u_avg(3)
   CLOSE(fid)


   WRITE(*,*) '    done: case_loca_paramout'
   WRITE(*,*)
END SUBROUTINE case_loca_paramout

!------------------------------------------------------------------------------

SUBROUTINE case_loca_changeOscar(oscar)
!
! Author: Jacopo Canton
! E-mail: jcanton@mech.kth.se
! Last revision: 13/6/2014
!
! This routine is executed when LOCA needs to change parameter Oscar

   IMPLICIT NONE
   ! input variables
   REAL(KIND=8), INTENT(IN) :: oscar
   ! output variables
   ! local variables

   ! executable statements
   WRITE(*,*) '--> call to: case_loca_changeOscar'

   !***coaxial jets
   in_bvs_D(1,1,2) = 1d0
   in_bvs_D(1,5,2) = oscar
   CALL gen_dirichlet_boundary_values (rr, sides, Dir, jjs, js_D, in_bvs_D, bvs_D)


   WRITE(*,*) '    done: case_loca_changeOscar'
   WRITE(*,*)
END SUBROUTINE case_loca_changeOscar

!------------------------------------------------------------------------------

SUBROUTINE case_loca_changeRomeo(romeo)
!
! Author:
! E-mail:
! Last revision:
!
! This routine is executed when LOCA needs to change parameter Romeo

   IMPLICIT NONE
   ! input variables
   REAL(KIND=8), INTENT(IN) :: romeo
   ! output variables
   ! local variables

   ! executable statements
   WRITE(*,*) '--> call to: case_loca_changeRomeo'
   WRITE(*,*) '    done: case_loca_changeRomeo'
   WRITE(*,*)
END SUBROUTINE case_loca_changeRomeo

!------------------------------------------------------------------------------

SUBROUTINE case_loca_changeWhisky(whisky)
!
! Author:
! E-mail:
! Last revision:
!
! This routine is executed when LOCA needs to change parameter Whisky

   IMPLICIT NONE
   ! input variables
   REAL(KIND=8), INTENT(IN) :: whisky
   ! output variables
   ! local variables

   ! executable statements
   WRITE(*,*) '--> call to: case_loca_changeWhisky'
   WRITE(*,*) '    done: case_loca_changeWhisky'
   WRITE(*,*)
END SUBROUTINE case_loca_changeWhisky


!==============================================================================

END MODULE case_dependent