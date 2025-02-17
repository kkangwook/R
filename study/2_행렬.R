#행렬=벡터들을 모아놓은것, 꼭 같은 길이의 벡터들이어야함

#dim():크기를 잴 수 있음
a <- cbind(1:4,12:15)
dim(a)   # 4 2 -> row4, column2를 의미

#matrix()함수
#헹과 열 중 하나만 입력해도 만들어줌
y <- matrix(1:4,nrow=2)  #행2개->넣어준 요소 자동 고려해 열도 계산하여 생성
y <- matrix(1:6,nrow=3)  #행3개->자동으로 열2개
y <- matrix(1:6,ncol=3)  #3열->자동으로 행2개

# matrix()에서 byrow옵션
matrix(1:6,nrow=2)     #byrow=FALSE가 디폴트->열순서로 집어넣음
matrix(1:6,nrow=2,byrow=TRUE)    #행 순서로 집어넣게됨

#indexing
x <- matrix(1:10*2,nrow=5)
x[2,2]    #2행 2열을 의미
x[,2]     #2번째 열의 모든 행
x[2,]     #2번째 행의 모든 열
x[c(2,3,5),2] #2,3,5번째 행의 2번째 열

#필터링-> T,F사용, 조건문 사용
x[c(TRUE,TRUE,FALSE,FALSE,TRUE),1] #행의1,2,5만+1열값들
x[,2]>15  #F F T T T
x[x[,2]>15,1]  #FFTTT이므로 3,4,5행 중 (1열만)
#quiz->1열 5보다 크거나 같은 조건에 해당하는 2열 원소 가져오기
x[x[,1]>=5,2]

#심화-사진도 행렬이다(흑백사진)
install.packages('raster')  #지리 및 공간 데이터 분석을 위해 사용되는 패키지
library(raster)
runif(10) #random uniform:0에서 1사이 숫자 랜덤하게 10개뽑기

runif(10,min=0,max=2)  #이런식으로 숫자범위설정가능
set.seed(1)  #runif랑 같이 실행/숫자를 고정-runif는 실행할때마다 랜덤이므로 

set.seed(2)  #숫자마다 다르게 고정
runif(10,min=0,max=2)
set.seed(1)          #다시 위에꺼 나옴

z <- matrix(runif(9,min=0,max=1),nrow=3)
as.raster(z)   #숫자를 헥스코드로 변경:숫자를 플롯에서 색상으로 표시될 수 있게끔 해줌, 각 변형된 요소들은 구글에 검색시 색깔임,헥스코드
plot(as.raster(z))  #헥스코드를 색으로 변형
plot(as.raster(z),interpolate=FALSE)  #정해준 9개로만 표현되게끔
x <- matrix(runif(10000,min=0,max=1),nrow=100)  #0에서 1사이여야함
plot(as.raster(x),interpolate=FALSE)

#mat.rds파일로 고양이 그리기
data_url <- 'https://raw.githubusercontent.com/issactoast/R-playbook/main/lecturenote/data/mat.rds'
download.file(data_url,'mat.rds') #url을 'mat.rds'라는 이름으로 저장시켜주는 함수, 워킹디렉토리에 저장
img_mat <- readRDS('mat.rds')  #rds확장자 읽을 수 있게끔
#file.remove('mat.rds')->파일을 제거
img_mat
dim(img_mat)   #행렬의 크기
head(img_mat[1:3,1:3])  #d.f, 행렬, 벡터의 처음 몇줄을 보여줘서 어떤 내용인지 간략히 보여줌
min(img_mat)  #이 행렬 요소의 최솟값=0
max(img_mat)  #쵀대는 255
a <- img_mat/255   #0에서1이어야하므로 255로 나눔
plot(as.raster(a))  #고양이
plot(as.raster(a[1:44,]))  #반절만 나옴
plot(as.raster(a[,1:25]))
#색반전:0은1로, 1은 0으로
plot(as.raster(1-a))

#행렬 클래스
x <- matrix(1:10,nrow=2)
class(x)  #x는 행렬 혹은 array
attributes(x)  #속성->dim이 2행 5열이겠구나

#행렬 뒤집기: t()함수-transpose
x <- matrix(1:10*2,ncol=2)
t(x)  #행과 열을 바꿈
plot(as.raster(t(a)))  #고양이 돌아감

