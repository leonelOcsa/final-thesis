#include <oct.h>
#include <vector>
#include <iostream>

using namespace std;

   DEFUN_DLD (select_common_features_faster, args, ,
     "")
     //    int main()
{

Matrix x1_orig = args(0).matrix_value ();
Matrix x2_orig = args(1).matrix_value ();


vector <int> feat_list1;
vector <int> feat_list2;

int l1 = x1_orig.dim2();
int l2 = x2_orig.dim2();

int cur_pos_x1 = 0;
int cur_pos_x2 = 0;


while(cur_pos_x1 < l1 && cur_pos_x2 < l2){
  if(x1_orig(0, cur_pos_x1) < x2_orig(0,cur_pos_x2))
    cur_pos_x1++;
  else
    if(x1_orig(0, cur_pos_x1) > x2_orig(0,cur_pos_x2))
      cur_pos_x2++;
    else{
      feat_list1.push_back(cur_pos_x1);
      feat_list2.push_back(cur_pos_x2);
      cur_pos_x1++;
      cur_pos_x2++;
    }
}

  Matrix ret_x1(x1_orig.dim1(), feat_list1.size());
  Matrix ret_x2(x2_orig.dim1(), feat_list2.size());

  for(int i = 0; i<ret_x1.dim2(); i++){
    int idx1 = feat_list1[i];
    for(int j=0; j<ret_x1.dim1(); j++){
      ret_x1(j,i) = x1_orig(j,idx1);
    }
  }
   for(int i = 0; i<ret_x2.dim2(); i++){
    int idx2 = feat_list2[i];
    for(int j=0; j<ret_x2.dim1(); j++){
      ret_x2(j,i) = x2_orig(j,idx2);
    }
  }
  
  octave_value_list ret_val;
  ret_val(0) = ret_x1;
  ret_val(1) = ret_x2;

  return ret_val;

}
