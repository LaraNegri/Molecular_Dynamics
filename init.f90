subroutine init ()
        use ziggurat
        use globals
        integer :: i
        real(kind=8) :: x,y,z    
        do i = 1, N
                !.Sorteo posiciones (x,y,z) 
                x = uni()*L
                y = uni()*L
                z = uni()*L
                !. Lo coloco en el vector r(:,N)
                r(1,i) = x
                r(2,i) = y
                r(3,i) = z
         end do

end subroutine init
