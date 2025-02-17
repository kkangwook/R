#검정력-test power->얼마나 믿을만한가
#p-value와 관련
#귀무가설-기존에 참이라고 여겨지는 가설->모집단의 평균은 16이다
#과학에서는 귀무가설은 항상:차이가 없다 or 효과가 없다

#대립가설-귀무가설을 엎을려는 가설
#과학에서는 대립가설: 차이가 있다, 효과가 있다

#p-value가 0.05보다 작아야 or 작을수록 귀무가설이 기각되고 대립가설이 참이된다
#ㄴ p-value가 작을수록 차이(효과)가 있다

#유의확률(p-value)=귀무가설이 참일때 기각역에 해당하는 확률
#유의수준 0.05의 의미:검정을 시행했을때 귀무가설이 참이라는 전제하에 5%는 옳지 않음
x <- seq(-3,3,length=300)
y <- dnorm(x)
plot(x,y,type='l')
abline(v=1.96)  #기각역
points(0,0.2,col='blue',pch=16) #귀무가설이 참일때 분포
points(2.5,0.005,col='red',pch=16) #귀무가설이 기각되는 부분

#검정력-귀무가설이 참이 아니라는 가정 하에 귀무가설이 기각될확률
#내가 데이터 조작을 했을때 이를 얼마나 잘 잡아내는지가 검정력
x2 <- seq(1,7,length=300)
y2 <- dnorm(x2,4,1)
plot(x,y,type='l',xlim=c(-3,7))
abline(v=1.96) #오른쪽이 귀무가설을 기각하고 대립가설이 참일때의 분포
points(x2,y2,type='l',col='blue')
points(4,0.2,col='blue',cex=3,pch=16) 

#예제
#에너지 소비 효율 1등급은 평균복합에너지 소비효율이 16.0이상인 경우
#다음은 15대의 복합에너지 소비효율이다
sample <- c(15.078,15.752,15.549,15.56,16.098,13.277,15.462,16.116,15.214,16.93,
            14.118,14.927,15.382,16.709,16.804)
#모분포의 분산은 2

#1. 표본에 의하여 판단할때 1등급이 나오는지 유의수준 5%하에서 기각역을 구하라
#가설 설정
#귀무가설: 평균<=16이다 (1등급이 아니다)
#대립가설: 평균>16 (1등급이다)
qnorm(0.95) #95퍼는 표준정규분포에서 1.645
#표본을 표준화->모평균을 빼고 표본표준편차(모표준편차/sqrt(n))으로 나눈다
#이 값이 1.645보다 크면 귀무가설이 기각되고 대립가설이 인정된다
#이 기각이 시작되는 부분이 기각역
#기각역 x_bar(표본의 평균)에 대해 x_bar-16/(2/sqrt(15))>=1.645
gigak <- 1.645*2/sqrt(15)+16
gigak   #의미:우리가 임의로 뽑은 표본의 평균이 16,84947이 넘어야 95퍼의 확률로 1등급이다
mean(sample) #->15.53이므로 95퍼의 확률로 1등급이 아니다

#2. 검정력을 구하기 위해 실제 평균복합에너지 평균값을 17이라고 가정할때(모평균=17)
#위의 검정의 검정력을 구하라->대립가설이 참이될때->기각역보다 클때
#표본평균이 16.84947보다 크거나 같게 관찰될 확률을 구한다
#표본평균의 표준화=16.84947의 표준화
(16.84947-17)/(2/sqrt(15))  #-0.2915보다 클 확률
pnorm(-0.2915,lower.tail = F)  #61퍼

##이때 검정력이 0.8(80%)이상인 검정을 좋은 검정이라고 간주
#sample의 개수가 늘어날수록 검정력증가




#양측검정vs단측검정

#양측검정
#귀무가설:모집단과 표본의 평균이 같다
#대립가설: 모집단과 표본의 평균이 다르다

#단측검정
#귀무가설:모집단과 표본의 평균이 같다
#대립가설1: 표본의 평균이 모집단보다 크다
# or 대립가설2: 표본의 평균이 모집단보다 작다 


## t-test:두 집단의 평균을 비교-모집단의 표준편차를 모를때 표본의 표준편차를 기준으로검정
#주로 boxplot사용

# 1. 일표본(one sample) T검정   t.test(x,X)
# 모집단 평균하고 그 모집단에서 뽑은 표본의평균하고 비교(모집단과 one group비교)

