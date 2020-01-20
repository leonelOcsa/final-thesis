#include <oct.h>
#include <dMatrix.h>

#include <vtk/vtkSphereSource.h>
#include <vtk/vtkPointSource.h>
#include <vtk/vtkPolyDataMapper.h>
#include <vtk/vtkActor.h>
#include <vtk/vtkProperty.h>
#include <vtk/vtkRenderWindow.h>
#include <vtk/vtkRenderer.h>
#include <vtk/vtkRenderWindowInteractor.h>
//#include <vnl/vnl_matrix.h>
//#include <fstream.h>
//#include <iostream.h>
#include <vtk/vtkFloatArray.h>
#include <vtk/vtkPoints.h>
#include <vtk/vtkPolyData.h>

DEFUN_DLD (view_str_vtk, args, ,
     "Point cloud visualiser")
//int main ()
{

  int nargin = args.length();

  Matrix point_cloud1 = args(0).matrix_value();
          
  // a renderer and render window
  vtkRenderer *ren1 = vtkRenderer::New();
  vtkRenderWindow *renWin = vtkRenderWindow::New();
  renWin->AddRenderer(ren1);
  renWin->SetSize(1024,1024);
  // an interactor
  vtkRenderWindowInteractor *iren = vtkRenderWindowInteractor::New();
  iren->SetRenderWindow(renWin);

  ren1->SetBackground(1,1,1); // Background color white


//  ifstream ifs;
//  ifs.open("1__eucl.str");
//   point_cloud1;
//  point_cloud1.read_ascii(ifs);
//  point_cloud1 = point_cloud1.get_n_columns(1,4);
//  point_cloud1 = pflat(point_cloud1);
  //  cout << point_cloud1;


  vtkFloatArray* pcoords = vtkFloatArray::New();

  pcoords->SetNumberOfComponents(3);
  pcoords->SetNumberOfTuples(point_cloud1.rows());
//   float pts[4][3] = { {0.0, 0.0, 0.0}, {0.0, 1.0, 0.0},
//                       {1.0, 0.0, 0.0}, {1.0, 1.0, 0.0} };
  for (int i=0; i<point_cloud1.dim1(); i++)
    {
      float pts[3]={point_cloud1(i,0),point_cloud1(i,1),point_cloud1(i,2)};
    pcoords->SetTuple(i, pts);
    }


  vtkPoints* points = vtkPoints::New();
  points->SetData(pcoords);


  vtkPolyData* polydata = vtkPolyData::New();
  // Assign points and cells
  polydata->SetPoints(points);

    // map to graphics library
    vtkPolyDataMapper *map = vtkPolyDataMapper::New();
    map->SetInput(polydata);
    
    // actor coordinates geometry, properties, transformation
    vtkActor *actor = vtkActor::New();
    actor->SetMapper(map);
//     if (i>2500)
//       aSphere->GetProperty()->SetColor(1,0,0); // sphere color blue
//     else
//       aSphere->GetProperty()->SetColor(0,0,1); // sphere color blue
    
    
    // add the actor to the scene
    ren1->AddActor(actor);
  
  
  // render an image (lights and cameras are created automatically)
  renWin->Render();
  
  // begin mouse interaction
  iren->Start();

  octave_value_list ret_val;
  ret_val(0)=point_cloud1;
  return ret_val;

}

