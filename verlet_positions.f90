!Integrador Velocity Verlet 
subroutine verlet_positions()
        use globals 
        integer :: j
        do j=1,N
                !calculo los r(t+dt) y v(t+dt/2)
                r(1,j) = r(1,j)+v(1,j)*dt+(0.5/m)*f(1,j)*dt**2
                r(2,j) = r(2,j)+v(2,j)*dt+(0.5/m)*f(2,j)*dt**2
                r(3,j) = r(3,j)+v(3,j)*dt+(0.5/m)*f(3,j)*dt**2

                v(1,j) = v(1,j)+0.5*dt*f(1,j)/m
                v(2,j) = v(2,j)+0.5*dt*f(2,j)/m
                v(3,j) = v(3,j)+0.5*dt*f(3,j)/m
        end do 
end subroutine verlet_positions
