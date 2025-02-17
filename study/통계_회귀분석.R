#회귀분석 regression analysis
# a와 연관된 b에 대해 a의 변화에 따라 b를 예측
#ex) 실제 부동산의 데이터를 토대로 우리 집의 여러 요소들을 고려하여 시세를 예상
# ㄴ이때 시세는 종속변수
#크기-방개수-화장실-위치 같은 요소들은 독립변수

#회귀 직선 구하기
x <- c(2,4,6,8)  #방 크기
y <- c(1,6,4,8)  #에 따른 집값 시세
plot(0,0,type='n',xlim=c(0,10),ylim=c(0,10))
points(x,y)
#그 에 따라 정한 직선들, 우리집은 방크기5
abline(a=2,b=0.5)  #시세=4.5
abline(a=1,b=0.8,col='red')  #시세=5
#->제일 정확도 높은 회귀직선을 구하는게 중요

#그렇다면 제일 정확도 높은 회귀직선은?
#회귀 직선에 실제 값 넣었을때 차이가 제일 적은 직선
# =잔차제곱합(RSS-residual sum of square)이 최소가 될때
y <- c(1,6,4,8)  #실제 시세
y2 <- c(3,4,5,6)  #검정색선을 기준으로 했을때 2,4,6,8에 따른 예측시세
sum((y-y2)^2)  #이 RSS가 최소가 될때가 좋은 회귀직선

#optim()함수-어떤 함수의 최솟값을 구해줌
rss <- function(parameter){
  interception=parameter[1]   #절편
  slope=parameter[2]          #기울기
  base_y=c(1,6,4,8)
  new_y=c(2,4,6,8)*slope+interception
  rss=sum((base_y-new_y)^2)
  rss
}
rss(c(2,0.5)) #절편=2, 기울기=0.5
optim(c(2,0.5),rss)  #초기값 c(2,0.5)부터 시작해 최솟값이 나오는 절편,기울기 구함

abline(0.0005,0.95,col='green')  #최적의 회귀직선

#3D plot이용-rgl패키지
install.packages('rgl')
library(rgl)
rss <- function(interception,slope){   #rss(a,b)=c->a,b,c의 3차원
  base_y=c(1,6,4,8)
  new_y=c(2,4,6,8)*slope+interception
  rss=sum((base_y-new_y)^2)
  rss
}
#함수 vectorize과정 필요
vrss <- Vectorize(rss)
vrss
open3d()   #drag로 돌릴 수 있음
persp3d(vrss,
        xlim=c(-5,5),  #각 범위
        ylim=c(-2,2),
        zlim=c(6,15),
        n=100)    #점 100개 찍어 나타낼것

rgl.spheres(x=0.0005,y=0.95,   #구체 그리기 함수
            z=rss(0.0005,0.95),
            r=0.05,color='red')  #반지름과 색

#심화
#위 3차 그래프의 꼭짓점이 좋은 회귀직선의 a,b값
# a,b구하는 식, y=시세, x=방크기
# a=y평균-b(x평균)
# b=r(x와y의상관계수)*Sy(y표준편차)/Sx(x표준편차)
b=cor(x,y)*sd(y)/sd(x)
b
a=mean(y)-b*mean(x)
a


#실습
#작년에 본 시험을 기준으로 이번년도는 얼마큼 해야 pass할 수 있을까?
#올해 중간보고나니 40점, 교수님왈 중간+기말>100이어야 pass
#그러면 60점이상 받아야함, 만약 40점 받은 수준으로 공부하면 기말 60이상 나올까?
#안된단면 더 열심히 해야겠구나
mydata <- read.csv('./examscore.csv',header = T)
plot(mydata$midterm,mydata$final,xlab='중간',ylab='기말',asp=1)

#lm()함수 사용 lm=linear model
#lm(회귀식or모델식,data)의 구조
#lm(기말고사=기울기*중간고사+절편(+noise),데이터)
## but!! lm(기말고사=중간고사,데이터) 하면 자동으로 기울기,절편 고려해 계산해줌
result <- lm(final~midterm,mydata)  #기말고사점수를 중간고사 점수를 통해 알고싶어
result  #intercept=절편, midterm=기울기->얘가 회귀직선
summary(result)
abline(result)
result$coefficients
result$residuals #각 점으로 부터 회귀직선까지의 거리
summary(result$residuals)  #min-1QR-median-mean-3IQR-max

40*result$coefficients[2]+result$coefficients[1]  #->더 공부해야한다
newdata <- data.frame(midterm=40)
predict(result,newdata)  #predict()함수, newdata는 같은names의 데이터프레임이나 리스트



##다중회귀분석-두개 이상의 연속형 독립변수를 이용하여 한개의 연속형 종속변수 예측
#n개 예측변수의 다중회귀직선식:y=b0(절편)+b1χ1(요소1의 기울기)+b2χ2+b3χ3+....bnχn
#기본으로 주어지는 mtcar데이터 사용
mtcars
str(mtcars) #mpg(연비)=종속변수  wt,disp,hp,drat=독립변수
mymtcars <-mtcars[,c(1,4,6,3,5)] 
mymtcars
summary(mymtcars)
cor(mymtcars)   #5X5의 각 두개간의 상관계수 보여줌

#이미지로 보기
install.packages('car')
library(car)
windows(width=12,height=8)  #창 새로 뛰움
scatterplotMatrix(mymtcars,
                  regLine = list(method=lm,lty=1,lwd=3,col='red')) #lm표시
#첫째줄 보면 mpg는 hp,wt,disp(x축들)와 음의관계, drat(x축)과 양의관계

mymtcars.lm <- lm(mpg~hp+wt+disp+drat,mymtcars)
mymtcars.lm  #절편과 각 인자들 기울기
plot(mymtcars.lm)  #잔차그림
summary(mymtcars.lm) #hp와 wt는 mpg와 연관될 확률 높다, but disp와 drat은 아닐확률크다
#해석->estimate을 봄: wt의 경우 1증가할때마다 연비를 -3.5만큼 증가

#표준화
scale <- lm(scale(mpg)~scale(hp)+scale(wt)+scale(disp)+scale(drat),mymtcars)
scale
summary(scale) #단위 표준화->estimate을 보면 wt의 절대값이 가장큼-> mpg에 가장 큰 영향

install.packages('QuantPsyc')
library(QuantPsyc)
scale2 <- lm.beta(mymtcars.lm) #scale화 없이 바로 표준화 가능->wt가 가장 큰 영향을 끼침

#predict()-다중회귀직선식에 각 요소들을 다 넣음
pre <- data.frame(hp=c(150,170),wt=c(2.5,3),disp=c(250,300),drat=c(3.3,3.5))
predict(mymtcars.lm,pre)  #lm,데이터프레임 삽입->예상값 보여줌
predict(mymtcars.lm,pre,interval = 'confidence') #신뢰구간도 보여줌

