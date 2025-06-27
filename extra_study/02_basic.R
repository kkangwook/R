####### EDA preprocessing: 데이터 전처리 #######
 
setwd("C:/ITWILL/6_R_Statistics/data")
dataset <- read.csv("dataset.csv", header=TRUE) # 헤더가 있는 경우

# 1.데이터셋 특징보기기
dataset # 데이터셋전체보기
View(dataset) # 별도의데이터뷰어창에서출력됨
head(dataset) # 앞부분데이터셋6개
tail(dataset) # 끝부분데이터셋6개
head(dataset, 10) # 앞부분10개
names(dataset) # 변수명(컬럼)
attributes(dataset) # names(열이름), class, row.names(행이름)
str(dataset) # 데이터구조보기


# 2.결측치 처리
summary(dataset$price) # NA's 개수로 결측치확인

# 계산시 결측데이터제거방법
sum(dataset$price, na.rm=T) # 2362.9

#NA제거
price2 <- na.omit(dataset$price) # price에있는모든NA 제거


# 3. 이상치 처리

#잘못된 범주형 값 처리
data <- subset(data,data$gender == 1 | data$gender == 2) #이미알고있는경우
#연속된 변수 처리
plot(dataset$price) #이상치 보고 판단

# 4.파생변수 만들기예시들
house_type2 <- ifelse(house_type == 1 | house_type == 2, 0, 1) #if면 0, else면 1
grade = df$G1 + df$G2 + df$G3 # 전체성적 = 1~3학년 성적
Alcohol = (df$Dalc + df$Walc) / 2 * 100 # 알콜 소비량 =평일과 주말

# 5. 자료저장, 불러오기
write.csv(dataset,"data.csv", quote=F, row.names=F) # 저장
new_data <- read.csv("data.csv", header=TRUE) # 불러오기

# 6. 고급시각화: ggplot2
install.packages("ggplot2") # 미적요소객체+ 차트유형적용
library(ggplot2) # 메모리로딩

ggplot(data=mpg, aes(x=cyl, fill=factor(cyl))) + geom_bar(stat = "count")
ggplot(data=mpg, aes(x=cyl, fill=factor(drv))) + geom_bar(stat="count", position = "fill")
ggplot(data=mpg, aes(x=cty, fill=factor(cyl))) + geom_histogram(bins = 30)
ggplot(data=mpg, aes(x=cty, fill=factor(drv))) + geom_histogram(bins = 30)



############## 통계 ##################
-기술통계: 수집된 자료 특성파악(평균, 분산,표준편차,비대칭도)
-추론통계: 표본으로 모집단 추론(z검정, t검정, f검정 등)

-변수(변인) : 통계분석에서 사용되는 측정단위(연구 대상)
  - 범주형 vs 수치형

-독립변수 -> 종속변수에 영향
-매개변수 : 두 변수를 중간에서 연결시켜주는 변수(X → M → Y)
-조절변수 : 독립변수와 종속변수간 관계의 강도/방향을 조절하는 변수
-외생변수 : 독립변수와 종속변수의 관계를 잘못 이해 하게 만드는 변수

-척도: 변수의 데이터타입
  - 명목척도: 범주형데이터(1:남자, 2:여자)
     기술통계: 최빈수(각범주의출현빈도수)
     추론통계기법: 빈도분석, 비모수통계(교차분석/카이제곱검정)
    
  - 서열척도: 명목척도+순위(선호도 1순위,2순위,3순위)
     기술통계: 최빈수, 중앙값(평가사용불가)
     추론통계기법: 빈도분석,비모수통계(카이제곱검정, 스피어만상관분석등)
     
  - 등간척도: 각 수준간의 간격이 동일한 수치(섭씨온도)
     기술통계: 최빈수, 중앙값, 산술평균
     추론통계기법: 모수통계(t-검정, 분산분석,상관/회귀분석,요인분석등)
     
  - 비율척도: 절대원점(0)이 존재하는 등간척도(키)
     기술통계: 최빈수, 사분위수, 중앙값, 산술평균, 기하/조화평균(곱셈,나눗셈)
     추론통계기법: 모수통계(t-검정, 분산분석, 상관/회귀분석, 요인분석등)

          
-변동성 척도: 표준편차, 분산, iqr, 변동계수(cv)
    -변동계수= 표준편차/평균*100 %
    -coefficient of variation: 평균에 대한 상대적인 퍼짐정도
      값낮음-> 변동성 낮음, 서로 다른 스케일 비교에 용이

-skew
    왜도>0: 오른쪽에 엄지, 왜도<0: 왼쪽에 엄지
# 함수
install.packages("moments")  # 왜도/첨도 위한 패키지 설치   
library(moments)

