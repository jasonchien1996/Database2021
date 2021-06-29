#include <mysql/mysql.h>
#include <cstring>
#include <opencv2/opencv.hpp>
#include <time.h>
using namespace cv;

extern "C" {
  bool aug_init(UDF_INIT *initid, UDF_ARGS *args, char *message);
  char* aug(UDF_INIT *const initid, UDF_ARGS *const args, char *const result, unsigned long *const length, char *const is_null, char *const error);
  void aug_deinit(UDF_INIT *const initid);
}

Mat __hflip(Mat);
Mat __vflip(Mat);
Mat __chshuffle(Mat);
Mat __randcrop(Mat, float, float, Scalar);
Mat __noise(Mat, const char*, int, int);
Mat __cvt2gray(Mat);
Mat __medianblur(Mat, double);
Mat __gaussianblur(Mat,double,double,double,double);
Mat __resize(Mat, double, double);
Mat __rotation(Mat, double);

bool aug_init(UDF_INIT *initid, UDF_ARGS *args, char *message) {
  if(args->arg_count != 1){
      strcpy(message,"usage:aug(blob img)");
      return 1;
  }
  initid->max_length = 16000000;
  return 0;
}

char* aug(UDF_INIT *const initid, UDF_ARGS *const args, char *const result, unsigned long *const length, char *const is_null, char *const error) {
  srand(time(NULL));
  std::vector<char> buffer(args->args[0], args->args[0]+args->lengths[0]);
  Mat image = cv::imdecode(buffer, IMREAD_ANYCOLOR);
  Mat tmp = image.clone();
  std::vector<unsigned char> img_encoded;
  cv::imencode(".jpg", tmp, img_encoded);
  char *t = reinterpret_cast<char*>(img_encoded.data());
  *length = (unsigned long)img_encoded.size();
  return t;
}
void aug_deinit(UDF_INIT *const initid){}