subroutine Ec_calc()
        use globals
        integer :: k
        !. Computo la energía cinética del sistema
        Ec = 0
        do k=1,N
                Ke =m*(0.5*(v(1,k))**2 + 0.5*(v(2,k))**2 + 0.5*(v(3,k))**2)
                Ec = Ec + Ke
        end do

        Ec = Ec/N
end subroutine Ec_calc
