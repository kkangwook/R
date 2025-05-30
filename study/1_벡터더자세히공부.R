#빈 벡터 선언
x <- vector(length=3) #실행 시 F F F출력
#빈벡터에 채우기
x[2] <- 5   #출력시 x=c(0,5,0)됨

c(1:5)*2-1 #홀수만 출력

# :연산자는 다른 사칙 연산 보다 우위
1:3-2   #1:3을 먼저
#하지만 괄호가 더 우선시 됨
1:(3-2)   # 1
1:(3*2)   # 123456

#seq함수: seq(시작,끝,옵션) 옵션=by or length
seq(2,10,by=2)    #2 4 6 8 10
seq(2,10,length=3)   #2 6 10(3개뽑기) 이때 2와 10은 무조건 포함
l <- seq(2,100,by=0.3)
length(l)   #length는 길이함수(len()과비슷)
z <- seq(50,500,length=327)
l+z   #길이를 맞춰주었기에 연산 가능

#rep함수: rep(반복대상,반복횟수)
rep(8,4)   #8888
rep(c(1,2,4),2)   #124124
rep(c(1,2,4),each=2)    #112244:each는 각원소를 반복

#sample()함수
#sample(모집단,뽑을 표본개수,replace=T(중복가능),prob=c())
#여기서 prob=c()안에 각 요소들의 확률 지정 가능
sample(c(1:4),10,replace=T,prob=c(0.5,0,0,0.5))  # 1과 4만 나옴

#indexing-원하는 벡터 원소만을 선택 x[]
x <- 1:10*2
x[3:6]   #x의 3456번째 원소만 가져옴
y <- 3:6
x[y]   #이것도 가능
x[c(3,6,7,8)]  #가능
x[c(10,6,3,8,5)]  #꼭 작은것부터 안해도 됨

#indexing 추가설명
x[c(2,2,3,4)]   #요소 중복가능
x[-1]    #1번째 요소빼고 나머지 전부 가져오기
x[-c(1,2,3,4)]   #가능:1,2,3,4번째 제외 나머지

#all()함수 any()함수
all(x<10) #x의 원소가 전부 10미만이니?->FALSE
any(x<10) #x의 원소중 10미만이 하나라도 있니?->TRUE
x<10     #각 요소별로 T,F판단

#이때 T와 F는 각 값을 가지고 있다
TRUE==1
FALSE==0
#그러므로 all은 1*1*1*1*0*0*...*0!=1이므로 FALSE가 나옴
#반대로 any는 1+1+1+1+0+0+..+0!=0이므로 TRUE가 나옴(0이 나와야 FALSE)

#벡터 필터링 vector[condition]
x[x<10]  #x의 요소들 중 10보다 작은 애들만 가져옴

#[]안에 ==(=두개)or!=
x[x==4]   #4와 같은 원소들만 반환해라
x[x!=4]   #4만 빼고

# %/%(몫), %%(나머지)
x[x%/%4==2]  #요소들 중 4로 나웠을때 몫이 2인것만 가져옴
x[x%%4==0]   #요소들 중 4로 나웠을 때 나머지가 0인것만

#심화
x <- 1:10*2
y <- 101:110
x==10    #FFFFTFFFFF 5번째가 T
y[x==10]   #y의 5번째인 105가 출력
y[x!=10]   #105제외 나머지

x%%4==2  #TFTFTFTFTF
y[x%%4==2] #1,3,5,7,9번째 요소만

#1에서 5000중 26으로 나누어 떨어지는 애들의 갯수는?
y <- 1:5000
sum(y%%26==0)  #T=1, F=0이므로 다 더하면됨
length(y[y%%26==0])  #len함수 사용해서

# &(and)와 &&
a <- c(TRUE,TRUE,FALSE)
b <- c(TRUE,FALSE,FALSE)
a&b  #각 요서 비교해 둘다 TRUE면 T, 둘 중 하나라도T가 아니면 F
a&&b  #첫번째 원소만 비교

# |(or) 와 ||
a|b   #둘중 하나만 T면 T, 둘다 F여야 F
a||b  #첫번째 원소만 비교

#조건문 혼합
x[x==4|x>10]  #4거나 10보다 큰것 둘다

#x중 2,4,6,14,16,20만 뽑기
x[x<8 | x>13 & x!=18]  #이런식으로도 가능-8보다 작고 13보다 크면서 18은 아님 연산 왼쪽->오른쪽
x[x<8|x>13][-6]    #인덱싱의 인덱싱도 가능

x[x==4||x>15]


#필터링을 이용한 벡터 변경
x <- 1:10*2
x[x>=10] <- 30  #10 이상의 값들은 전부 30이됨

#which() 위치 탐색 함수
x <- 1:10*2
which(x<7)  #x가 7보다 작은 요소들의 위치는?
#y <- 1:5000에서 1025로 나누어서 47이 남는 세번째 숫자 위치는?
y <- 1:5000
which(y%%1025==47)[3]  #답
y[y%%1025==47][3]  # 그 값은?

# NA:missing data=빈칸을 의미
a <- c(20,NA,13,24,309)
mean(a)    #NA땜에 NA가 나옴
mean(a,na.rm=TRUE)  #na.rm은 na를 remove하라는 것을 의미

#NULL=아예 칸 자체가 존재하지 않음을 의미
c(1,NULL)  #출력시 1만 뜸
c(1,NA)    #NA도 같이 뜸
b <-c(20,NULL,13,24,309)
mean(b)        #가능

#match(a,b)함수 a안에 b가 있나?
a <- c(1,2,3,4,5)
b <- c(2,5,7,8,9)
match(a,b)  #a의 2,5가 b와 일치한다 
match(a,b,nomatch = 0)  #NA대신에 0

#match.arg(a,b) : 문자형만 가능 a의 것 중 b에 있는 것들 뽑아냄
match.arg('b',c('b','d','f','a'))
match.arg(c('b','a','d','k'),c('b','d','f','a'),several.ok = T) #앞의 꺼길이가 2이상이면

#벡터에 이름 붙여주기-names함수->원소에 이름을 붙임
my_vector <- c(1,20,300)
names(my_vector)    #NULL이 뜸:아직 안 정해줘서
names(my_vector) <- c('first','second','third')
#my_vector출력시 이름과 원소가 같이 출력
my_vector['second']   #이름으로 인덱싱 가능

#벡터 묶기 cbind():column으로묶기, rbind():row로 묶기
cbind(1:4,12:15) #벡터들이 열이됨(세로)
rbind(1:4,12:15) #벡터들이 행이됨(가로)
