#data frame=2차원 모양의 프레임
#행렬은 구성원들이 모두 같은 타입, but df는 각 열마다 다를 수 있음
matrix(c(as.character(c(1:5)),6:10),ncol=2)  #전부 문자형
data.frame(col1=c('one','two','three'),col2=c(1,2,3)) #열마다 다를 수 있음

#데이터 분석에서 가장 많이 쓰이는 형태
#데이터는 각 열에 들어감
name <- c('kkangwook','bomi')
birthmonth <- c(5,4)
my_df <- data.frame(name,birthmonth)
my_df

# $,[[]],행렬형태 전부로 인덱싱 가능
my_df$name   # $
my_df[1]     #[]
my_df[[1]]   #[[]]
my_df[,1]    #행렬
dim(my_df)

#엑셀은 주로 csv파일
mydata <- read.csv('examscore.csv',header=TRUE) #header=TRUE:첫번째 행도 데이터로 받아들여라
#데이터 프레임에 적합한 열 이름 할당 가능, FALSE시 열이름이 V1, V2 형태같이 됨
mydata
dim(mydata)

#인덱싱
mydata$midterm
mydata[[2]]
mydata[,4]
mydata[1:4,2:3]  #데이터프레임 형식
mydata[1:4,2]    #벡터형식->drop=FALSE가 필요

#midterm점수가 30점 이하인 아이들 고르기
mydata[mydata[,3]<=30,1]
mydata[mydata$midterm<=30,]  #더 쉽게
which(mydata$midterm<=30)

#NA 대처
mydata[1,2] <- NA
mydata
complete.cases(mydata$gender)  #NA가 있는 것에만 FALSE
complete.cases(mydata)   #행에 하나라도 NA가 있으면 FALSE, 하나라도 없으면 TRUE
mydata[complete.cases(mydata),]  #NA있는 1번째 행이 빠짐

#구성원소 추가, 삭제, 변경
mydata$total <- mydata$midterm+mydata$final   #리스트 처럼 추가
mydata
mydata$gender <- NULL   #gender column삭제
mydata
mydata$add <- NA
mydata <- mydata[,1:4]  #이런식으로도 삭제가능 or mydata[,-5]
mydata$midterm[30] <- 70   #구성요소 하나만 바꾸기
mydata   #total은 안바뀜

#추가할때 cbind도 사용가능
mydata <- cbind(mydata,mydata$total/2)  #이름은 안정해짐
mydata
names(mydata)[5] <- 'average'  #이름 정하기

#subset이용한 필터링:행렬 형식은 mydata[mydata$midterm<=15,]처럼 김, but 사용도가 더 많음
subset(mydata,midterm<=15)  #df형식으로 출력
#단 subset은 df안에있는 것만 사용가능하여 사용도가 적음

#subset사용하여 중간고사 30~60사이인 아이들
subset(mydata,midterm>30&midterm<60)

#데이터 프레임 함치기-merge()함수 사용
mydata2 <- data.frame(id=sample(1:30,5),result=c(rep('pass',3),rep('fail',2)))
mydata2                    
merge(mydata,mydata2,  #mydata=x, mydata2=y
      by.x='student_id',  #mydata에서는 student_id가 기준이 되는 아이이다
      by.y='id')   #mydata2의 id를 mydata1의 student_id에 합친다
#result가 업데이트 된다, 5개만 출력
#30개자료 다 보고 싶으면 ?merge하여 내부보기
merge(mydata,mydata2,by.x='student_id',by.y='id',all.x=TRUE)
#all.x=TRUE를 해줘 x인 mydata가 다보임, NA채움

#펭귄 데이터셋
install.packages('palmerpenguins')  #or tools에서 install package
library(palmerpenguins)
penguins  #자료임, bill=부리, flipper=날개
penguins <- data.frame(penguins)
options(max.print = 3000)
unique(penguins$species)  #중복을 없애고 유일한 값들만 보고 싶을떄->3종이 있다

#아델리 펭귄 수컷 평균 몸무게는?
mean(penguins[penguins$species=='Adelie'&penguins$sex=='male',6],na.rm = TRUE)
mean(subset(penguins,species=='Adelie'&sex=='male')$body_mass_g)  #subset은 NA를 무시
aggregate(body_mass_g~(species=='Adelie')+(sex=='male'),penguins,mean,na.rm=TRUE)#이렇게도 가능

#파이프 연산자 | + > = |>
subset(penguins,
       species=='Adelie'&
       sex=='male')$body_mass_g |> mean() #집어넣어라 라는 의미, 괄호 필요

#order함수를 이용한 정렬
order(c(1,30,20))  #크기 순서는 1:1->3:20->2:30이다
order(penguins$body_mass_g)  #몇번째 크기인지 보여줌, 315번 애가 제일 가볍다
penguins[order(penguins$body_mass_g),]  #가벼운 애부터 무거운 애까지, NA는 맨끝으로
options(max.print = 3000)

#aggregate()->정보를 요약
#aggregate(formula,data,function)
#formula에 들어갈수있는것들: 수치변수(ex길이)~카테고리컬변수(남녀), +와.연산자사용가능
aggregate(body_mass_g~species,  #몸무게를 보고싶다~종에 따른
          penguins,mean)   #data=penguins, 함수는 mean

#종별 성별 몸무게 평균은?
aggregate(body_mass_g~species+sex,penguins,mean) #+연산자 사용하여 둘다 보기
boxplot(body_mass_g~species+sex,penguins)

#종별 성별 몸무게 평균, 부리길이 평균은?
aggregate(cbind(body_mass_g,bill_length_mm)~species+sex,penguins,mean) #더하기 말고 cbind사용

#종별 성별 모든 수치 데이터 평균은?
aggregate(.~species+sex,penguins,mean)  # .=species와 sex를 제외한 나머지, island도 포함
aggregate(.~species+sex,penguins,mean)[-3] #island만 빼기
aggregate(cbind(bill_length_mm,bill_depth_mm,flipper_length_mm,body_mass_g)~species+sex,penguins,mean) #이것도 가능

