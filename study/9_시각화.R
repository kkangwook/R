#시각화
#R plot
x <- 1:10
y <- x^2
plot(x,y) #흰 도화지에 x축에x, y축에 y로 하여 점찍음,둘의 길이 같아야함
points(4,20,col='blue')  #plot에 4,20위치에 파란색 점을 찍음
points(4,60,col='red')  #하나씩 add가 됨
points(1:10,1:10,col='red') #여러개 동시에 가능
points(1:10,5:15,type='l')  #라인으로
abline(a=20,b=-2,lty='dashed') #선 집어넣기->a는 y절편, b=기울기, line_type->점선
abline(h=20) #horizontal line
abline(v=6)  #vertical line


plot(0,0)  #새로운 plot이므로 새로운 도화지, 0,0에 점
plot(0,0,type='n') #null->빈도화지
plot(0,0,type='n',
     xlim=c(0,10))  # x보여줄 범위
plot(0,0,type='n',xlim=c(0,10),
     ylim=c(0,20))  #y범위
plot(0,0,type='n',xlim=c(0,10),ylim=c(0,20),
     main='my first plot')  #제목 보여줌
plot(0,0,type='n',xlim=c(0,10),ylim=c(0,20),main='펭귄종별 부리길이vs깊이',
     xlab='부리길이(단위:mm)',ylab='부리깊이(단위:mm)')  #lab=label->x축 y축 이름설정

library(palmerpenguins)
penguins$bill_length_mm|>range(na.rm=TRUE) #값의 범위의 최소와 최대
penguins$bill_depth_mm|>range(na.rm=TRUE)
plot(0,0,
     type='n',
     xlim=c(30,60),
     ylim=c(10,25),
     main='펭귄종별 부리길이vs깊이',
     xlab='부리길이(단위:mm)',
     ylab='부리깊이(단위:mm)',
     cex.main=1.5,   #main의 크기(기본 cex값은 1)
     cex.lab=1.5,    #축 제목 크기
     cex.axis=1.2)   #축 숫자들 크기

points(penguins$bill_length_mm,
       penguins$bill_depth_mm,
       col=penguins$species)  #종별 다른색

points(penguins$bill_length_mm,
       penguins$bill_depth_mm,
       col=c('red','blue','green')[penguins$species]) #내가 색 지정하고 싶을때-첫번째 종이red->두번째종blue->세번째종green
levels(penguins$species) #위의 색 순서대로
       
with(penguins,
     points(bill_length_mm,
            bill_depth_mm,
            col=c('red','blue','green')[species],
            pch=c(16:18)[species],  #점의 형태 각각 16 17 18종류로 할당
            cex=1.2))  #점의 크기

#범례=legend()함수
legend(33,15,legend=c('Adelie','Chinstrap','Gentoo'),
       col=c('red','blue','green'),
       pch=16:18,   #plotting character
       cex=0.5)

#text()->annotation함수
text(45,23,'test text') 

mean_points <- aggregate(cbind(bill_length_mm,bill_depth_mm)~species,
                          penguins,mean)
names(mean_points) <- c('species','x','y') #열 이름 바꾸기
mean_points
text(mean_points[1,2],
     mean_points[1,3],'Adelie average')
text(mean_points[1,2:3],'Adelie') #이렇게도 가능
text(mean_points[,2:3],'X')  #전부 X
text(mean_points[,2:3],c('A','C','G')) #이렇게도 가능
