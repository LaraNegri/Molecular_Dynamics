!Modulo donde defino variables "globales"
module globals
real(kind=8), allocatable :: r(:,:),v(:,:),f(:,:) !.Posiciones, velocidades y fuerzas
real(kind=8) :: L, epsilonn, sigma, Vtotal  ! Largo de la caja de simulación y constantes del potencial de LJ. Potencial total del sist
real(kind=8) :: t_sim,m,rho  !.Tiempo de simulacion y masa de las particulas
integer :: N, Nsteps  ! Cantidad de particulas y número de pasos de MD
real(kind=8) :: T, Ec, V_rc, rc, dt !Temperatura, energia cinetica, Potencial y radio de corte
real(kind=8) :: p !Presion
end module globals