skewness(x) #왜도
kurtosis(x) #첨도   
    
    
    
    
    
###### 확률과 통계 ######
확률: 현상을 수치적으로 예측
통계: 수치로 정보를 추출하여 미래사건 예측


-확률변수: 확률실험이나 관찰에서 발생가능한 모든 숫자를 갖는 변수
  --이산확률변수:나올 수 있는 값이 셀 수 있는 정수값(주사위)
     이산확률분포-> 확률질량함수로 표현(6개 값의 빈도)
     ex) 베르누이, binomial(이항), 포아송 분포등
#이항분포 함수
rbinom(n=100, size=2, prob=0.5) # 50퍼확률 동전 2번 던지기 100번시행

  --연속확률변수:특정 구간내의 모든 실수값(키)
     연속확률분포-> 확률밀도함수로 표현(곡선의 총 면적은 1!!!)
     ex) 정규(가우스)분포, 표준정규(z)분포, t분포, 균등분포등
#균등분포 함수
weight <- runif(n=1000, min = 45, max = 95)
pdf <- density(weight) #density ->확률밀도함수로 나타내기(각 값별 비율)
plot(pdf, col = 'black') #그래프로 그리기기
lines(pdf, col='red') # 라인 그리기

#정규분포 함수
height <- rnorm(n=1000, mean = 175, sd = 5)
pdf <- density(height)
lines(pdf, col='red')


-확률변수 x에 대해:
  p(x)의 범위는 0~1, 총합은 1

-정규분포:데이터의 수가 많아질수록 정규분포따름(중심극한정리)
  정규분포가정하에통계분석진행➔모수추정/검정
#정규성 검정
귀무가설(h0): 정규분포와 차이 없다(정규분포다)
대립가설(h1): 정균분포와 차이 있다
shapiro.test(x) 

-표준정규분포 (z분포): 평균0, 표준편차1로 변환
z=(x-u)/sigma

#함수
rnorm, dnorm, pnorm, qnorm

# extra: 테이블화 후 비율 보기
x <- table(c("A", "B", "A", "C", "A", "B"))
prop.table(x)

########## 모수추정 ##########
전수조사 vs 표본조사
 모수    vs   표본
 
-표집(sampling): 모집단에서 표본추출하는일
  방법:단순무작위추출, 층화추출, 체계적 추출, 군집추출

-표본크기 결정하기
install.packages("pwr")
library(pwr)
# 이 함수는 N(모집단크기)필요 X-> 무한대로 가정하고 돌림
pwr.t.test(d = 0.5, #모집단에서 어떤현상이 나타날확률, 모를경우0.5
           power = 0.8,
           sig.level = 0.05, # 유의수준
           type = "two.sample") #  "two.sample", "paired", "one.sample"
#이 외에도
pwr.chisq.test() # 카이제곱
pwr.r.test() #상관관계
pwr.f2.test() # 회귀분석

# 표준오차(SE): 표본 평균이 실제 모평균과 얼마나 차이가 있는지
se <- sd(x) / sqrt(length(x)) # 표준편차/루트(표본개수)


# 여러 표본분포 유형
z분포: 표준화시킨정규분포, 표본크기가크고, 모분산이알려진 경우
T분포: 정규분포와매우유사 표본크기가적고, 모분산이알려지지않은경우
X2분포: 표본분산의확률분포
F분포: 표본분산들의비율에대한확률분포


# 추정 vs 검정
추정: 모수(모평균 등)가 '얼마일 것 같다고 계산'
검정: 어떤 주장(가설)이 맞는지 아닌지 판단

###모수추정 
-점 추정: 모수를 하나의 값으로 추정 (25이다)
  ex) 표본 평균, 표본분산 등 
-구간 추정: 모수가 존재할 것으로 예상되는 구간을 추정(20~30사이일것이다)
  신뢰구간 : 신뢰수준 하에서 모수 포함 범위(하한,상한)
  ex) 조사결과 만족도 50%이고 오차범위 3%에서 신뢰수준 95%이면?
    -> 조사를 100번 반복하면 95번은 [47~53%]범위에 있다.

# 모푱균 신뢰구간 구하는법(키,몸무게,가격)
t.test(x) #하면 95 percent confidence interval:밑에 범위로 나옴

# 모비율 신뢰구간 추정하는법(지지율, 선호도 등)
prop.test(x =800*0.567, #표본조사 결과 양성 **횟수**(56.7%)
          n = 800, # 표본수수
          conf.level = 0.95) #신뢰구간




########## 모수검정 ############
조건: 1. 정규분포 2. 분산같아야함 3. 변수는 숫자형이어야함

