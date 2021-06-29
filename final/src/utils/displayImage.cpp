#include <stdio.h>
#include <fstream>
#include <ostream>
#include <vector>
#include <opencv2/opencv.hpp>
#include <time.h>

using namespace cv;

Mat __chshuffle(Mat in){
  std::vector<cv::Mat> inChannels(3);
	split(in, inChannels); 

	cv::Mat out; 
	std::vector<cv::Mat> outChannels;

  int p = rand()%6;
  switch(p){
    case 0:
      outChannels.push_back(inChannels[0]);
      outChannels.push_back(inChannels[1]);
      outChannels.push_back(inChannels[2]);
      break;
    case 1:
      outChannels.push_back(inChannels[0]);
      outChannels.push_back(inChannels[2]);
      outChannels.push_back(inChannels[1]);
      break;
    case 2:
      outChannels.push_back(inChannels[1]);
      outChannels.push_back(inChannels[0]);
      outChannels.push_back(inChannels[2]);
      break;
    case 3:
      outChannels.push_back(inChannels[1]);
      outChannels.push_back(inChannels[2]);
      outChannels.push_back(inChannels[0]);
      break;
    case 4:
      outChannels.push_back(inChannels[2]);
      outChannels.push_back(inChannels[0]);
      outChannels.push_back(inChannels[1]);
      break;
    case 5:
      outChannels.push_back(inChannels[2]);
      outChannels.push_back(inChannels[1]);
      outChannels.push_back(inChannels[0]);
      break;
  }  
	cv::merge(outChannels, out);
	return out;
}

int main(int argc, char* argv[]) {
  srand(time(NULL));
  std::ifstream input("/home/jason/Downloads/meme.png", std::ios::binary);

  std::vector<char> bytes(
        (std::istreambuf_iterator<char>(input)),
        (std::istreambuf_iterator<char>()));

  input.close();
  Mat img = imdecode(bytes, IMREAD_ANYCOLOR);
  Mat out = __chshuffle(img);
  imshow("out",out);
  waitKey(0);
  return 0;
}