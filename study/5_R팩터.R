#팩터=factor()함수사용: 범주형(categorical)변수를 다루는 도구
#범주형변수=변수가 가질 수 있는 값이 한정된 변수-ex)계절
x <- c(1,13,5,2,1)
x_factor <- factor(x)
x_factor   #첫째줄이 진짜 값, levels에는 유니크 한 값들만 보여줌
#즉 팩터는 벡터이면서 정보(levels)가 좀더 들어간 개체

#팩터를 구성하는 요소-벡터+레벨
class(x_factor)
unclass(x_factor)  #구조를 보고 싶을때 사용
#해석하면-levels의 정보(1,2,5,13)를 가지고 위치정보(1,4,3,2,1)를 넣은 꼴

#팩터 선언 방법:factor()함수 사용->factor(x,level)
x_factor2 <- factor(x,levels=c(1,2,5,7,13))
x_factor2  #앞으로 x에 level값들이 들어 올 수 있다
x_factor2 <- factor(x,levels=c(1,2,3)) #포함 안된 애들 NA값

#예시-계절변수-봄,여름 만 들어있는 계절 factor
x <- c('spring','summer')
season <- factor(x,levels=c('spring','summer','autumn','winter'))
season
season[1] <- 'winter'
season  #가능
season[1] <- 'may'  #불가-levels안에 없으므로
season   #NA로 표현
season[3] <- 'autumn'  #추가
season[3] <- NULL  #불가
season <- season[-3]  #이런식으로 제거

#paste함수->붙여줌
paste('school',1:4)  #s1,s2,s3,s4가 됨
a <- 3
paste('a는',a,'입니다')

#levels변환
levels(x_factor) <- paste('school',1:4)
x_factor  #레벨을 조정하면 안에 있는 내용들도 같이 변환

#순위변수-나쁘다,중간,좋다의 순서가 문화적으로 존재->레벨에 설정가능:ordered=TRUE
con_vector <- c('bad','good','soso','good')
x_factor3 <- factor(con_vector,levels=c('bad','soso','good'),ordered = TRUE)
x_factor3  #bad<soso<good :levels설정할때 작은거 순서대로 한 후 ordered=TRUE

#팩터레벨에 따른 함수 적용-tapply()함수 사용
#tapply(대상벡터,나누는기준,적용함수)
set.seed(1)
age <- sample(20:60,6)
gender <- sample(c('남자','여자'),6,replace=TRUE) #replace=TRUE->중복해서 뽑을 수 있게
tapply(age,gender,mean) #age정보를 보고싶다,성별기준으로,age의평균값을
mean(age[-1])

#tapply()-aggregate()과 비슷
library(palmerpenguins)
View(penguins) #엑셀처럼 보게 해줌
penguins$species|>unique()  #팩터로 나오는구나

#tapply로 펭귄 종별 부리길이 평균 보기
tapply(penguins$bill_length_mm,penguins$species,mean,na.rm=TRUE)

#with()사용하여 더 간편히
#with(사용할data,무엇을 사용할지)->penguins$생략가능
with(penguins,
     tapply(bill_length_mm,
            species,mean,
            na.rm=TRUE))

penguins[penguins$species=='Adelie',]
penguins[penguins$species=='Adelie',]$island|>unique() #levels는 3개고 adelie는 3곳 전부에서 살고있다

#펭귄의 종 별, 사는곳 별 부리길이 평균
with(penguins,
     tapply(bill_length_mm,
            list(species,island),mean,
            na.rm=TRUE))  #NA가 뜸->다른 종들은 한곳에서만 삼

#tapply()와 aggregate()과의 차이
aggregate(bill_length_mm~species+island,penguins,mean,na.rm=TRUE)
#차이는 tapply는 NA포함된 모든 경우의 수 보여줌 but aggregate은 NA생략하고 있는것들만

#split()함수 사용하여 데이터 쪼개기
#split(대상,나누는기준)
x_factor
split(1:5,x_factor) #x_factor의 1~5까지 요소들을 levels로 나눠 분류->리스트화
result <- split(1:5,x_factor)
result$`school 2`   #리스트이므로 뽑아낼 수 있음
result[[2]]

#by()함수-by(data,데이터에서 보고자하는 column,함수에 data넣음)
#tapply()의 첫 입력값은 항상 벡터->데이터 한종류밖에 못봄
#aggregate의 경우 cbind(부리길이,부리높이)의 행렬로 넣어서 여러 종류 한꺼번에 볼 수 있음
#by()는 행렬이나 데이터 프레임도 가능->여러 종류 데이터 볼 수 있음
by(penguins,penguins$species,
   function(df) {mean(df$bill_depth_mm,na.rm=TRUE)})

by(penguins,penguins$species,
   function(df) {var(df$bill_depth_mm,df$bill_length_mm,na.rm=TRUE)}) #분산구하기
#무조건 함수는 function으로
by(penguins,penguins$species,mean)  #불가