모수: 수치형이며 정규분포 따름(z겁정, t검정)
비모수: 범주형이며 정규분포 따른다고 전제할 수 없는 경우(카이제곱검정)


### z검정 vs t검정
z: 모집단의 분산을 암
T: 모집단의 분산을 모름 


## z검정
install.packages('BSDA') # z.test() 제공 
library(BSDA)

z.test(x,  #데이터
       alternative = 'two.sided', #"greater", "less" or "two.sided"
       mu=168, #평균
       sigma.x = 3, #표준편차
       conf.level = 0.95) #신뢰수준
# -> z가 0에 가까울수록, p-value가 유의수준(0.05)보다 클수록 mu와 차이 없다




############## 카이제곱 검정(χ^2) ###############
# 자료준비
setwd("C:/ITWILL/6.R_Statistics/data")
dataset <- read.csv("dataset.csv", header=TRUE)
dataset
x <- dataset$gender # 리코딩 변수 이용
y <- dataset$job # 리코딩 변수 이용
df <- data.frame(Level=x, Pass=y) # 데이터 프레임 생성 
table(df) # 빈도보기


## 1. 일원 카이제곱검정(변인1개)
# 적합성 검정(기대와 일치하는지)
observed <- c(4, 6, 17, 16, 8, 9) # 관측도수
expected <- rep(10, 6)  # 기대도수->모두 10

chisq.test(x = observed,
           p = expected / sum(expected)) # 0~1사이 확률로
  # 0.05이하면 예상했던 기대치와 차이가 있다

## 2. 이원 카이제곱검정(변인 2개)
# 독립성검정: 성별과 제품 선호도 사이 관련성 여부 
install.packages("gmodels") # gmodels 패키지 설치
library(gmodels) # CrossTable() 함수 사용
CrossTable(x=df$Level, y=df$Pass) 

CrossTable(x=df$Level, y=df$Pass, chisq = TRUE) # 교차분할표 + 검정 
  # 카이제곱값이 클수록 변수 사이 독립성이 깨졌을 가능성이 큼 
  # p-value가 0.05이상이면 두 변수는 독립(서로 관련없음)
  # p-value가 0.05이하면 두 변수는 관련이 있다 (독립 아님)
    # -> 성별에 따라 제품 선호도가 다르다 




############### 상관분석 ##############
## 1. 피어슨 상관계수(수치 vs 수치)
±0.9이상: 매우 높은 상관관계
±0.9 ~ ±0.7: 높은 상관관계
±0.7 ~ ±0.4: 다소 높은 상관관계
±0.4 ~ ±0.2: 낮은 상관관계
±0.2: 미만 상관관계 없음

cor(result, method="pearson") #전체 nXn으로 보기
cor(x,y, method="pearson") # 두개 변수 사이만 보기

# 공분산(covariance): -무한~ +무한 사이 값을 가지는 상관계수
cov(x,y)


## 2. 스피어만 상관계수(서열척도 vs 서열척도)
# 예) 국어성적 석차와 영어성적 석차의 관계
cor(국어성적_석차, 영어성적_석차, method = "spearman") 


## 3. 범주 vs 범주는 카이제곱검정





############# 선형회귀 ###############

## 단순선형회귀
model <- lm(formula= y ~ x, data)
y_pred <- predict(model, data.frame(iq=150))# 예측시 df형태로 

## 다중회귀분석
model2 <- lm(formula=y ~ x1 + x2 + x3, data=df)
summary(model2)# 다중회귀분석 결과

## 변수선택법 + 다중공선성 문제
# Stepwise 알고리즘 
-전진선택법 : model에 독립변수 한 개씩 추가
-후진제거법 : 중요도가 낮은 독립변수 한 개씩 제거
-단계선택법 : 전진선택법 + 후진제거법

# 단계선택법 함수
library(MASS)
step <- stepAIC(model, direction = 'both') #lm 모델 넣기기 
  # -> AIC 지수값이 가장 작은 모델 선택

#다중공선성 문제: vif
install.packages("car")  # vif사용위해해
library(car)
vif(model)
sqrt(vif(model)) > 2 # root(VIF)가 2 이상인 것은 다중공선성 문제 의심 

## 가변수 만들기-> 범주형 데이터를 수치형 데이터로
# 범주형데이터를 factor로 만들면 자동으로 모델 숫자로 인식
insurance$sex <- as.factor(insurance$sex)
insurance$smoker <- as.factor(insurance$smoker)
insurance$region <- as.factor(insurance$region)



############# 분류 #################
## 1. 로지스틱 회귀(이진분류)
model <- glm(y ~ x1 + x2, data = df, family = binomial)

