# 패키지 설치 
install.packages("패키지명")
install.packages('stringr')
#현재 설치된 모든 패키지 보기
installed.packages()

#불러오기
library(패키지명)
library(stringr)
# 현재 로드된 패키지 보기
search()

#설치된 패키지 제거
remove.packages("plyr") 

#데이터 유형: Numeric, Character, Logical(T or F) 
mode(x)  # x의 데이터 타입 보기 

#데이터 자료구조 성격
class(x) # Array, List, Table 등

# 데이터셋 구조 보기 
str(x) 

# is.xxx(변수) -> T/F반환 
is.numeric(int) # TRUE
is.character(int) # FALSE
is.logical(boolean) # TRUE
is.na(x) # 결측치 여부 
is.nan(x) # NaN 여부
is.data.frame(x) # 데이터프레임 여부 
is.factor(x) # 범주형 여부

# 자료형 변환: d <- as.xxxx(d)
num <- as.numeric(x) #숫자형 변환 
fa <- as.factor(gender) #범주형 변환
log <- as.logical(x) # 논리형 변환 
df <- as.data.frame(x) # 데이터프레임 변환
li <- as.list(x) #리스트형 변환 
v <- as.vector(x) #벡터형 변환
today_date <- as.Date(today, '%Y-%m-%d %H:%M:%S') #날짜변환환
today_date_time <- strptime(x=today, format='%Y-%m-%d %H:%M:%S')#날짜시간변환

# 기본함수 : 7개 base 패키지에서 제공하는 함수 
help(mean) # 함수 도움말 
args(mean) # 인수 보기 
example(mean) # 예제 보기 

# 기본 데이터셋 -> data()로 가져옴
data() #현재 존재하는 데이터 셋들 보여줌
data(Nile) # 메모리 로딩 
print(Nile)

# 작업경로 
getwd() # 작업경로 확인 
setwd("작업경로") # 작업경로 변경 

# unlist: 리스트를 풀어서 벡터화화
x <- list(1:10,2:5) 
v <- unlist(x)  
x; v

# list 객체에 함수 적용 
lapply( c(x, y), max)  
sapply( c(x, y), max) 

# c()외의 객체: letters-> 순서대로 a부터 가져옴옴
z <- letters[1:5]
z
l <- letters[1:27] # 26을 초과하면 NA
l

#
x <- scan()
1
2
3
4
print(x)

# ifelse는 값여러개 동시에 들어가도 가능
score = c(80, 70, 40, 60, 90)
ifelse(score>60,'good','bad') #"good" "good" "bad"  "bad"  "good"

# for문 추가
# continue대신 next 사용
# 벡터로 for(i in c)가능
for(i in score){
  if(i<=60){
    next # python의 continue와 유사
  }else{
    cat(i,' 점수를 받았으므로 합격입니다.','\n') #print문
  }
}


vec <- c(1:20,3:5)
vec
#여러 함수들
range(vec) # 벡터 대상 범위 값-> 결과: c(1,20)
sort(vec) # 벡터 정렬
order(vec) # 벡터의 정렬된 값의 인덱스를 보여줌
rank(vec) # 벡터의 각 원소의 순위를 알려줌 
summary(vec) # 데이터에 대한 기본적인 통계 정보 요약- min-1qr-2qr-3qr-max등
table(vec) # 데이터 빈도수 (value_counts)

# 수학관련 추가 함수들들
abs(vec) # 절대값
sqrt(vec) # 제곱근
ceiling(vec); floor(vec); round(vec) # 값의 올림, 내림, 반올림
factorial(x) # 팩토리얼 함수
which.min(vec); which.max(vec) # 벡터 내의 최소값과 최대값의 !!인덱스!!
pmin(vec); pmax(vec) # 여러 벡터에서의 원소 단위 최소값과 최대값
prod(vec) # 벡터의 원소들의 곱
cumsum(vec); cumprod(vec) # 벡터의 원소들의 누적합과 누적곱 계산해가며 모두 보여줌
cos(vec); sin(vec); tan(vec) # 삼각함수 (also acos(x), cosh(x), acosh(x), etc)
log(vec) # 자연로그(natural logarithm)
log10(vec) # 10을 밑으로 하는 일반로그 함수(e^x) 