# 2. 이표본(two sample) T검정   t.test(x,y)
# 2-1. 독립표본(independent) T검정:독립 집단
#  독립적인 두 집단의 평균 비교

# 2-2. 대응표본(paired) T검정: 종속집단  t.test(x,y,paired=T)
# 한 집단의 두개 변수의 점수를 비교(전후로 효과가 있나 없나)



# 1. 일표본t검정 ex) 과자봉지에 적인 무게(30g)와 내가 직접 여러개 사서 평균내서 비교
#표본의 크기가 30이상이거나 10~29개일겨우 정규분포이면 사용가능->else시 일표본윌콕슨검정
m <- 30
sample <- rnorm(30,mean=38,sd=3)
boxplot(sample)
?t.test  # 표폰집단, mu=모집단의 평균, alternative=양측or 단측검정 종류
t.test(sample,mu=m,alternative = 'two.sided')  #양측검정:기각->다르다
t.test(sample,mu=m,alternative = 'less')   #단측-대립:표본이 작다->귀무인정->작지 않다
t.test(sample,mu=m,alternative = 'greater') #단측-대립:표본이 더 크다->귀무기각->대립인정

#정규성 테스트:shapiro.test()
#귀무가설: 정규분포이다
shapirosample <- rnorm(25,30,2)
shapiro.test(shapirosample) #->0.05보다 크므로 정규분포이다

#10보다 작거나 정규분포가 아니면 일표본 윌콘슨 검정 사용
wilcox.test(sample,mu=m,alternative='two.sided') #alt를 less greater도 가능




# 2-1. 독립표본(서로 독립전인 두 집단)
#조건:두 그룹이 독립+ 표본의 크기30이상이거나 10~29더라도 정규분포를 따르면됨
#등분산(두 집단 분산이 같은지) 여부->yes시 등분산으로, no시 이분산가정 독립표본t검정
male_h <- rnorm(40,170,5)
female_h <- rnorm(40,160,5)
df <- data.frame(x=c(rep('M',length(male_h)),rep('F',length(female_h))),
                 y=c(male_h,female_h))
df
boxplot(male_h,female_h)
boxplot(y~x,df)  #위랑 같음

#10~29일시
shapiro.test(male_h) #->정규성이다
shapiro.test(female_h)  #둘다 해줘야함->하나라도 정규성X->윌콕슨으로

#등분산 검정(레빈의 검정)
#귀무가설: 두집단의 분산이 같다
install.packages('lawstat')
library(lawstat)
?levene.test # 종속변수(키)먼저,독립변수(성별), mean
levene.test(df$y,df$x,location='mean') #->p=0.8->기각되지않아 등분산이다

t.test(male_h,female_h,var.equal = T) #분산이 같은가를 참으로->대립가설 참->키 다르다
t.test(y~x,df,var.equal=T)  #위랑 같은 의미 키를 본다~성별에따른
View(t.test(y~x,df,var.equal=T)) #이렇게 보는것 가능
#등분산이 아니면 var.equal=F 하면 됨
#alternative도 가능

#10이하거나 10~29더라도 정규분포 아니면:윌콕슨 순위합검정
wilcox.test(male_h,female_h,alternative='greater') #똑같은 형식으로





# 2-2 대응표본 t검정 :전과 후 비교
# 두 집단 종속관계이며 + 표본 크기 30이상 or 10~29이면 정규분포여야함
before <- rnorm(40,100000,15000)
after <- before+rnorm(40,3,2)
boxplot(before,after)
t.test(before,after,alternative='less',  #앞에 입력된 것이 더 작다를 의미
       paired=T)   # paired없으면 그냥 독립표본->0.05보다 작으므로 before가 after보다 작다

mean(before);mean(after) #물로 3만 증가해서 미미하지만 통계에서는 유의미하게 봄

#10이하거나 10~29더라도 정규분포가 아님->윌콕슨부호순위검정
wilcox.test(before,after,alternative='less',  #똑같은 형식으로
            paired=T)  #종속일때




#분산분석(ANOVA): 집단이 세개이상일때의 평균 비교
#분산분석.png보기
#종속변수 1개:단이변량 분석 vs 종속변수 2개이상:다변량 분산분석

#종속변수1개일때
#독립변수 1개: 일원분산분석
#독립변수 2개이상: 다원분산분석


