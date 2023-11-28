subroutine T_calc()
        use globals
        integer :: k

        do k=1,N-1
                T_est = ((1./3.)*m*v**2)/kB
        end do

end subroutine T_calc
