subroutine init ()
        use ziggurat
        use globals
        integer :: i
        real(kind=8) :: x,y,z    
        do i = 1, N
                !.Sorteo posiciones (x,y,z) 
                x = (2*uni()-1)*L/2
                y = (2*uni()-1)*L/2
                z = (2*uni()-1)*L/2
                !. Lo coloco en el vector r(:,N)
                r(1,i) = x
                r(2,i) = y
                r(3,i) = z

                !. Inicializo velocidades en el vector v(:,N)
                v(1,i) = (T**0.5)*rnor()
                v(2,i) = (T**0.5)*rnor()
                v(3,i) = (T**0.5)*rnor()
         end do
        
end subroutine init
