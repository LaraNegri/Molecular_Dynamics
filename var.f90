subroutine var()
        use globals
        integer :: k

        do k=1,Nsteps
                pnor = pnor + p
        end do

        var = (p/Nsteps-(p**2)/Nsteps)**0.5
end subroutine