#1-1 일원분산분석: 각 그룹이 서로 독립, 각각 정규분포를 따름, 각 분산이 동일해야함
#예제-A,B,C반의 수학점수 비교-독립변수(A,B,C반), 종속변수(수학점수)
#귀무가설:모든반 평균 같다
#대립가설: 귀무가설이 거짓이다:전부다를수있고, 하나만 다를 수 있고 두개가 다를수있음

#파일열기: file-import dataset-from excel-browse-copy
library(readxl)
dt <- read_excel("R_OneWay_ANOVA.xlsx")
View(dt)
str(dt) #tibble과 data.frame의 이중구조->데이터프레임화하기
dt <- as.data.frame(dt)
str(dt)
dt  #독립(반)을 한줄에, 종속(점수)를 한줄에 두어야함
class <- c(rep('A',30),rep('B',30),rep('C',30))
score <- c(dt$A반,dt$B반,dt$C반)
dt_df <- data.frame(class,score)
dt_df
boxplot(score~class,dt_df)

# A,B,C반이므로 독립
#각 반 30명이상->정규성 보장
levene.test(dt_df$score,dt_df$class,location='mean')   #등분산->등분산이다
myaov <- aov(score~class,dt_df)  #p-value안보여서 summary에서 봐야함
summary(myaov)   #누가 누구랑 다른지는 모르지만 A,B,C는 전부 같지 않다

##사후검정을 진행(tukey test)
#표본크기가 전부동일+등분산->tukey
#등분산이지만 표본크기 다름->scheffe
#등분산 아니고 표본크기 다름->games-howell
TukeyHSD(myaov) #p보기->A!=B, A!=C b==c라고 볼 수 있음


#1-2 이원분산분석- 두가지 요인
#ex) 반(A,B,C)과 성별(male,female)
dt_df$gender <- rep(c('male','female'),45)
dt_df
boxplot(score~class+gender,dt_df) #1,4가 a.female, a.male
anova_result2 <- aov(score ~ class * gender, dt_df)  #곱하기 사용
summary(anova_result2) #class간의 차이는 있고 gender간의 차이는 없다->전체적으로는 없다
TukeyHSD(anova_result2) #조합:(6*5)/(2*1)=15가지 비교 보여줌

#1-3 다원분산분석-요인 3가지 이상
dt_df$age <- rep(c('old','old','young','young','old','young'),15)
boxplot(score~class+gender+age,dt_df)
anova_result3 <- aov(score~class*gender*age,dt_df)  #곱하기 사용
summary(anova_result3)
TukeyHSD(anova_result3) #(12*11)/(2*1) 12개중 2개 선택


#2 다변량분산분석(MANOVA)-집단 3개이상, 종속변수 2개이상
iris  #제공되는 데이터-꽃잎,꽃받침 정보들과 종들
boxplot(cbind(Sepal.Length,Sepal.Width)~Species,iris)
manova_result <- manova(cbind(Sepal.Length,Sepal.Width)~Species,iris)
summary(manova_result)
summary.aov(manova_result)  #각 종속변수별로 보여줌

manova_result2 <- manova(cbind(Sepal.Length,Sepal.Width,Petal.Length,Petal.Width)~Species,
                        iris)
summary(manova_result2)
summary.aov(manova_result2)

#manova는 종속,독립 여러개도 가능
iris$gender <- sample(c('M','F'),150,replace = T)
manova_result3 <- manova(cbind(Sepal.Length,Sepal.Width,Petal.Length,Petal.Width)~Species+gender,
                         iris)
summary(manova_result3)
summary.aov(manova_result3) #각 종속변수에 따른 각각의 독립변수의 p-value보여줌



#카이제곱검정: 그룹들의 비율을 비교
#독립변수와 종속변수 둘다 범주형 데이터 ex)무서운 영화 호불호
#독립변수-성별, 종속변수-공포영화의 호or불호
#귀무가설-성별에 따른 선호비율 같다
#대립가설- // 다르다
r1 <- c(70,50)  
r2 <- c(30,50)
data <- rbind(r1,r2) #matrix형태
colnames(data) <- c('male','female')
rownames(data) <- c('prefer','dislike')
data
chisq.test(data)  #유의차가 있다->성별에 따라 선호도가 다르다
chisq.test(data,correct=F)  #교정 안하는게 좋음
