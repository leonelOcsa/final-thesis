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

DEFUN_DLD (lap, args, ,
     "Interface to lp_solve")

{
    char * fname = args(0).as_string().c_str();
    int nb_params = args(1).as_integer();
    FILE* fd2 = fopen(fname, "r");

    char buf[1000];
    for(int i=0; i<10; i++) {
      fscanf(fd2, "%s",buf);
      cout << buf<< endl;
    }
    
    float tmp_flt;
    for(int i =0; i< ret_val.dim1(); i++){
      fscanf(fd2, "%s", buf);
      cout << "str:"<<  buf << endl;
      fscanf(fd2, "%e", &tmp_flt);
      ret_val(i,0) = tmp_flt;
    }
    
    fclose(fd2);

    for(int i=0; i< ret_val.dim1(); i++) cout << ret_val(i,0) << endl;

    octave_value_list ret_val_list;
    ret_val_list(0) = Matrix(2,2,0);//ret_val;
//    kill(cid, SIGKILL);
    waitpid(cid, (int*)NULL, 0);
    cout << "Hallo, about to return" << endl;
    int l;
    for(int i =0; i<1000000000;i++ ) l++;
    return ret_val_list;
    
  }else{
	  
/*    char exec_str[1000];
    strcpy(exec_str, "/usr/bin/lp_solve <");
    strcat(exec_str, PNAME1);
    strcat(exec_str, " >");
    strcat(exec_str, PNAME2);
    cout << exec_str<< endl; 
    char* ex_args[] = {"<oct-pipe-to-lp-solve", ">oct-pipe-from-lp-solve"};
    execve("/usr/bin/lp_solve", ex_args, NULL);*/
    cout << "child system call returned" << endl;
    exit(0); 
  }
  	
}

/*char tmp[100];
    float d;
    while(!feof(fd1)){
//       fscanf(fd1, "+ %e ",&d);
//     cout << d << endl;
//     fscanf(fd1, ";\n");
//      fscanf(fd1, " < ");
      fscanf(fd1, "%s",tmp);
      cout << tmp << endl;
	      
    }
  */  
 
