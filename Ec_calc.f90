subroutine Ec_calc()
        use globals
        integer :: k
        !. Computo la energía cinética del sistema
        Ec = 0
        do k=1,N
                Ke =0.5*m*((v(1,k))**2 + (v(2,k))**2 + (v(3,k))**2)
                Ec = (Ec + Ke)
        end do

        !print *, Ec
end subroutine Ec_calc
