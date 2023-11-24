subroutine force()
        use globals
        integer :: i,j
        real(kind=8) :: distance,fuerza,delta_r(3)
        !.Inicializo en 0 el potencial y la fuerza total sobre cada particula 
        Vtotal=0
        f=0
       !.Loop sobre todos los pares de particulas
        do i=1,N-1
            do j=i+1,N
                delta_r(1)=(r(1,i)-r(1,j))
                delta_r(2)=(r(2,i)-r(2,j))
                delta_r(3)=(r(3,i)-r(3,j))
                !.Inserto las PBC considerando L/2
                delta_r(1)=delta_r(1)-L*int(2.0*delta_r(1)/L)
                delta_r(2)=delta_r(2)-L*int(2.0*delta_r(2)/L)
                delta_r(3)=delta_r(3)-L*int(2.0*delta_r(3)/L)
 
                distance = sqrt(delta_r(1)**2+delta_r(2)**2+delta_r(3)**2)

                if (distance .LE. rc) then
                        Vtotal= Vtotal + 4*epsilonn*(-(sigma/distance)**6+(sigma/distance)**12)-V_rc
                        fuerza = 24*epsilonn*(-(sigma/distance)**6+2*(sigma/distance)**12)/distance

                        !.Fuerzas en x
                        f(1,i) = f(1,i)+fuerza * delta_r(1)/distance
                        f(1,j)=f(1,j)-fuerza * delta_r(1)/distance
                        !.Fuerzas en y
                        f(2,i) = f(2,i)+fuerza * delta_r(2)/distance
                        f(2,j)=f(2,j)-fuerza * delta_r(2)/distance
                        !.Fuerzas en z  
                        f(3,i) = f(3,i)+fuerza * delta_r(3)/distance
                        f(3,j)=f(3,j)-fuerza * delta_r(3)/distance

                end if
            end do
        end do
end subroutine force

