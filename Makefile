MAKEFILE = Makefile
exe = main
fcomp = gfortran #ifort # /opt/intel/compiler70/ia32/bin/ifc  
# Warning: the debugger doesn't get along with the optimization options
# So: not use -O3 WITH -g option
flags =  -O3  
# Remote compilation
OBJS = globals.o ziggurat.o init.o min_E.o force.o main.o verlet_positions.o verlet_velocities.o lgv_force.o Ec_calc.o p_calc.f90 var.f90 T_calc.f90

.SUFFIXES:            # this deletes the default suffixes 
.SUFFIXES: .f90 .o    # this defines the extensions I want 

.f90.o:  
	$(fcomp) -c $(flags) $< 
        

$(exe):  $(OBJS) Makefile 
	$(fcomp) $(flags) -o $(exe) $(OBJS) 


clean:
	rm ./*.o ./*.mod	

globals.o: globals.f90
force.o: force.f90
init.o: init.f90
min_E.o: min_E.f90
verlet_positions.o: verlet_positions.f90
verlet_velocities.o: verlet_velocities.f90
lgv_force.o: lgv_force.f90
Ec_calc.o: Ec_calc.f90
p_calc.o: p_calc.f90
var.o: var.f90
T_calc.o: T_calc.f90
main.o: main.f90 ziggurat.o globals.o init.o min_E.o verlet_positions.o verlet_velocities.o lgv_force.o Ec_calc.o

