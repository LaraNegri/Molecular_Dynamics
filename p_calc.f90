subroutine p_calc()
        use globals
        integer :: k
        p = 0 !. Inicializo el contador de presión en cero
        !. Loop sobre todas las partículas
        do k=1,N
                !. Calculo el momento lineal al cuadrado
                plin_sq = (m**2)*(v(1,k)**2 + v(2,k)**2 + v(3,k)**2)
                !. Calculo el producto escalar entre r y F
                rF = r(1,i)*f(1,k) + r(2,k)*f(2,k) + r(3,k)*f(3,k)
                p = p + (1.0/3.0)*(L**3)*(plin_sq/m + rF)

        end do
                !. Asumí dU/dV = 0 por estar a V=cte

end subroutine p_calc
