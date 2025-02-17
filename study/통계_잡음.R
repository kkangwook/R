#잡음-noise
#회귀 직선 y=ax+b에 +잡음(규칙이 없는)이 생겨 직선을 관찰하지 못하는것

#잡음이 없을때
x <- 1:20
y <- function(x){
  x*3+20
}
plot(x,y(x),xlim=c(0,20),ylim=c(0,90),
     type='l',  #점이 아닌 라인으로
     lty=2)   #라인의 타입
points(4,y(4),pch=19)
points(10,y(10),pch=19)

#잡음이 일정한 숫자인 경우->잡음은 아니다
noise_y <- function(x){
  x*3+20+4   #잡음이 4
}
points(5:15,noise_y(5:15),pch=18)  #전부 직선에 4만큼 뜬 직선

#잡음이 어떤 규칙을 가진 경우->잡음은 아니다
noise_y2 <- function(x){
  if(x%%2==0){
    return(x*3+20+4)
  }else{
    return(x*3+20-4)
  }
}
x2 <- 5:15
y2 <- lapply(x2,noise_y2)
points(x2,y2,col='red')

#따라서 잡음은 무규칙성이어야 한다->시간, runif등
#시간으로 무규칙성 모델링
Sys.time()   #현재 시간
options(digits.secs=6)   #초의 소숫점 6까지 알려줌
Sys.time()  #끝의 것만 가져오면 random하게 가져올 수 있음

#시간으로 0~0.9999숫자 가져오기
random_0to1 <- function(){
  options(digits.secs = 6)
  current_time <- as.character(Sys.time())
  n <- nchar(current_time)
  time_decimal <- substr(current_time,n-3,n)
  as.integer(time_decimal)/10000
}
random_0to1()
#이와 유사한 함수=runif()
runif(1)

#runif를 통한 잡음 직선 관찰->관찰할때마다 일정하지 않음
noise <- function(x){
  true_vec <- x*3+20
  noise_vec <- runif(length(x))*10
  true_vec+noise_vec
}
x <- 1:20
points(x,noise(x),col='blue')  #규칙이 없음->이것이 잡음

#runif 한계:결국 runif함수도 범위가 정해져 있음
#->>정규분포를 사용해서 잡음을 모델링하게 됨


#균일분포의 시각화
#runif의 0~1 사이의 숫자가 나올 가능서은 모두 같다
set.seed(1)
x <- runif(1000)
hist(x,breaks=seq(0,1,length=100000))  #y축은 가능성=1, 넓이=확률
#만약 runif*2로 하면 높이는 0.5로 하여 0~2사이에 나올 확률=0.5*2(x축)=1


#정규분포와 잡음
#issac의 키=178cm but 측정할때마다 여러 요인에 이해 오차가 존재
# ㄴ하지만 오차가 존재하더라도 대부분 178이 나옴
# 또한 오차도 대부분 0에 가까울 것임

#오차를 표현한 함수 rnorm():random normal distribution(정규분포를 따르는 확률변수)
#특징-1-종모양 2-0을기준으로 대칭 3-이론상으로 -무한~무한 값이 나오도록 설계
rnorm(1)  # -2~2를 잘 벗어나질 않음, 곱하기를 통해 범위 확장가능
hist(rnorm(1000),breaks=seq(-4,4,length=100))

x <- 1:20
y <- function(x){
  true_vec <- x*3+20
  noise_vec <- rnorm(20)*5  #곱해서 흔들림의 존재를 더 키울 수 있음
  true_vec+noise_vec
}
plot(x,y(x),xlim=c(0,20),ylim=c(0,90))
abline(20,3)
 
