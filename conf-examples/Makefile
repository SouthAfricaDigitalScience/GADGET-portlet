
#----------------------------------------------------------------------
# From the list below, please activate/deactivate the options that     
# apply to your run. If you modify any of these options, make sure     
# that you recompile the whole code by typing "make clean; make".      
#                                                                      
# Look at end of file for a brief guide to the compile-time options.   
#----------------------------------------------------------------------

.include Makefile.parameters
#--------------------------------------- Basic operation mode of code
#OPT   +=  -DPERIODIC 
#OPT   +=  -DUNEQUALSOFTENINGS


#--------------------------------------- Things that are always recommended
#OPT   +=  -DPEANOHILBERT
#OPT   +=  -DWALLCLOCK   


#--------------------------------------- TreePM Options
#OPT   +=  -DPMGRID=128
#OPT   +=  -DPLACEHIGHRESREGION=3
#OPT   +=  -DENLARGEREGION=1.2
#OPT   +=  -DASMTH=1.25
#OPT   +=  -DRCUT=4.5


#--------------------------------------- Single/Double Precision
#OPT   +=  -DDOUBLEPRECISION      
#OPT   +=  -DDOUBLEPRECISION_FFTW      


#--------------------------------------- Time integration options
#OPT   +=  -DSYNCHRONIZATION
#OPT   +=  -DFLEXSTEPS
#OPT   +=  -DPSEUDOSYMMETRIC
#OPT   +=  -DNOSTOP_WHEN_BELOW_MINTIMESTEP
#OPT   +=  -DNOPMSTEPADJUSTMENT


#--------------------------------------- Output 
OPT   +=  -DHAVE_HDF5  
#OPT   +=  -DOUTPUTPOTENTIAL
#OPT   +=  -DOUTPUTACCELERATION
#OPT   +=  -DOUTPUTCHANGEOFENTROPY
#OPT   +=  -DOUTPUTTIMESTEP


#--------------------------------------- Things for special behaviour
#OPT   +=  -DNOGRAVITY     
#OPT   +=  -DNOTREERND 
#OPT   +=  -DNOTYPEPREFIX_FFTW        
#OPT   +=  -DLONG_X=60
#OPT   +=  -DLONG_Y=5
#OPT   +=  -DLONG_Z=0.2
#OPT   +=  -DTWODIMS
#OPT   +=  -DSPH_BND_PARTICLES
#OPT   +=  -DNOVISCOSITYLIMITER
#OPT   +=  -DCOMPUTE_POTENTIAL_ENERGY
#OPT   +=  -DLONGIDS
#OPT   +=  -DISOTHERM_EQS
#OPT   +=  -DADAPTIVE_GRAVSOFT_FORGAS
#OPT   +=  -DSELECTIVE_NO_GRAVITY=2+4+8+16

#--------------------------------------- Testing and Debugging options
#OPT   +=  -DFORCETEST=0.1


#--------------------------------------- Glass making
#OPT   +=  -DMAKEGLASS=262144


#----------------------------------------------------------------------
# Here, select compile environment for the target machine. This may need 
# adjustment, depending on your local system. Follow the examples to add
# additional target platforms, and to get things properly compiled.
#----------------------------------------------------------------------

#--------------------------------------- Select some defaults

CC       =  mpicc               # sets the C-compiler
OPTIMIZE =  -O2 -Wall -g        # sets optimization and warning flags
MPICHLIB =  -lmpich


#--------------------------------------- Select target computer

#SYSTYPE="SAGrid"
#SYSTYPE="MPA"
#SYSTYPE="Mako"
#SYSTYPE="Regatta"
#SYSTYPE="RZG_LinuxCluster"
#SYSTYPE="RZG_LinuxCluster-gcc"
#SYSTYPE="OpteronMPA"
#SYSTYPE="OPA-Cluster32"
#SYSTYPE="OPA-Cluster64"


#--------------------------------------- Adjust settings for target computer

ifeq ($(SYSTYPE),"SAGrid")
CC	 = mpicc
OPTIMIZE = -03 -Wall
GSL_INCL =  -I${GSL_DIR}/include
GSL_LIBS =  -L${GSL_DIR}.lib  -Wl,"-R $GSL_DIR/lib"
FFTW_INCL=  -I${FFTW_DIR}/include
FFTW_LIBS=  -L${FFTW_DIR}/lib
MPICHLIB =  -L${OPENMPI_DIR}/lib/openmpi
HDF5INCL =  -I${HDF5_DIR}/include
HDF5LIB  =  -L${HDF5_DIR}/lib -L${ZLIB_DIR}/lib -lhdf5 -lz
endif

ifneq (HAVE_HDF5,$(findstring HAVE_HDF5,$(OPT))) 
HDF5INCL =
HDF5LIB  =
endif


OPTIONS =  $(OPTIMIZE) $(OPT)

EXEC   = Gadget2

OBJS   = main.o  run.o  predict.o begrun.o endrun.o global.o  \
	 timestep.o  init.o restart.o  io.o    \
	 accel.o   read_ic.o  ngb.o  \
	 system.o  allocate.o  density.o  \
	 gravtree.o hydra.o  driftfac.o  \
	 domain.o  allvars.o potential.o  \
         forcetree.o   peano.o gravtree_forcetest.o \
	 pm_periodic.o pm_nonperiodic.o longrange.o 

INCL   = allvars.h  proto.h  tags.h  Makefile


CFLAGS = $(OPTIONS) $(GSL_INCL) $(FFTW_INCL) $(HDF5INCL)


ifeq (NOTYPEPREFIX_FFTW,$(findstring NOTYPEPREFIX_FFTW,$(OPT)))    # fftw installed with type prefix?
  FFTW_LIB = $(FFTW_LIBS) -lrfftw_mpi -lfftw_mpi -lrfftw -lfftw
else
ifeq (DOUBLEPRECISION_FFTW,$(findstring DOUBLEPRECISION_FFTW,$(OPT)))
  FFTW_LIB = $(FFTW_LIBS) -ldrfftw_mpi -ldfftw_mpi -ldrfftw -ldfftw
else
  FFTW_LIB = $(FFTW_LIBS) -lsrfftw_mpi -lsfftw_mpi -lsrfftw -lsfftw
endif
endif


LIBS   =   $(HDF5LIB) -g  $(MPICHLIB)  $(GSL_LIBS) -lgsl -lgslcblas -lm $(FFTW_LIB) 

$(EXEC): $(OBJS) 
	$(CC) $(OBJS) $(LIBS)   -o  $(EXEC)  

$(OBJS): $(INCL) 


clean:
	rm -f $(OBJS) $(EXEC)