# 행렬관련 추가 함수들
x <- matrix(1:12,ncol=4);x
ncol(x) # 열의 수
nrow(x) # 행의 수
t(x) # 전치행렬 

#집합연산 내장함수
x <- c(1,3,5,7)
y <- c(2,3,7)
union (x, y) # 집합 x와 y의 합집합
intersect (x, y) # 집합 x와 y의 교집합
setdiff (x, y) # x와 y의 차집합
setequal (x, y) # x와 y의 동일성 테스트
7 %in% y # c가 집합 y의 원소인지 테스트 

#난수관련 함수
rnorm(n,mean,sd) #mu,sigma를 따르는 정규분포난수
runif(n.min,max) # min~max의 값을 가지는 균일분포난수
rbinom(n=10, size = 3, prob = 0.5) #이항분포를 따르는 난수
# n이 샘플수, size가 시도횟수, prob가 성공확률






#### FILE ####

#파이썬의 input함수처럼 인자받기
num <- scan() #입력하고 끝내고 싶으면 빈값+엔터
num


### 1. 파일불러오기기
#파일경로바로지정-> 하면 그냥 파일이름만적으면됌
setwd("C:/ITWILL/6.R_Statistics/data")


#read.table사용(read.csv보다 더 큰 범용성)
# 칼럼명 없는 경우 
st <- read.table('student.txt') # 제목 없음 
st
# 칼럼명 있는 경우 & 한글 인코딩 & 구분자(;) 적용 
st2 <- read.table('student2.txt', header = TRUE,  
                  encoding="UTF-8", sep = ";")
st2


# 인터넷 파일 불러오기 : 데이터 셋 제공 사이트 
titanic <- read.csv('https://vincentarelbundock.github.io/Rdatasets/csv/COUNT/titanic.csv')

# 파일 구조 보기 
str(titanic) 


# 교차분할표 : 범주형 변수 이용 
table(titanic$sex, titanic$survived) #pd.crosstab과 유사


# 줄 단위 텍스트 파일 읽기 
rfile = file("tax.txt", encoding="UTF-8") 
text <- readLines(rfile) # 줄 단위(문장 단위) 읽기 



### 2. 파일 데이터 저장

# (1) write.csv()
df <- subset(titanic, select = c(class, sex, survived) )

write.csv(df, 'titanic.csv', row.names=FALSE,  quote=FALSE)


# (2) write_xlsx()
install.packages('writexl') 
library(writexl)

write_xlsx(st_excel, path = "excel_test.xlsx")


# (3) text file 저장  
wfile <- file('text_data.txt', encoding="UTF-8") # 파일쓰기 객체 
writeLines(텍스트, 파일객체) # 줄 단위 저장 
close(wfile) # file 객체 닫기






####### 시각화 ######

