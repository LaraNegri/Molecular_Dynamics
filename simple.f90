!-----------------------------------------------------------------
! Año: 2023
! Curso: Introducción a la simulación computacional
! Docente: Claudio Pastorino
! URL: https://www.tandar.cnea.gov.ar/~pastorin/cursos/intro_sims/
!-----------------------------------------------------------------
program simple 
    use ziggurat
    implicit none
    logical :: es
    integer :: seed,i,j, N, L
    real :: r(3,20), v(3,20), f(3,20), lj(20), eps, sig, lj_sum(20), d(3), mod_d, rc, fij(20), fij_sum


![NO TOCAR] Inicializa generador de número random

    inquire(file='seed.dat',exist=es)
    if(es) then
        open(unit=10,file='seed.dat',status='old')
        read(10,*) seed
        close(10)
        print *,"  * Leyendo semilla de archivo seed.dat"
    else
        seed = 24583490
    end if

    call zigset(seed)
![FIN NO TOCAR]    

!!! GUIA 3A

N = 20
L = 10
eps = 1
sig = 1
rc = 3 !Radio de corte (inventé el valor)

do i=1,N
        r(1,i) = L*uni()
        r(2,i) = L*uni()
        r(3,i) = L*uni()
end do

do i=1,N
        do j=1,N
                if (i/=j) then
                        d(1) = r(1,i) - r(1,j)
                        d(2) = r(2,i) - r(2,j)
                        d(3) = r(3,i) - r(3,j)

                        d(1) = d(1) - L*int(2*d(1)/L)
                        d(2) = d(2) - L*int(2*d(2)/L)
                        d(3) = d(3) - L*int(2*d(3)/L)                 
                        
                        mod_d = sqrt(d(1)**2 + d(2)**2 + d(3)**2)
                        
                        if (mod_d < rc) then
                                lj_sum = 4*eps*(-(sig/mod_d)**6 + (sig/mod_d)**12)
                                fij_sum = 4*eps(-6*((sig**6)/(mod_d)**7) + 12*((sig**12)/(mod_d)**13))
                        else
                                lj_sum = 0
                                fij_sum = 0
                        end if
                lj(i) = lj(i) + lj_sum
                fij(i) = fij(i) + fij_sum
                end if
        end do
end do

print *, lj
print *, fij
!!!! 
![No TOCAR]
! Escribir la última semilla para continuar con la cadena de numeros aleatorios 

        open(unit=10,file='seed.dat',status='unknown')
        seed = shr3() 
         write(10,*) seed
        close(10)
![FIN no Tocar]        


end program simple
