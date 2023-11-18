subroutine lgv_force()
        use globals
        use ziggurat
        !. Computo la fuerza de Langevin
        integer :: i
        real(kind=8) :: gamma_lgv, sigma_lgv, dt

        gamma_lgv = 0.5
        dt = t_sim/real(N)
        sigma_lgv = -sqrt((2*T*gamma_lgv*m)/dt)

        do i = 1,N
                f(1,i) = f(1,i) - gamma_lgv*v(1,i) + sigma_lgv*rnor()
                f(2,i) = f(2,i) - gamma_lgv*v(2,i) + sigma_lgv*rnor()
                f(3,i) = f(3,i) - gamma_lgv*v(3,i) + sigma_lgv*rnor()
        end do
end subroutine lgv_force
