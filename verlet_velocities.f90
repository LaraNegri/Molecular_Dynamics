!Integrador Velocity Verlet 
subroutine verlet_velocities()
        use globals
        integer :: j
        do j=1,N
                !calculo los v(t+dt)
                v(1,j) = v(1,j)+0.5*dt*f(1,j)/m
                v(2,j) = v(2,j)+0.5*dt*f(2,j)/m
                v(3,j) = v(3,j)+0.5*dt*f(3,j)/m
         end do 
end subroutine verlet_velocities