## 2. 다항 로지스틱 회귀
library(nnet)
model <- multinom(y ~ x1 + x2, data = df)

## 3. decision tree: rpart or C5.0사용(얘가 더 정확)
install.packages('rpart') # rpart() : 분류모델 생성 
install.packages("rpart.plot") # prp(), rpart.plot() : rpart 시각화
install.packages('rattle') # fancyRpartPlot() : node 번호 시각화 
install.packages("C50")

library(rpart) 
library(rpart.plot) 
library(rattle) 
library(C50)

# 모델 생성
model <- rpart(y ~ ., data = df) # 모든 x변수에 대해
# or C5.0으로
model <- C5.0(y ~ ., data = df)
model # - 중요한 x변수 확인 

# tree 시각화 
rpart.plot(model)

# 모델 평가 
y_pred <- predict(model, data.frame(x_test), type='class') # Y class 예측 

# 1) 혼동행렬  
tab <- table(y_true, y_pred)

# 2) 분류정확도 : 정분류 비율 
accuracy <- (tab[1,1]+tab[2,2]) / sum(tab)

# 3) 정확도(Precision) : 모델 True를 True로 예측한 비율
precision <- t[2,2] / sum(t[,2])

# 4) 재현율(Recall) : 실제 True를 True로 예측한 비율=민감도(Sensitivity)
recall <- t[2,2] / sum(t[2,])

# 5) f1 score : 정확도와 재현율의 조화평균 
f1_score <- 2 * ((precision * recall) / (precision + recall))




################ 군집화 #################

### 1. 계층적 군집분석(hclust)

install.packages("cluster") # hclust() : 계층적 클러스터 함수 제공
library(cluster) # 일반적으로 3~10개 그룹핑이 적정

# 1) 데이터터 생성
p1 = c(1,1)
p2 = c(2,1)
p3 = c(2,4)
p4 = c(4,3)
p5 = c(5,4)
df = data.frame(p1,p2,p3,p4,p5)
mt = t(df) # 전치행렬 
mt <- data.frame(mt)

# 2) 데이터 대상 유클리드 거리 생성 함수
distance <- dist(mt, method="euclidean") # method 생략가능
distance # 유클리드 거리 

# 3) 모델 생성
hc <-  hclust(distance,
              method="single") #"ward.D", "single", "complete", "average", "centroid"등 
# 4) 덴드로그램 
plot(hc, hang=-1) 

# 5) 군집분석 속성  
names(hc) # "height"  "method" "dist.method"   
hc$height # 유클리드 거리 
hc$method #   군집화 방법 
hc$dist.method # 거리계산식 


# 6) 군집 n개로 분류
rect.hclust(hc, k=3, border="red") # 덴드로그램에 표현, 선 색 지정

# 7) 군집 번호매기기
cluster_num <- cutree(hc, k=3) # 군집번호
cluster_num

# 8) 군집번호을 칼럼으로 추가 
iris$cluster <- cluster_num


### 2. 비계층적 군집분석(KMEANS)

# 1) 모델 생성
model <- kmeans(mt, 3) #기본 내장함수로 존재재
model

# 2) 모델 정보 
model$cluster # 분류된 클러스터 정보 
model$centers # 군집별 각 변수의 중앙값 
model$size # 각 군집의 크기 

# 3) 모델 평가 척도 : 제곱합의 총합    
model$betweenss # 분리도 : 군집 간의 거리 제곱합
model$totss # 제곱합의 총합 = 분리도 + 응집도

# 4)모델의 우수성 평가  = 분리도 / 제곱합의 총합 : ppt.23참고 
model$betweenss / model$totss  # 0.925
# -> 1에 가까운 값일 수록 좋은 model

# 5) 원형데이터에 군집수 추가
mt$cluster <- model$cluster #여기에 각 샘플별 군집정보 포함
mt



############# 주성분 분석 #################
#모든 변수들의 공통적인 선형 변화를 통해 상관성있는
# 변수들간의 정보 단순화(누적변화량85%정도이상이면주성분으로도출)

# 1.데이터
df # 고차원의 df

# 2. eigenvalue와 eigenvector로 시각화해보기(생략가능)
en <- eigen(A)
value <- en$values # eigenvalue
vec <- en$vectors # eigenvector

plot(value, type="o") #엘보우 포인트까지가 쓸 주성분 개수

# 3. PCA함수 사용
PCA <- prcomp(df, center = TRUE, scale = TRUE)

# 4. 시각화: 엘보우와 biplot으로 주성분 개수 설정
plot(PCA, type="l",  sub = "Scree Plot") 
biplot(PCA)

# 5. 새로운 데이터 셋 생성
new_dataset <- PCA$x[,1:3] # 1~3주성분 선택 