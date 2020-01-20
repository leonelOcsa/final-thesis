//#include <FL/Fl.H> //for jpeg image io
//#include <FL/Fl_Image.H>
#include <Fl/Fl_JPEG_Image.H>

#include <oct.h>
#include <Cell.h>
#include <dMatrix.h>
#include <dColVector.h>

#include "klt/klt.h"
#define FILE_NAME_FORMAT "%s/%06d.jpg"

using namespace std;

DEFUN_DLD (klt_track, args, ,
     "klt_track(img_dir_path, frm_indices)")
//int main(int argc, char **argv) 
{
  const char* path_name = args(0).string_value().c_str();
  ColumnVector frame_indices = (ColumnVector)args(1).vector_value();
  int nFeatures = args(2).int_value();
//Cell klt_track(const char* path_name, const ColumnVector frame_indices){

  unsigned char *img1, *img2;
  char fnamein[100], fnameout[100];
  KLT_TrackingContext tc;
  KLT_FeatureList fl;
  KLT_FeatureTable ft;
//  int nFeatures = NB_TRACKED_FEATURES;
  int i;

//  Cell filenames = args(0).cell_value();
  int nFrames = frame_indices.length();//(end_idx-start_idx+1)/FRAME_STEP;

  int cur_frame = (int)frame_indices(0);
  char tmp_str[2048]; sprintf(tmp_str, FILE_NAME_FORMAT, path_name, cur_frame); 
  Fl_RGB_Image* fl_img = new Fl_JPEG_Image(tmp_str); 
  int nrows = fl_img->h();
  int ncols = fl_img->w();
  
  img1 = (unsigned char *) malloc(ncols*nrows*sizeof(unsigned char));
  img2 = (unsigned char *) malloc(ncols*nrows*sizeof(unsigned char));


  const char* tmp_buf = fl_img->data()[0];
  int d = fl_img->d();
  //transform to gray image:
  for(int k = 0; k < nrows; k++)
    for(int l= 0; l < ncols; l++){
    	    double r = tmp_buf[(k*ncols+l)*d];
	    double g = tmp_buf[(k*ncols+l)*d+1];
            double b = tmp_buf[(k*ncols+l)*d+2];

	    img1[k*ncols+l] = (char)sqrt((r*r + g*g + b*b));


    }

  Cell imgs(nFrames, 1);

  int indices[nFeatures];

  tc = KLTCreateTrackingContext();
  fl = KLTCreateFeatureList(nFeatures);
  tc->sequentialMode = TRUE;

  KLTSelectGoodFeatures(tc, img1, ncols, nrows, fl);

  Matrix img(4,nFeatures,0);
  for (int j = 0; j< nFeatures; j++){
    img(0,j)=j+1;
//      img(0,j)=fl->feature[j]->val;
    img(1,j)=fl->feature[j]->x;
    img(2,j)=fl->feature[j]->y;
    img(3,j)=1;
  }
  imgs(0,0) = img;

  int cur_idx = nFeatures;
  
  cout << "KLT nframes: " << nFrames << endl;


for(int j =0; j<nFeatures; j++) indices[j]=j+1;
for(int i =1; i<nFrames; i++){  
  
  //pgmReadFile(filenames(i,0).string_value().c_str(), img2, &ncols, &nrows);
  if(fl_img) delete fl_img;
  cur_frame = (int)frame_indices(i);
  sprintf(tmp_str, FILE_NAME_FORMAT, path_name, cur_frame);
  cout << "Filename: " << tmp_str<< endl;
  fl_img = new Fl_JPEG_Image(tmp_str); 
  //transform to gray image:
  const char* tmp_buf = fl_img->data()[0];
  for(int k = 0; k < nrows; k++)
    for(int l= 0; l < ncols; l++){
	    double r = tmp_buf[(k*ncols+l)*d];
	    double g = tmp_buf[(k*ncols+l)*d+1];
            double b = tmp_buf[(k*ncols+l)*d+2];

	    img2[k*ncols+l] = (char)sqrt((r*r + g*g + b*b));
    }
 
  cout << "Frame number: " << i << endl;
  KLTTrackFeatures(tc, img1, img2, ncols, nrows, fl);
  KLTReplaceLostFeatures(tc, img2, ncols, nrows, fl);
  for (int j = 0; j< nFeatures; j++){
    if(fl->feature[j]->val>0){
      indices[j]=++cur_idx;
    }
    else{
      if(fl->feature[j]->val < 0)
        indices[j]=-1;
    }
  }
 

  for(int j =0; j<nFeatures; j++){
      img(0,j) = indices[j];//cur_idx++;
      img(1,j)=fl->feature[j]->x;
      img(2,j)=fl->feature[j]->y;
      img(3,j)=1;
  }
  
  imgs(i,0) = img;
  unsigned char* tmp = img1; img1 = img2; img2 = tmp;

}
 if(fl_img) delete fl_img;
  
  octave_value_list ret_val;
  ret_val(0)=imgs;
 // return imgs;
  return ret_val;


}



