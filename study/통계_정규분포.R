# 정규분포는 평균과 표준편차가 주어졌을때 엔트로피를 최대화 하는 분포

#정규분포=가능도함수=확률밀도함수
# 1-정규분포를 구성하는 요소(모수)-평균(중심),분산or표준편차(분포의 퍼짐)
# 2-함수: rnorm() <- 표본을 추출  dnorm() <- 가능도 함수의 정보를 담고 있음
# 3-모든 정규분포는 68-95-99.7 규칙을 따른다
# dnorm=density normal distribution

#dnorm(15,mean=30,sd=7)->평균30, sd7의 정규분포에서 15가 나올 확률을 의미

x <- seq(-3,3,by=0.05)
y <- dnorm(x) #각 값들에 해당하는 값을 나타냄
plot(x,y,type='l',
     main='normal distribution') #정규분포의 생김새

sample <- rnorm(1000)
hist(sample,probability = T)  #스케일을 가능도 함수에 맞춤
points(x,y,type='l')  #->rnorm을 뽑았더니 dnorm의 분포를 가지고 있구나

#데이터의 평균과 분산을 알면 데이터의 정규분포표를 그릴 수 있다
x <- seq(-4,4,by=0.05)
y <- dnorm(x,mean=0,sd=1)   #기본 설정 
plot(x,y,type='l',
     main='normal distribution',xlim=c(-4,4),ylim=c(0,0.8))

y2 <- dnorm(x,mean=1,sd=1)
points(x,y2,type='l',col='red')  #중간이 1로 이동

y3 <- dnorm(x,mean=0,sd=2)
points(x,y3,type='l',col='blue')  #분산증가->퍼짐 증가, y값 감소

#정규분포 표현법- N(µ,σ^2) 
# µ(뮤)=평균
# σ^2(시그마제곱)=분산, σ=표준편차(sd)
#dnorm(x,1,2)의 의미=N(1,4)
#dnorm(x)는 N(0,1)

sample1 <- rnorm(10,mean=0,sd=1)
sample2 <- rnorm(10,mean=0,sd=0.5)
x <- seq(-4,4,by=0.05)
y <- dnorm(x,mean=0,sd=1)   
plot(x,y,type='l',
     main='normal distribution',xlim=c(-4,4),ylim=c(0,0.8))
y2 <- dnorm(x,mean=0,sd=0.5)
points(x,y2,type='l',col='blue')

points(sample1,rep(0,length(sample1)),col='black')  #sd=1의 경우 실제값이 더 멀리 분포
points(sample2,rep(0.05,length(sample2)),col='blue') #sd=0.5는 0에 가까울 확률 더 높음


# 정규분포는 평균, 분산과 상관없이 모두 68-95-99.7규칙을 따름
# 68%는 (평균-표준편차,평균+표준편차) 범위에 속함
# 95%는 (평균-2표준편차,평균+2표준편차)범위
# 99.7%는 (평균-3표준편차,평균+3표준편차) 범위
mysample <- rnorm(1000,mean=3,sd=2)
hist(mysample)  #정규분포를 얼추 따른다
sum(mysample>3-2&mysample<3+2)/1000   #대략 67퍼
sum(mysample>3-4&mysample<3+4)/1000   #대략 94퍼
sum(mysample>3-6&mysample<3+6)/1000   #대략 99.7퍼

#예제
#학생들의 중간고사 점수가 정규분포 N(10,2^2)을 따름
#나의 점수는 12점, 학생수는 1000명
# 1.시험점수 10~14점 사이인 학생은 대략 몇 명?
midterm <- rnorm(1000,10,2)
plot(midterm,dnorm(midterm,10,2)) #6~14까지가 95%->95%/2*1000=475명

#2 나보다 시험점수가 낮은애들은 몇명?
#(50%+68/2%)*1000=840명

#3 시험점수가 8점~14점 사이 학생 수는?
(0.68+(0.95-0.68)/2)*1000

#4 학생들의 시험점수 분포의 IQR은 4보다 클까?
#IQR은 Q3-Q1=50%->65퍼의 차이가 4이므로 IQR은 4보다 작을것
#Q1은 8과10사이, Q3는 10과12사이
qnorm(0.75,10,2)-qnorm(0.25,10,2)

#정규분포의 표준화
# a~b까지 나오는 룰렛을 0~1로 바꾸는 식
# 전부에 a를 빼서 0~b-a를 한 다음 전부에 b-a로 나눔->0~1룰렛 완성
## 이는 평균을 빼서 표준편차로 나눈것과 비슷

#정규분포를 표준 정규분포로 변환
# X~N(µ,σ^2)를 Z~N(0,1)로 바꾸는 과정, Z=(x-µ)/σ  (x는 X의 요소)

#예제-한국지리~N(80,5^2)  범과정치~N(75,6^2)
#보미는 한국지리에서 77점, 이삭은 법과정치에서 74점
#대학교는 둘중 누구를 뽑아야할까?
bomi <- (77-80)/5  #-0.6
isaac <- (74-75)/6  #-0.1666
bomi<isaac   #실제점수는 보미가 더 높아도 이삭을 뽑아야 한다

#실제 수능에서 탐구 표준점수=Z*10+50->보미는 44점, 이삭은 48.7점  ->50보다 높으면 평균이상
#국어 수학은 Z*20+100(가중치가 탐구보다 더 높다)

#표준정규분포->정규분포는 너무나도 많고 매번 확률 구하기 어려움(넓이)
#따라서 표준정규분포로 변환하고 표준정규분포표를 활용

#예시 P(Z<=2)=0.9772  (표의 2.00값 사용: -무한~에서 x까지의 값)
#P(z>=1.45)=1-P(z<1.45)=1-0.9265=0.0735  P=probability

#정규분포 X~N(3,2^2)에 대한 P(X<3.12)
#->P(Z<(3.12-3/2))=P(Z<0.06)->0.5239 by표

#but R에서는 표준화 필요 X->함수가 있다
?pnorm()   #probability
#lower.tail=T:q보다 작은 값의 확률을 구한다는 의미
pnorm(q, mean = 0, sd = 1, lower.tail = TRUE, log.p = FALSE)
pnorm(3.12,mean=3,sd=2)

#P(X>=3.12)
pnorm(3.12,mean=3,sd=2,lower.tail = F)

#이렇게도 가능
pnorm(c(0,3.12),mean=3,sd=2)

#예제1-1숙제점수~N(10,2^2), 학생수=75, 나(12점)보다 낮게 받은 학생수는?
pnorm(12,mean=10,sd=2)*75

#예제1-2 보미는 상위 8퍼에 듬, 보미의 성적은?
qnorm(p,mean=0,sd=1,lower.tail = T,log.p = F)  #q=quantile, p=probability
qnorm(0.92,10,2)  #상위 8퍼=92%
qnorm(0.08,10,2,lower.tail = F)  #이런식으로도 가능

#이렇게도 가능
qnorm(c(0.05,0.95),0,1)
