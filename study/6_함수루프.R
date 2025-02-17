# {}를 사용하여 블록을 구분
# ;=구문들을 구분해 줄 수 있음(줄 바꿈과 비슷)
a <- 3
b <- 2
a;b   #둘다 출력(다른 줄이므로)
a <- 2;b <- 3  #가능

#함수:function()함수를 사용
#함수의 입력값(argument)과 내용(body)를 정의해줘야 함
function_name <- function(input){
  result <- input+1
  return(result)
}

function_name(3)  #실행

#함수 역시 객체(object)
class(function_name)
formals(function_name)  #입력값이 무엇인지
body(function_name)    #함수 내용

#함수의 내용 출력(printing)
function_name  #입력값과 내용 전부 출력
abline  #만들어진 함수들도 내용 확인 가능
sum   #너무 fundamental한 애들이어서 안보여줌->.primitive라 적혀있으면 c언어로 짜여진 애들임

#input값이 없는 경우
function_name()  #오류
function_name2 <- function(input=100){  # <- 대신 =사용, 기본 설정값 넣어둠
  result <- input+1
  return(result)
}
function_name2()  #101이 입력값 없이 출력
function_name2(1)  #입력값이 있으면 1+1

#결과값 반환 함수=return()
## R의 함수는 자동으로 마지막 구문을 결과값으로 반환
function_name3 <- function(input){
  result <- input+1
  result           # ''로 print없이 print가능
}
function_name3(3)  #result를 출력

#R에서는 함수 마지막 줄에는 return()을 무조건 생략
#early return의 경우에만 사용을 권장
abs <- function(a){
  if(a>0){
    return(a)   #early return
  }
  -1*a   #return 생략
}
#만약 입력값이 0보다 크면 그대로 출력하고 return이기 때문에 끝남
#0보다 작으면 if문 무시하고 맨 밑줄의 -1*a를 실행하여 출력
abs(1)
abs(-1)
abs(0)

#함수이름 정할 때 유의사항-snake case
#이름은 무조건 영어,소문자,숫자,밑줄_ 만을 사용
# .사용X, 
#함수이름은 동사를 먼저사용, 변수이름은 명사를 사용

# add_two()->good
#AddTwo()->bad  number_adder()->bad

#나만의 함수작성->벡터를 입력하여 벡터의 최대값 위치를 찾아내는 함수
find_maxvec <- function(x){
  a <- which.max(x)
  a
}
set.seed(1)
my_vec <- sample(1:100,30)
find_maxvec(my_vec)



#조건문
# if -else
x <- 3
if (x>5) {    #여기에 x>5대신 TRUE를 사용하면 항상 larger구문이 뜸, FALSE면 less구문만 뜸
  print('x is larger than 5')
}else if(x==5){                          #else if==elif
  print('x is 5')
}else{                                   #else
  print('x is less than 5')
}

#ifelse()함수-ifelse(condition,참일때 출력값,거짓일때출력값)
ifelse(x>5, '5보다크다', '5보다 작다')

#조건이 3개이상인 경우-switch()
#switch(a,a가1의조건일경우,a가2의조걸일겨우,a가3의조건일경우,....)
#cat()=paste()와비슷, 파이썬의 f''와 비슷
x <- 1; y <- 2; input <- 'good'
switch(
  input,
  'good'=cat('score=',x+y),   ##이때 ''없어도 됨
  'normal'=cat('score=',2*x),
  'bad'=cat('score=',-y)
)     #input은 good이므로 cat('score=',x+y)가 실행

#이 함수의 의미는 무엇일까
centre <- function(vec,type){
  switch(type,
         mean=mean(vec),
         median=median(vec))
}
centre(my_vec,'mean')  #벡터의 평균값
centre(my_vec,'median')  #벡터의 중간값
#추가적으로 switch아에 더 많은 조건들 넣을 수 있어서 유용

#반복되는 작업-for문, while&break문
#for
x <- 1:3
for (i in x){   #x안의 것을 순서대로 i에 대입
  i=i*2
  print(paste('here is',i))
}

for (i in 1:30){  #이렇게도 가능
  print(i)
}

#while
i <- 1
while (i<10) {
  i <- i+1
  print(i)
}

#break
i <- 1
while (TRUE) {   #TRUE일때 항상 반복실행
  i <- i+1
  if (i>10) break   #while문을 빠져나옴, break는{}필요없음
  print(i)
  # if (i>10) break  여기에도 넣을 수 있고 출력값은 달라짐
}


# apply()함수 완벽 정복
# 행렬과 배열을 사용한 루프
# apply(object,direction,function) 
# object=matrix or array
# direction:함수적용방향= 1:행별, 2:열별

a <- matrix(1:12,ncol=4)
a
apply(a,1,max) #각 행별 최대값
for (i in 1:3) {
  print(max(a[i,]))
}   #이것과 같은 의미

apply(a,2,max) #각 열별 최대값

#사용자 함수를 사용한 apply()
my_f <- function(vec){
  max(vec)^2+3
}
apply(a,1,my_f) #함수를 넣어서 사용가능

# 3차원 배열:array에서의 apply
arr <- array(1:24,dim=c(3,4,2))
arr
apply(arr,1,max) #모든 레이어의 행이 즐어감->10,11,12는 생략될수밨에
apply(arr,2,max)

apply(arr,3,max) #각 레이어의 최대값

#함수에는 대응하는 환경이 따로 존재
y <- 2  #global의 값
my_f <- function(x){
  y <- 1   #함수안의 y와 밖의y는 다름
  result <- x+y
  result
}
my_f(100)
y  #y는 global값인  2로 나옴:my_f의 y와 global의y는 다르다

# <<-연산자
g <- 2
my_f2 <- function(x){
  g <<- 1   #함수안이라도 global값을 바꿔줌
  result <- g+x
  result
}
my_f2(100)
g  #함수 실행해야 <<-이 적용되어 바뀜
