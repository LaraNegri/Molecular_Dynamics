program main
    use ziggurat
    use globals
    implicit none
    logical :: es1,es2,es3
    integer :: seed,i,j,k


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
        read(18,*) rho  ! densidad
        read(18,*) L  ! Largo de la caja
        read(18,*) Nsteps ! Cantidad de pasos de MD
        read(18,*) sigma, epsilonn ! Datos del potencial de LJ
        read(18,*) m  !.Masa de las particulas
        read(18,*) dt !.Paso de tiempo
        read(18,*) T !.Temperatura de simulacion
        close(18)
        print *,"  * Leyendo datos de input.dat"
    else
        rho = 0.3
        L = 6.0
        Nsteps = 1000
        sigma = 1.0
        epsilonn = 1.0
        m =1.0
        dt = 0.001
        print *, "  * Sin input.dat, colocando valores por defecto"
    end if
!.Abro archivo para escribir trayectorias y energia
open(unit=33,file='traj.xyz',status='unknown')
open(unit=34,file='potencial.dat',status='unknown')
open(unit=35, file='cinetica.dat',status='unknown')
open(unit=36, file='energy.dat',status='unknown')
open(unit=37, file='presion.dat',status='unknown')
open(unit=38, file='temperatura.dat', status='unknown')

!.Calculo el numero de particulas
N = int(rho*L**3)
!Defino radio de corte
rc = 2.5*sigma
print *,"  * Usando rc=",rc
!.Calculo el potencial en rc para evitar discontinuidades
V_rc = 4*epsilonn*(-(sigma/rc)**6+(sigma/rc)**12)
!.Calculo el dt
t_sim = dt*Nsteps
print *, "  * Número de partículas:", N
print *, "  * Tiempo a simular:", t_sim

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
 print *, "  * Inicializando sistema con posiciones y velocidades aleatorias..."
    !end if

call force()
!.Computo las fuerzas y el potencial total de la config inicial
print *, "  * Potencial total del sist.", Vtotal

!.Minimización de energía
print *, "  * Ciclo de minimización de energía..."

do k=1,30000
        call minimize_energy()
end do            

print *, "  * Inicializando ciclo MD..."
!.Minimizo la energia en el loop de MD !Creo que acá es solo loop MD, minimización de energía va antes
do i=1,Nsteps
        !. Calculo posición y velocidades con Velocity Verlet
        call verlet_positions()
        !. Calculo potencial y fuerzas con las nuevas posiciones
        call force()
        !. Calculo fuerza de Langevin
        call lgv_force()
        !. Vuelvo a calcular velocidades
        call verlet_velocities()
        !.Computo energía cinética media
        if (mod(i,100)==0) then
        call Ec_calc()
        !. Calculo presión del sistema
        call p_calc()
        !. Calculo la temperatura (para ver si funciona Langevin)
        call T_calc()  
                write(33,*) N !.Escribo header del paso del.xyz
                write(33,*)
                write(34,*) i, Vtotal !.Escribo el potencial LJ en potencial.dat
                write(35,*) i, Ec !. Escribo la energía cinética en cinetica.dat
                write(36,*) i,Vtotal+Ec !.Escribo la energia total
                write(37,*) i, p !.Escribo la presión del sistema
                write(38,*) i, Test !.Escribo la temperatura del sistema

                do j=1,N  !.Escribo posiciones .xyz
                        write(33,*) "S",r(1,j),r(2,j),r(3,j)
                end do
        end if
        
end do
print *, "  * Ciclo MD finalizado "

call var()

!. Guardo la varianza
open(unit=39, file='varianza.dat', status='unknown')
write(39, *) varianza
close(39)

!.Cierro archivos
close(33)
close(34)
close(35)
close(36)
close(37)
close(38)
!! 
!! FIN FIN edicion
!! 
![No TOCAR]
! Escribir la última semilla para continuar con la cadena de numeros aleatorios 

print *, "  * Escribiendo archivo de semilla "
        open(unit=10,file='seed.dat',status='unknown')
        seed = shr3() 
        write(10,*) seed
        close(10)
![FIN no Tocar]        

print *, "  * Escribiendo archivo de posiciones "
        open(unit=20,file='positions.dat',status='unknown')
        ! Escribe la matriz r en el archivo
        do i = 1, N 
                write(20, *) (r(j, i), j = 1, 3)
        end do
        close(20) 

print *, "  * Escribiendo archivo de fuerzas "
        open(unit=30,file='fuerzas.dat',status='unknown')
        ! Escribe la matriz f en el archivo
        do i = 1, N
                write(30, *) (f(j, i), j = 1, 3)
        end do
        close(30)


print *, "  * Escribiendo archivo de velocidad "
        open(unit=40,file='velocidades.dat',status='unknown')
        ! Escribe la matriz v en el archivo
        do i = 1, N
                write(40, *) (v(j, i), j = 1, 3)
        end do
        close(40) 
 print *, "  * Archivos de energia y posiciones escrito"
 print *, " "
end program main