# 1. 막대차트: barplot
chart_data <- c(305,450, 320, 460, 330, 480, 380, 520) 
names(chart_data) <- c("2016 1분기","2017 1분기","2016 2분기","2017
2분기","2016 3분기","2017 3분기","2016 4분기","2017 4분기") 

#세로
barplot(height=chart_data, width=1,
        ylim = c(0, 600),
        col = rainbow(8), 
        ylab = '매출액(단위:천원)', 
        xlab = "년도별 분기현황",
        main ="2016년 vs 2017년 분기별 매출현황")

#가로 : horiz = TRUE
barplot(height=chart_data, xlim = c(0, 600),
       horiz = TRUE,   #여기에 T
       col = rainbow(8), 
       ylab = '년도별 분기현황', 
       xlab = "매출액(단위:천원)",
       main ="2016년 vs 2017년 분기별 매출현황",
       legend.text = names(chart_data),  #범례추가하기
       args.legend = list(x = 'topleft'))

#서브플롯 : par(mfrow=c(행,열)) 미리 실행하고 추후에 그래프실행
VADeaths
par(mfrow=c(1,2)) # 1행 2열 그래프 보기
barplot(VADeaths, beside=T,col=rainbow(5),
        main="버지니아주 하위계층 사망비율(개별형)")
barplot(VADeaths, beside=F,col=rainbow(5),
        main="버지니아주 하위계층 사망비율(누적형)")


# 2. 점 차트: dotchart
par(mfrow=c(1,1)) #원상태로 돌리기
dotchart(x=chart_data, color=c("blue","red"), lcolor="black", #line color
         pch=1:2, labels=names(chart_data), xlab="매출액",
         main="2016년 vs 2017년 분기별 매출현황", cex=1.2)


# 3. 파이차트
pie(x=chart_data, labels = names(chart_data), 
    border = 'blue', col = rainbow(8), cex=1.2) # 보더, 색상cmap


# 4.히스토그램 -> 확률밀도함수
hist(iris$Sepal.Width, xlab = '꽃잎 넓이',
     breaks = 30, col="mistyrose", #breaks=k하면 bins=k와 동일
     main = '붗꽃의 꽃잎 넓이')
#freq=F -> 밀도화화
hist(iris$Sepal.Width, xlab = '꽃잎 넓이',
     breaks = 30, col="mistyrose", freq = FALSE, #밀도화
     main = '붗꽃의 꽃잎 넓이')


# 5. 산점도: plot
price <- runif(100, min = 1, max = 100)
par(mfrow=c(2, 2)) # 2행 2열 차트 그리기

plot(price, type="l") # 유형 : 실선
plot(price, type="o") # 유형 : 원형과 실선(원형 통과)
plot(price, type="h") # 직선
plot(price, type="s") # 꺾은선

# 하나의 plot에 2개 동시에
par(mfrow=c(1,1)) # 1개 차트 그리기
plot(iris$Sepal.Length, type = 'o', ann = FALSE, col='blue')
par(new = T) # 그래프 겹치기 
plot(iris$Petal.Length, type = 'o', axes = FALSE, 
     ann = FALSE, col='red')

#5-1산점도행렬 : pairs사용
pairs(iris[,1:4])


# 6.차트파일 저장법
jpeg("iris.jpg", width = 720, height = 480) # open
pairs(iris[,1:4]) # 차트 실행하고고
dev.off() # close 닫으면 자동저장


# 7. 3차원 산점도
install.packages('scatterplot3d')
library(scatterplot3d)

# 꽃의 종류별 분류 
iris_setosa = iris[iris$Species == 'setosa',]
iris_versicolor = iris[iris$Species == 'versicolor',]
iris_virginica = iris[iris$Species == 'virginica',]

# scatterplot3d(밑변, 오른쪽변, 왼쪽변, type='n') # type='n' : 산점도 제외 
# -> 일단 빈 3D plot 객체 만들기
d3 <- scatterplot3d(iris$Petal.Length, iris$Sepal.Length, iris$Sepal.Width, type='n')

# 3d에 산점도 표현 : 객체$poinst3d
d3$points3d(iris_setosa$Petal.Length, iris_setosa$Sepal.Length,
            iris_setosa$Sepal.Width, bg='orange', pch=21) #bg=background color

d3$points3d(iris_versicolor$Petal.Length, iris_versicolor$Sepal.Length,
            iris_versicolor$Sepal.Width, bg='blue', pch=23)

d3$points3d(iris_virginica$Petal.Length, iris_virginica$Sepal.Length,
            iris_virginica$Sepal.Width, bg='green', pch=25)



################################################
# 1. sqldf 패키지 활용 -> sql사용
################################################
install.packages("sqldf")
library(sqldf) # 패키지 로드


#sql쿼리 실행하기
df <- data.frame(id = 1:5, value = c(10, 20, 30, 40, 50))
sqldf("SELECT * FROM df WHERE value > 20") #cursor.execute와 유사
#iris세트 이용
sqldf("SELECT * FROM iris WHERE Species = 'setosa'")


################################################
# 2. dplyr 패키지 -> 전처리
################################################
install.packages("dplyr") # plyr 패키지 업그레이드 
library(dplyr)

# tibble() 함수 : 콘솔 크기에 맞는 데이터 구성
iris_df <- tibble(iris) # 콘솔 크기에 맞는 데이터 구성 
iris_df

# filter() 함수 : 행 추출
# 형식) df %>% filter(필터조건)
iris |>filter(Sepal.Width > 3) |> head() #iris[iris[S.W]>3]과 같음

# arrange()함수 : 칼럼 기준 정렬 -> sort_values와 유사
# 형식) df %>% arrange(칼럼명)
iris |> arrange(Sepal.Width) |> head() # 오름차순 
iris %>% arrange(desc(Sepal.Width)) %>% head() # 내림차순 

# select()함수 : 열 선택  -> df[[col1,col2]]와 유사
# 형식) df %>% select(칼럼명)
iris %>% select(Sepal.Length:Petal.Length, Species) %>% head()

# mutate() 함수 : 파생변수(변형) 생성
# 형식) df %>% mutate(변수 = 식)
iris %>% mutate(diff = Sepal.Length - Sepal.Width) %>% head() #diff라는 컬럼 생성

# summarise()함수 : 통계 
# 형식) df %>% summarise(변수 = 내장함수)
iris %>% summarise(col1_avg = mean(Sepal.Length),
                   col2_sd = sd(Sepal.Width))

# group_by()함수 : 집단변수 이용 그룹화 
# 형식) df %>% group_by(집단변수)
iris_grp <- iris %>% group_by(Species)
iris_grp
# 그룹별 통계 
summarise(iris_grp, mean(Sepal.Length))


## join: merge
# left_join() 함수 : 왼쪽 dataframe의 x칼럼 기준 열 합치기  
df1 <- data.frame(x=1:5, y=rnorm(5))
df2 <- data.frame(x=c(1:3,5:6), z=rnorm(5))

df_join <- left_join(df1, df2, by='x') # x칼럼 기준 : right_join()
df_join

# right_join() 함수 : 오른쪽 dataframe의  x칼럼 기준 열 합치기 
df_join <- right_join(df1, df2, by='x') # 결과 동일 
df_join



## bind: concat
# 2개 데이터프레임 생성 
df1 <- data.frame(x=1:5, y=rnorm(5))
df2 <- data.frame(x=6:10, y=rnorm(5))

# bind_rows() : 행 합치기 
df_rows <- bind_rows(df1, df2)
df_rows
# bind_cols() : 열 합치기 
df_cols <- bind_cols(df1, df2)
df_cols


######################################################
# 3. reshape2 패키지 :자료의 모양을 변경하는 함수
######################################################
install.packages('reshape2')
library(reshape2)

#read.csv(file=file.choose())하면 탐색기 열리면서 직접 고를수있음
data <- read.csv(file=file.choose()) # data.csv
data

## pivot
# 1) dcast()함수 이용 : 긴 형식 -> 넓은 형식 변경
wide <- dcast(data, Customer_ID ~ Date, sum) # 행~열,value에 사용될 집게힘스 
wide

##unpivot
# 2) melt() 함수 이용 : 넓은 형식 -> 긴 형식 변경
long <- melt(wide, id='Customer_ID') 
long

# 3) acast() 함수 : 3차원 형식으로 변경
data('airquality') #데이터 불러오기

# [월, 일] 기준으로 나머지 4개 칼럼을 묶어서 long 형식 변경 
air_melt <- melt(airquality, id=c("Month", "Day"), na.rm=TRUE) # 결측치 제외
dim(air_melt) # 568 4
# [일, 월, variable] 칼럼을 3차원 형식으로 변형   
air_acast<- acast(air_melt, Day ~ Month ~ variable) # [31,5,4]
air_acast


################################################
### 4. Data_Sampling -> 표본추출
################################################

# 1.홀드아웃 방식 : 70% vs 30%
idx <- sample(x=nrow(iris), size=nrow(iris)*0.7, replace=FALSE) #size사용

train <- iris[idx,] # 훈련셋 : 70%
test <- iris[-idx,] # 평가셋 : 30%

# 2. up/down 샘플링 : 최대or최소개수로 맞춤
install.packages('caret') #데이터 전처리, 교차검증용 등으로 사용
library(caret)
weather <- read.csv('weather.csv')
weather
# y변수 요인형 변경 
weather$RainTomorrow <- as.factor(weather$RainTomorrow) #팩터로
# y변수 제외 
weather_df <- subset(weather, select = -RainTomorrow)
dim(weather_df) #366개

# Up sample
up_weather <- upSample(weather_df, weather$RainTomorrow)
dim(up_weather) # 600개

# Down sample
down_weather <- downSample(weather_df, weather$RainTomorrow)
dim(down_weather) # 132 obs
