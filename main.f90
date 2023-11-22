program main
    use ziggurat
    use globals
    implicit none
    logical :: es1,es2,es3
    integer :: seed,i,j

![NO TOCAR] Inicializa generador de número random

    inquire(file='seed.dat',exist=es1)
    if(es1) then
        open(unit=10,file='seed.dat',status='old')
        read(10,*) seed
        close(10)
        print *,"  * Leyendo semilla de archivo seed.dat"
    else
        seed = 24583490
    end if

    call zigset(seed)
![FIN NO TOCAR]    

!. Levanto los datos de simulación del input
    inquire(file='input.dat',exist=es2)
    if(es2) then
        open(unit=18,file='input.dat',status='old')
        read(18,*) N  ! Cantidad de partículas
        read(18,*) L  ! Largo de la caja
        read(18,*) Nsteps ! Cantidad de pasos de MD
        read(18,*) sigma, epsilonn ! Datos del potencial de LJ
        read(18,*) m  !.Masa de las particulas
        read(18,*) t_sim !.Tiempo de simulacion
        read(18,*) T !.Temperatura de simulacion
        close(18)
        print *,"  * Leyendo datos de input.dat"
    else
        N = 5
        L = 6.0
        Nsteps = 1000
        sigma = 1.0
        epsilonn = 1.0
        m =1.0
        t_sim = 100000.0
        print *, "  * Sin input.dat, colocando valores por defecto"
    end if
!.Abro archivo para escribir trayectorias y energia
open(unit=33,file='traj.xyz',status='unknown')
open(unit=34,file='potencial.dat',status='unknown')
open(unit=35, file='cinetica.dat',status='unknown')
open(unit=36, file='energy.dat',status='unknown')

!Defino radio de corte
rc = 2.5*sigma
!.Calculo el potencial en rc para evitar discontinuidades
V_rc = 4*epsilonn*(-(sigma/rc)**6+(sigma/rc)**12)
!.Calculo el dt
dt = 1
! alloco las variables con los datos de entrada
allocate(r(3,N))
allocate(v(3,N))
allocate(f(3,N))

!.Sistema inicial. Veo si hay un archivo como punto de partida
        !inquire(file='positions.dat',exist=es3)
        !if(es3) then
        !open(unit=60,file='positions.dat',status='old')
        !do i=1,N
        !        read(60,*) (r(j,i), j=1,3)
        !end do
        !close(60)
        !print *,"  * Leyendo configuracion de archivo positions.dat"
   ! else
        !. Inicializo aleatoriamente posiciones y velocidades0
        call init()
        print *, "  * Inicializando sistema con posiciones y velocidades aleatorias"
    !end if


!.Computo las fuerzas y el potencial total de la config inicial
!call force()
!print *, "  * Potencial total del sist.", Vtotal

!.Minimización de energía
do i=1,500
        call verlet_positions()
        call force()
end do

!.Minimizo la energia en el loop de MD !Creo que acá es solo loop MD, minimización de energía va antes
do i=1,Nsteps
        !. Calculo posición y velocidades con Velocity Verlet
        call verlet_positions()
        !. Calculo potencial y fuerzas con las nuevas posiciones
        call force()
        !. Calculo fuerza de Langevin
        !call lgv_force()
        !. Vuelvo a calcular velocidades
        call verlet_velocities()
        !.Computo energía cinética media
        call Ec_calc()  
        if (mod(i,100)==0) then
                write(33,*) N !.Escribo header del paso del.xyz
                write(33,*)
                write(34,*) i, Vtotal !.Escribo el potencial LJ en potencial.dat
                write(35,*) i, Ec !. Escribo la energía cinética en cinetica.dat
                write(36,*) i,Vtotal+Ec !.Escribo la energia total
        
                do j=1,N  !.Escribo posiciones .xyz
                        write(33,*) "N",r(1,j),r(2,j),r(3,j)
                end do
        end if
        
end do
print *, "  * Ciclo MD finalizado "
!.Cierro archivos
close(33)
close(34)
close(35)
close(36)
!! 
!! FIN FIN edicion
!! 
![No TOCAR]
! Escribir la última semilla para continuar con la cadena de numeros aleatorios 

        open(unit=10,file='seed.dat',status='unknown')
        seed = shr3() 
         write(10,*) seed
        close(10)
![FIN no Tocar]        
        open(unit=20,file='positions.dat',status='unknown')
        ! Escribe la matriz r en el archivo
        do i = 1, N 
                write(20, *) (r(j, i), j = 1, 3)
        end do
        close(20) 

        open(unit=30,file='fuerzas.dat',status='unknown')
        ! Escribe la matriz f en el archivo
        do i = 1, N
                write(30, *) (f(j, i), j = 1, 3)
        end do
        close(30)


        open(unit=40,file='velocidades.dat',status='unknown')
        ! Escribe la matriz v en el archivo
        do i = 1, N
                write(40, *) (v(j, i), j = 1, 3)
        end do
        close(40) 
 print *, "  * Archivos de energia y posiciones escrito"
end program main
