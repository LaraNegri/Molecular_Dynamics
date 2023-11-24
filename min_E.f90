subroutine minimize_energy()
        use globals
        integer :: j 

        do j=1,N

              call force()
                !calculo los r(t+dt) y v(t+dt/2)
                r(1,j) = r(1,j)+(0.5/m)*f(1,j)*dt**2
                r(2,j) = r(2,j)+(0.5/m)*f(2,j)*dt**2
                r(3,j) = r(3,j)+(0.5/m)*f(3,j)*dt**2
                !PBC para las posiciones   
                if (r(1,j)>L) r(1, j) = r(1, j) - L 
                if (r(1,j)<0.) r(1, j) = r(1, j) + L 
                if (r(2,j)>L) r(2, j) = r(2, j) - L 
                if (r(2,j)<0.) r(2, j) = r(2, j) + L 
                if (r(3,j)>L) r(3, j) = r(3, j) - L 
                if (r(3,j)<0.) r(3, j) = r(3, j) + L 
       end do
end subroutine minimize_energy
