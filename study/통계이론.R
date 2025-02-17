#평균과 중앙값->중심을 나타내는 두가지 지표

# 평균: x̄로 나타냄(x바) (x1+x2+x3+...+xn)/n

#중앙값
#홀수일때-가운데 숫자: n개일때 x[(n+1/)2]
#짝수일때-가운데 두개의 평균: (x[(n/2)]+x[n+2/2])/2

#평균VS중앙값
#평균이 극단적인 값에 더 민감
#대칭분포:평균값과 중앙값이 같음, 기운분포: 두 값이 다름
library(png)
library(raster)
dis <- readPNG('distribution.png')
plot(as.raster(dis))  #그림 참고

#분포의 퍼짐을 보여주는 지표=IQR=Q3-Q1->전체 데이터의 50%
# 중앙으로 부터 얼마나 퍼져있는가
data1 <- c(1,2,2,3,3,3,4,4,5)
data2 <- c(1,2,3,4,5,6,7,8,9)

hist(data1,breaks=c(0:5*1))
hist(data2,breaks=c(0:10*1)) #비교했을때 data2가 더 멀리 분포

boxplot(data1,data2,names=c('data1','data2'))  #data2의 IQR이 더 크다->더 멀리 분포
boxplot.stats(data1)  #IQR=4-2=2 ->전체 데이터의 50퍼가 range2안에 있다
boxplot.stats(data2)  #IQR=7-3=4 ->전체 데이터의 50퍼가 range4안에 있다


#분포의 퍼짐을 보여주는 지표-분산과 표준편차
#표본분산:평균을 기준으로 얼마나 퍼져있는지
# ㄴ->평균으로 부터 각 숫자들까지의 거리가 어케되며 전부 제곱하여 더하고 갯수-1로 나눔
#n-1로 나누는 이유는 값을 더 정확히 추정해 주기 위해(n이 커지면 n이나 n-1이나 별 차이X)
#ex) 1,2,3,4,5의 경우 평균=3 -> {(1-3)^2+(2-3)^2+(3-3)^2+(4-3)^2+(5-3)^2}/(5-1)
#표본분산 기호=S^2
var <- readPNG('variance.png')
plot(as.raster(var))  #표본분산 식

#표준편차=sqrt(표본분산)-루트 씌어줌->단위가 원래 데이터 셋의 단위와 일치하게 됨

set.seed(1)  #얘까지 포함해서 같이 돌리면 다음에 set.seed(1)하고 하면 같은 수 나옴
x <- sample(1:10,6)
x
x_bar <- mean(x)
x-x_bar
(x-x_bar)^2
my_var <- sum((x-x_bar)^2)/(6-1)  #표본분산 계산식
var(x)   # 표본분산 함수
sqrt(my_var)  #표준편차 계산식
sd(x)  #표준편차 함수-standard deviation

#quiz
x <- rep(5,10)
y <- c(1:10)
z <- c(3,4,5,6,7,4,5,6,5,5)

hist(x,breaks=c(0:10))
hist(y,breaks=c(0:10))
hist(z,breaks=c(0:10))

sd(x); sd(y); sd(z)  #표준편차가 클수록 멀리 분포->y>z>x순서로 멀리 분포


#최빈값 함수 만들기->데이터에서 가장 자주 발생하는 값
x <- c(1,3,9,7,1,2,2,5,3,3,3)
table(x)  #3이 최빈값이다
statmode <- function(x){
  tab <- table(x)
  y <- which.max(tab)
  names(tab)[y]
}
statmode(x)

#sort()함수-크기가 작은것 부터 큰것으로
sort(x)
x
sort(table(x))

#summary()함수: 최소-Q1-Q2-평균-Q3-최댓값 보여줌
mydata <- read.csv('examscore.csv',header=T)
summary(mydata$midterm)

#카테고리컬 변수 만들기 character()함수 사용
x <- character(length=30)  #vector(length=n)과 비슷
x[mydata$midterm<49.75] <- 'low'
x[mydata$midterm>=49.75] <- 'high'
x
mydata$value <- x
mydata

mydatatable <- table(mydata$value)
pie(mydatatable,labels=names(mydatatable),  #lable의 이름은 table의 이름을 그대로 사용할 것이다
    main='high low')
