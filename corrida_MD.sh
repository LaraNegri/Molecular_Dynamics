#!/bin/bash

# Valores de temperatura
densidades=(0.001 0.01 0.1 0.15 0.2 0.25 0.3 0.35 0.4 0.45 0.5 0.55 0.6 0.65 0.7 0.75 0.8 0.9 0.98)
# Nombre del ejecutable
ejecutable="./main"

# Itera sobre las temperaturas y ejecuta el programa
for rho in "${densidades[@]}"
do
	#.Hago cuatro corridas (tres de producción y una de termalizacion)
	for i in {1..1}
	do
    		echo "Modificando input.dat con densidad: $rho"
    		# Utiliza sed para modificar la línea específica
		sed -i "1s/.*/$rho/" "$input_file"

    		echo "Ejecutando $ejecutable con densidad: $rho"
    		#.Elimino matriz.dat asi inicializa aleatoriamente
		#[ -e ./matriz.dat ] && rm ./matriz.dat
		$ejecutable

     	# Renombra el archivo de energía mecanica
    		mv ./energy.dat "./resultados/$i-energy_$rho.dat"

     	# Renombra el archivo de energia cinetica
		mv ./cinetica.dat "./resultados/$i-cinetica_$rho.dat"

     	# Renombra el archivo de energia potencial
    		mv ./potencial.dat "./resultados/$i-potencial_$rho.dat"

     	# Renombra el archivo de presion interna
    		mv ./presion.dat "./resultados/$i-presion_$rho.dat"

     	# Renombra el archivo .xyz para VMD
    		mv ./traj.xyz "./resultados/$i-traj_$rho.xyz"


	done
done
