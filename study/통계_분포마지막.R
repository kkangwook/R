#대수의 법칙과 확률수렴

#모집단-모수, 표본-난수
#난수=정의된 범위에서 무작위로 추출된 수
#대수(많은수)일수록 내가 뽑은 표본들의 평균이 실제 평균에 가까워진다.
#전체 집단=모집단(u)을 X라 했을때 내가 뽑은 표본 집단들은 X1, X2, X3....Xn
#X1의 각 요소는 x11,x12,x13,.....x1n
#전체집단의 평균=E[X]
#표본 집단의 평균=X1의 평균=X1_bar, Xn의 평균=Xn_bar
#표본의 크기가 커질수록 Xn_bar는 E[x]에 수렴

#중심극한 정리-모든 통계 검정의 근본을 이룸
#모집단의 평균=모평균=µ, 모표준편차=σ라 할때


###############표본 n개를 뽑는다 가정
###표본의의 분포는 포본평균=µ, 표본표준편차=σ/sqrt(n)인 N(µ,σ^2/n)의 정규분포를 따른다



#이때 표본이 정규분포를 따르면 n은 상관X
#but 표본이 어떤분포인지 모를때는 n>30이어야 적용가능
##->적은수의 표본을 10000개뽑아도 정규분포 안됨
##->많은수(30이상)의 표본을 10개 만 뽑아도 정규분포됨

#예제
#수능 수학점수 평균=60, 표준편차=8, 3등급컷은 74점
#1. 랜덤하게 뽑은 '한' 학생의 수학점수가 74점 이상일 확률?
pnorm(74,60,8,lower.tail = F)  # 4%

#2. 랜덤하게 '50'명 뽑았을때 '50명의평균'수능점수분포는?  (표본 X의 X-bar와 관련)
#이때 분포종류를 몰라도 수사 30이상이므로 정규분포가 될것이라고 예상
# X_bar=N(60,8^2/50)=N(60,1.131)
u <- rnorm(10000,60,8)
plot(u,dnorm(u,60,8),ylim=c(0,0.5))
x <- rnorm(50,60,1.131)
points(x,dnorm(x,60,1.131),col='red') #표본의 평균들의 분포 모습->60에 더 모여있음

#3. 50명학생들의 평균 수능점수가 74점 이상일 확률은?
pnorm(74,60,1.131,lower.tail = F)  #거의 0이다->1명 뽑았을때보다 더 확률이 낮음

#회귀직석의 계수는 과연 믿을 수 있는가?
#->검정통계량, p-value, 신뢰구간등을 고려

#예시
#전국 2~10세의 아이들 나이별 몸무게 추정하기
w <- function(x){
  x*3+10
}
age <- sample(seq(2,10,by=1/12),3000,replace=T)
noise <- rnorm(length(age))*3
weight <- w(age)+noise
plot(age,weight,ylim=c(0,50))
lm(weight~age)
abline(10.168,2.974,col='red')

#전부는 조사못함, 시간과 돈문제
#표본뽑기-5명 뽑기
sample_age <-sample(seq(2,10,by=1/12),5,replace=T) 
sample_weight <- w(sample_age)+rnorm(length(sample_age))*3
points(sample_age,sample_weight,cex=2,col='blue',pch=16)
result <- lm(sample_weight~sample_age)
result
abline(result,col='blue')

sample_age2 <-sample(seq(2,10,by=1/12),5,replace=T) 
sample_weight2 <- w(sample_age2)+rnorm(length(sample_age2))*3
points(sample_age2,sample_weight2,cex=2,col='green',pch=16)
result2 <- lm(sample_weight2~sample_age2)
abline(result2,col='green')
#->회귀직선 계수는 변한다->따라서 믿음직 한지 보아야 한다