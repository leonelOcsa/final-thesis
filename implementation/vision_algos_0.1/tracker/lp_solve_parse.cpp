#include <sys/types.h>
#include <sys/stat.h>
#include <sys/wait.h>
#include <fcntl.h>
#include <unistd.h>

#include <stdio.h>

#include <oct.h>
#include <dMatrix.h>
#include <oct-syscalls.h>

#include <iostream>
#include <string.h>
#include <signal.h>

#define PNAME1 "oct-pipe-to-lp-solve"
#define PNAME2 "oct-pipe-from-lp-solve"

using namespace std;

DEFUN_DLD (lp_solve_parse, args, ,
     "Interface to lp_solve")

{
    const char * fname = args(0).string_value().c_str();
    int nb_params = args(1).int_value();
    FILE* fd2 = fopen(fname, "r");

    Matrix ret_val(nb_params, 1);
    
    char buf[1000];
    for(int i=0; i<10; i++) {
      fscanf(fd2, "%s",buf);
    }
    
    float tmp_flt;
    int idx;
    for(int i =0; i< ret_val.dim1(); i++){
      fscanf(fd2, "%s", buf);
      idx = atoi(buf+1)-1; //the variable are not ordered in the output of lp_s
//      cout << idx << " ";
      fscanf(fd2, "%e", &tmp_flt);
      ret_val(idx,0) = tmp_flt;
    }
    
    fclose(fd2);

    octave_value_list ret_val_list;
    ret_val_list(0) = ret_val;
    return ret_val_list;

}

