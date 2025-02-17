#파이차트-pie-전체는 100%
#카테고리컬 데이터에 사용 ex)성별
data <- read.csv('./examscore.csv',header = TRUE)
data$gender
#table함수
mytable <- table(data$gender) #유니크한 값으로만 보여줘서 숫자세줌
names(mytable) <- c('여자','남자')
mytable
class(mytable)

pie(mytable)   #카테고리컬 데이터가 들어간 애들의 table()값을 넣으면 됨

pie(mytable,
    main='학생 성별 분포')  #제목
pie(mytable,    #더 세부적으로
    radius=1,
    main='gender',
    lty='dashed',
    col='red',
    labels=c('female','male'))

text(0,0,'test')   #입력하고 싶은 문자열을 좌표에 넣음
text(1,1,'test2')
text(1,0,'test3')  #원의 반지름은 1이다

sum(mytable)
mytable[1]; mytable[2]

text(0.3,0.3,paste(round(mytable[1]/sum(mytable),4)*100,'%'))
text(-0.3,-0.3,paste(round(mytable[2]/sum(mytable),4)*100,'%'))

text(0.3,0.3,'33.33%',cex=3,font=7,col='blue') #추가 정보

#줄기-잎 그래프: stem and leaf plot
#거대한 하나의 줄기에 여러 잎들이 옆에 붙어있는 꼴
#데이터의 크기가 작을때 각각의 데이터 값을 확인할 수 있으면서전체적인 분포도를 볼 수 있음
#stem()함수 사용
data2 <- c(5,7,7,15,9,13,18,22,20,15,4,26)
stem(data2)

data <- read.csv('./examscore.csv',header = TRUE)
stem(data$midterm)  #기본이 10의 단위
stem(data$midterm,scale=2) #scale=2->2배로 확장한다->10/2=5단위
stem(data$midterm,scale=0.5) #10/0.5=20단위


#히스토그램-hist()함수 사용
#가장 많이 쓰이는 형태
hist(data$midterm) #형태 x축-값들의 범위, y축-빈도
#기본 x축단위는 10
hist(data$midterm,breaks=c(0,20,40,60,80)) #이런식으로 변경
hist(data$midterm,breaks=c(0:4*20)) #간편화 20단위(곱하는 값을 단위로)
hist(data$midterm,breaks=c(0:16*5))  #5단위
hist(data$midterm,breaks=c(0:16*5),
     main='중간고사 분포',  #제목
     xlab='중간고사 점수',  #x축
     ylab='학생수',   #y축
     col=c('red'))   #색


#상자그림-boxplot()함수사용
boxplot(data$midterm) # 0-25-50-75-100%
boxplot(data$midterm,horizontal=T) #가로로, T=TRUE
boxplot(data$midterm,horizontal=T,
        main='시험점수분포',
        xlab='점수')
data$midterm[1] <- 100 #하고 실행하면 아웃라이어 점 생성

boxplot(data$midterm,data$final,
        main='시험점수분포',
        xlab='점수',
        ylab='시험종류',
        names=c('중간고사','기말고사'),  #따로 지정해 줘야함,점수는 이름지어줄 필요X
        col=c('red','blue'),
        horizontal=T)

boxplot(data$midterm~data$gender) #보여줄것-점수, 구분은 성별로
boxplot(midterm~gender,data) #이렇게도 가능

#boxplot이론
#median-중앙값
num <- c(1,2,5,6,7,8)
median(c(1,2,5,6,7)) #중앙에 있는 5
median(c(1,2,5,6,7,8)) #짝수시 (5+6)/2

#quartiles-사분위수
# Q1(Q2보다 작은 데이터의 중앙값)-Q2(중앙값)-Q3(Q2보다 큰 데이터의 중앙값)
#num의 Q1=2 이때 Q2가 5.5이므로 1,2,5를 기준으로 함
#num 의 Q3=7
#Q2-상자 가운데의 굵은 줄
#Q3의 의미=75%의 데이터가 Q3보다 작다-상자의 윗쪽
#Q1의 의미=25%의 데이터가 Q1보다 작다-상자의 아랫쪽

# IQR=interquartile range-> IQR=Q3-Q1
#가상의 울타리-상자 외부의 두개의 바깥선
#upper fence=Q3+1.5*IQR
#lower fence=Q1-1.5*IQR
#upper와 lower를 기준으로 최솟값과 최댓값까지만 선으로 그음->얘가 가상의 울타리
#최소 혹은 최대가 upper나 lower fence를 넘어가면 아웃라이어로 표시

boxplot(c(1:10,20))
boxplot.stats(c(1:10,20)) #boxplot을 그리기 위해 무엇을 계산 했는지 보여줌
# $stats는 각각 lower fence-Q1-Q2-Q3-upper fence를 의미
# $n은 데이터 length, $out은 아웃라이어


#scatter plot-산점도, plot()함수 사용
#가장 많이 사용-두개의 변수가 어떻게 분포되어 있는가 제공
plot(data$midterm,data$final,  #중간고사 잘 볼수록 기말도 잘 본다를 보여줌
     xlab='중간고사',
     ylab='기말고사',
     main='시험점수 산점도',
     asp=1) #가로와 세로 비율을 일정하게 해줌
