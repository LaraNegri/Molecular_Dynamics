subroutine T_calc()
        use globals
        integer :: k

        do k=1,N-1
                T_est = ((float(1)/float(3))*m*(v(1,k)**2+v(2,k)**2 + v(3,k)**2))/kB
        end do

end subroutine T_calc
