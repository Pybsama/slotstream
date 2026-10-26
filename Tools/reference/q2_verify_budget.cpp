// Fixture driver for unmodified incoai/splash VerifyBudget.cpp.
// Reference revision: 1482f6bbc2abf12375332725302019594150b6cb.
// Build with -I<Splash>/runtime and <Splash>/runtime/model/VerifyBudget.cpp.
#include "model/VerifyBudget.hpp"
#include <cmath>
#include <algorithm>
#include <iostream>
#include <iomanip>
#include <limits>
using splash::model::VerifyBudget;
int main(){
 VerifyBudget b; std::cout<<"[\n"<<std::setprecision(10);
 for(int i=0;i<2048;++i){
  std::array<float,7> c;for(int j=0;j<7;++j)c[j]=i%19==0?0.0001f:0.12f+0.87f*float((i*17+j*11)%97)/96;
  auto cost=b.costs(1,false);auto a=b.acceptance();float survival=1,expected=1,best=1/cost[1];int depth=0;
  for(int j=0;j<7;++j){float q=std::clamp(c[j],1e-6f,1.f-1e-6f);survival*=1/(1+std::exp(-(a.slope*std::log(q/(1-q))+a.intercepts[j])));expected+=survival;float score=expected/cost[j+2];if(score>best){best=score;depth=j+1;}}
  if(b.explores(1,false))depth=7;
  int fullAccepted=(i*13)%8; int accepted=std::min(depth,fullAccepted);double duration=0.25+0.065*(depth+1)+0.01*(i%3);
  VerifyBudget::Lane lane;lane.confidence=c;lane.verifyRows=depth+1;lane.accepted=fullAccepted;
  b.observe(std::span(&lane,1),false,duration);
  std::cout<<(i?",\n":"")<<"{\"confidence\":[";
  for(int j=0;j<7;++j)std::cout<<(j?",":"")<<c[j];
  std::cout<<"],\"depth\":"<<depth<<",\"accepted\":"<<accepted<<",\"seconds\":"<<duration;
  if(accepted==depth && depth<7)std::cout<<",\"bonusAccepted\":"<<(fullAccepted>depth?"true":"false");
  std::cout<<",\"expectedLabels\":"<<b.labels().size()<<"}";
 }
 std::cout<<"\n]\n";
}
