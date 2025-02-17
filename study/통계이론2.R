#상관계수-correlation coefficient-r-단위 존재X
#두 변수 사이의 관계
library(png)
library(raster)
cc1 <- readPNG('상관계수그림1.png')
plot(as.raster(cc1)) #s는 표준편차

#상관계수는 두 변수의 선형적인 관계를 측정하는 지표
#r은 언제나 -1에서 1사이의 값을 가짐
#r>0:양의 상관성->양의 기울기
#r<0:음의 상관성->음의 기울기
#r=0:선형상관성이 존재X->변수사이의 관계가 존재하지 않는다는 의미는 아님
#직선이 될수록 r의 절대값이 1에 가까워짐
cc2 <- readPNG('상관계수그림2.png')
plot(as.raster(cc2))

#예시
x <- c(1,3,5)
y <- c(3,5,7)
mean(x);mean(y)
sd(x);sd(y)
r=1/(3-1)*{((1-3)/2*(3-5)/2)+((3-3)/2*(5-5)/2)+((5-3)/2*(7-5)/2)}
r  #1의 값->x와y는 완벽한 선형관계이다
plot(x,y,col='red',xlim=c(0,7),ylim=c(0,9))  #기울기 1

# 상관계수함수:cor() correlation
data <- read.csv('examscore.csv',header = T)
x_bar <- mean(data$midterm)
y_bar <- mean(data$final)
x_s <- sd(mydata$midterm)
y_s <- sd(mydata$final)


r <- 1/(30-1)*sum((data$midterm-x_bar)/x_s*(data$final-y_bar)/y_s)
r
cor(data$midterm,data$final) #상관계수 함수
cor.test(data$midterm,data$final) #0.05보다 작아 r=0이라는 귀무가설 기각->연관성이있다

plot(data$midterm,data$final,  #어느정도 일직선의 모습->r=0.67
     main='산점도',xlab='중간고사',ylab='기말고사',asp=1)

title(sub=paste('상관계수:',round(r,4)),  #sub하면 plot밖에
      adj=1, #오른쪽 정렬
      col.sub='red') #sub의 색
abline(v=x_bar)
abline(h=y_bar)

#상관계수 공식 해석 xi-x_bar
plot(data$midterm-x_bar,data$final-y_bar,  #가운데가 0,0이 됨
     main='산점도',xlab='중간고사',ylab='기말고사',asp=1);abline(v=0);abline(h=0)

# (xi-x_bar)/sd(x)
x_z <- (data$midterm-x_bar)/x_s
y_z <- (data$final-y_bar)/y_s
plot(x_z,y_z,  #-2에서 2사이에 분포
     main='산점도',xlab='중간고사',ylab='기말고사',asp=1);abline(v=0);abline(h=0)

#그다음 각각 곱해서 더함
#1,3사분면은 양수, 2,4분면은 음수->이때 1,3에 더 많아서 총 더하면 양수
#그리고 원점에서 더 멀리 떨어질 수록 곱셈값이 커짐->상관계수에 더 큰 영향력
plot(x_z,y_z,  #-2에서 2사이에 분포
     main='산점도',xlab='중간고사',ylab='기말고사',asp=1,
     col=c('blue','red')[as.factor(sign(x_z*y_z))], #as.factor는 factor화, sign은 양수면 1, 음수면 -1 돌려줌 
     cex=abs(x_z*y_z)) # 절대값 크기에 따라 점 크기
#29로 나누면 결과적으로 양수의 값이 나올것이라는 것으로 해석 가능