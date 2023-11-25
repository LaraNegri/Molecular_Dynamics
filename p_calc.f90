subroutine p_calc()
        use globals
        integer :: i,j
        real(kind=8) :: delta_r(3)
        p = 0 !. Inicializo el contador de presión en cero
        !. Loop sobre todas las partículas
        do i=1,N-1
                do j=i+1,N    
                delta_r(1)=(r(1,j)-r(1,i)) 
                delta_r(2)=(r(2,j)-r(2,i))
                delta_r(3)=(r(3,j)-r(3,i))

                 !.Inserto las PBC considerando L/2
                delta_r(1)=delta_r(1)-L*int(2.0*delta_r(1)/L)
                delta_r(2)=delta_r(2)-L*int(2.0*delta_r(2)/L)
                delta_r(3)=delta_r(3)-L*int(2.0*delta_r(3)/L)
                !rF = delta_r(1)*(f(1,i)+f(1,j))+delta_r(2)*(f(2,i)+f(2,j))+delta_r(3)*(f(3,i)+f(3,j))
                rF = delta_r(1)*(f(1,i))+delta_r(2)*(f(2,i))+delta_r(3)*(f(3,i))
                p =p + rho*T + (0.5/(L**3))*rf

        end do
        end do
                !. Asumí dU/dV = 0 por estar a V=cte

end subroutine p_calc
