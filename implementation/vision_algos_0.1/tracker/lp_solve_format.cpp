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

DEFUN_DLD (lp_solve_format, args, ,
     "Interface to lp_solve")

//int main(int argc, char* argv[])
{

    const char* fname  = args(0).string_value().c_str();	
    FILE* fd1 = fopen(fname, "w");
		  
    Matrix c = args(1).matrix_value();
    Matrix A = args(2).matrix_value();
    Matrix b = args(3).matrix_value();
    Matrix ret_val(c.dim2(), 1);
    
    for(int i =0; i< c.dim2(); i++){
      if(c(0,i)!=0)
        fprintf(fd1, " + %e x%d", c(0,i),i+1);
    }

    fprintf(fd1, ";\n");

    for(int i = 0; i<A.dim1(); i++){
      for(int j = 0; j<A.dim2(); j++){
	if(A(i,j) !=0){
          fprintf(fd1, "+ %e x%d ", A(i,j),j+1);
	}
      }
      fprintf(fd1, " < %e;\n", b(i,0));
    }

    fclose(fd1);
    
    return octave_value_list();
} 