#행렬의 곱셈 %*%기호사용, 앞의 열개수와 뒤의 행개수 같아야함
x <- matrix(1:10*2,ncol=2)
y <- matrix(1:4,nrow=2)
dim(x)
dim(y)        #x의 열2개=y의행 2개와 같아서 곱셈 가능
x%*%y     #가능 ->(5,2)%*%(2,5)=(5,5)가 됨
y%*%x     #불가능

#원소별 곱셈 그냥 *기호 사용 !!크기 같아야함
y <- matrix(1:4,nrow=2)
z <- matrix(10:13,ncol=2)
y*z  # 1,1은 1,1과 곱, 1,2는 1,2와 곱, ...m,n은 m,n과 곱
y+z  #얘도 동일
y/z
y-z

#역행렬 구하기-solve()함수, 정사각형 형태만 가능
solve(y)
y%*%solve(y)  #역행렬이란 곱했을때 E가 나와야함
no_inverse <- matrix(c(1,2,1,2),nrow=2)
solve(no_inverse)  #singular이다=역행렬이 없는 행렬이다

#행렬 연산에서 recycling ex) c(1,2)+c(1,2,3,4)의 경우 배수여서 자동으로 길이 맞춰줌
y <- matrix(1:4,nrow=2)
y*c(1,2)  #벡터 곱하기 가능, 1행1열->2행1열->3행1열...순으로
y*matrix(c(1,2),ncol=2) #하지만 행렬과 행렬은 적용 안되서 에러

#차원 축소기능 끄기
y <- matrix(1:4,nrow=2)
y[1,]  #난 행렬로 보고싶은데 벡터로 나옴
dim(y[1,])  #null
y[1,,drop=FALSE]  #차원 축소는 꺼라는 명령->행렬로 나옴
dim(y[1,,drop=FALSE])  #1행 2열이다

#행렬 이름붙이기:colnames(), rownames()함수
y <- matrix(1:4,nrow=2)
colnames(y)  #NULL
colnames(y) <- c('col1','col2')
y
colnames(y)
rownames(y) <- c('row1','row2')
y
y[,'col2']   #이름 붙인 열중 col2열만 indexing
y[,'col2',drop=FALSE]

#배열 array()-고차원 행렬-행렬 붙여놓기
mat1 <- matrix(1:6,nrow=2)
mat2 <- matrix(7:12,nrow=2)
make_array <- array(data=c(mat1,mat2),dim=c(2,3,2)) #2행 3열을 2개 붙임-2개의 레이어
array(data=c(mat1,mat2),dim=c(2,3,3))  #mat1-mat2-mat1이 다시옴
dim(make_array)  #2행 3열이 2개
array(data=c(mat1,mat2),dim=c(1,1,3))  #1행 1열만 가져오고 레이어 mat1-mat2-mat1

mat1 <- matrix(1:6,nrow=3)
mat2 <- matrix(7:12,nrow=2)
array(data=c(mat1,mat2),dim=c(2,3,2))  #행렬의 크기가 달라도 알아서 맞춰 합쳐줌

#array-필터링 가능
make_array[,,1] #모든 행,열 but 첫번째 레이어만
make_array[,,2]
#첫번째 array의 1-2행과 1-2열만 가져오기
make_array[,c(1,2),1]
make_array[,-3,1] #3열만 뺴고 1array만

#배열에서 transpose-aperm()함수 사용
aperm(make_array,perm=c(2,1,3))  #c(2,1,3의 의미)
#make_array의 dim=c(a,b,c)에서 a는 행렬의 가로행, b는 행렬의 세로열
#c는 layer이다
#perm=c(2,1,3)의 경우 a=1, b=2, c=3->열을 행으로, 행을 열로, 레이어는 그대로

# make_array로 2by2 행렬을 3개 쌓아놓은 배열
aperm(make_array,perm=c(1,3,2))   #결국에는 행6개, 열2개
#2(행)행, 2(레이어)열,3(열)레이어

img_url <- 'https://github.com/statisticsplaybook/timeseries-playbook/blob/main/image/deeplearning-playbook.png'
download.file(img_url,'jelly.png',mode='wb')
install.packages('png')
library(png)
jelly <- readPNG('jelly.png')
dim(jelly)  #540 960 3->540행 960열이 3개
#1레이어는 빨강색 (0-255)
#2레이어는 녹색   (0-255)
#3레이어는 파란색  (0-255)
#원래라면 jelly/255해야되지만 이미 0-1의 범위이므로 할 필요X
plot(as.raster(jelly))
jelly[1,1,]  #1,1칸에서 각 색의 혼합


