subroutine init ()
        use ziggurat
        use globals
        integer :: i
        real(kind=8) :: x,y,z    
        do i = 1, N
                !.Sorteo posiciones (x,y,z) 
                x = L*uni() !(2*uni()-1)*L/2
                y = L*uni() !(2*uni()-1)*L/2
                z = L*uni() !(2*uni()-1)*L/2
                !. Lo coloco en el vector r(:,N)
                r(1,i) = x
                r(2,i) = y
                r(3,i) = z

                !. Inicializo velocidades en el vector v(:,N)
                v(1,i) = 0.0001 !(T**0.5)*rnor()
                v(2,i) = 0.0001 !(T**0.5)*rnor()
                v(3,i) = 0.0001 !(T**0.5)*rnor()
         end do
        
end subroutine init
