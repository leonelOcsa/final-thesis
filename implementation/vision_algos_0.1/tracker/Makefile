include ../Makefile.common
FLAGS =  -DDEBUG -g   -mieee-fp -rdynamic  -shared
INCLUDE_DIR= -I . -I $(OCTAVE_INCLUDE_PATH) -I $(OCTAVE_INCLUDE_PATH)/octave  
LIBS =  -loctave -lcruft  -lncurses -ldl  -lz -lm -lhdf5 -llapack -lblas -lg2c -loctinterp -lfftw -lreadline -lfltk -lfltk_forms -lfltk_images -lfltk_gl -lklt
LIB_PATH = -L$(OCTAVE_LIB_PATH) -Lklt 


all: lp_solve_parse.oct lp_solve_format.oct klt_track.oct


lp_solve_format.oct: lp_solve_format.cpp
	$(CC) $(INCLUDE_DIR) $(FLAGS) $(LIB_PATH) $(LIBS) lp_solve_format.cpp -o lp_solve_format.oct

lp_solve_parse.oct: lp_solve_parse.cpp
	$(CC) $(INCLUDE_DIR) $(FLAGS) $(LIB_PATH) $(LIBS) lp_solve_parse.cpp -o lp_solve_parse.oct

klt_track.oct: klt_track.cpp 
	cd klt; make; cd ..
	$(CC) $(INCLUDE_DIR) $(FLAGS) $(LIB_PATH) $(LIBS) klt_track.cpp -o klt_track.oct
	
