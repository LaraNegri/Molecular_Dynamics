#!/bin/bash

# Valores de temperatura
temperaturas=(0.7 0.75 0.8 0.85 0.9 0.95 1.0 1.05 1.1 1.15 1.2 1.25 1.3 1.35 1.4)
# Nombre del ejecutable
ejecutable="./main"

# Itera sobre las temperaturas y ejecuta el programa
for temp in "${temperaturas[@]}"
do
	#.Hago cuatro corridas (tres de producción y una de termalizacion)
	for i in {1..1}
	do
    		echo "Modificando input.dat con temperatura: $temp"
    		# Utiliza sed para modificar la línea específica
		sed -i "7s/.*/$temp/" "./input.dat"

    		echo "Ejecutando $ejecutable con temperatura: $temp"
    		#.Elimino matriz.dat asi inicializa aleatoriamente
		#[ -e ./matriz.dat ] && rm ./matriz.dat
		$ejecutable

     	# Renombra el archivo de energía mecanica
    		mv ./energy.dat "./resultados/$i-energy_T_$temp.dat"

     	# Renombra el archivo de energia cinetica
		mv ./cinetica.dat "./resultados/$i-cinetica_T_$temp.dat"

     	# Renombra el archivo de energia potencial
    		mv ./potencial.dat "./resultados/$i-potencial_T_$temp.dat"

     	# Renombra el archivo de presion interna
    		mv ./presion.dat "./resultados/$i-presion_T_$temp.dat"

     	# Renombra el archivo .xyz para VMD
    		mv ./traj.xyz "./resultados/$i-traj_T_$temp.xyz"

     	# Renombra el archivo varianza para VMD
    		mv ./varianza.dat "./resultados/$i-varianzaP_T_$temp.dat"

	done
done
