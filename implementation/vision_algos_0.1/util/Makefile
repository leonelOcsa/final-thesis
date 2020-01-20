include ../Makefile.common
FLAGS =  -DDEBUG -g   -mieee-fp -rdynamic  -shared
INCLUDE_DIR= -I$(OCTAVE_INCLUDE_PATH) -I$(OCTAVE_INCLUDE_PATH)/octave
LIBS =  -loctave -lcruft  -lncurses -ldl  -lz -lm -lhdf5 -llapack -lblas -loctinterp 
LIB_PATH = -L$(OCTAVE_LIB_PATH)


all: select_common_features_faster.oct

select_common_features_faster.oct: select_common_features_faster.cpp 
	$(CC) $(INCLUDE_DIR) $(FLAGS) $(LIB_PATH) $(LIBS) select_common_features_faster.cpp -o select_common_features_faster.oct
	
