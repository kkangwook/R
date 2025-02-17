#벡터=구성원들이 모두 같은 타입이어야함
c(1,'test')   #1은 문자형이됨
c(1,TRUE)     #logical이 숫자형이 됨
c(TRUE,FALSE)  #logical만 있어서 logical이 됨

#각기 다른 타입의 구성원을 가진 객체=list
#list()함수 사용
mylist <- list(name='kkangwook',id=20161434,order=c(1,2))
mylist  # $은 태그라고 부르며 각 구성원의 태그와 내용을 짝지어줌
#리스트도 벡터의 한 종류, 벡터는 atomic vector=더 이상 쪼갤 수 없다
#리스트=recursive vector=작은 구성원들로 쪼개짐:접근이 가능하다
#->mylist에서 $order안에 또 c(1,2라는) 벡터가 들어갈 수 있다는 것을 의미
mylist$order   #벡터를 뽑아냄
mylist$order[1]   #이것도 가능

#$태그없이 사용도 가능-but 태그 쓰는것이 좋긴 함
mylist2 <- list('kkangwook',20161434,c(1,2))
mylist2    #태그이름없이 숫자만으로 [[1]], [[2]], [[3]]으로 표시

#리스트 인덱싱-$사용하거나 [[]]or[]
mylist$name
mode(mylist$name)  #character
mylist['name']   #리스트로 출력-리스트를 나타냄
mode(mylist['name'])  #list
mylist[['name']]    #벡터로 출력-리스트 안의 벡터만을 나타냄
mode(mylist[['name']])   #character

#숫자로 인덱싱
mylist2[1]  #list
mylist2[1:2]
mylist[c(1,3,1,3,2,1)]  #!!!!!!가능
mylist2[[1]]   #list안의vector
mylist2[[3]]
mylist2[[3]][2]  #인덱싱의 인덱싱
mylist$order[2]  #같음
mylist2[[1:2]]  #불가
mylist2$[1]    #불가

#구성원소 추가/삭제/변경-$사용
mylist$id <- 20161435
mylist    #id값이 변경
mylist[['id']] <- 20161435  #이것도 가능

mylist$birth <- 19970528
mylist   # 추가

mylist$birth <- NULL
mylist   #NULL을 사용해서 삭제

mylist[4:6] <- list('a','b','c')
mylist   #한꺼번에 추가
mylist[4:6] <- NULL
mylist   #한꺼번에 제거
mylist[4:6] <- list(birth=19970528,phone_number=3179,extra='hi')
mylist  #태그 안됨 4,5,6이 태그가 됨
mylist[4:6] <- NULL

mylist[c('birth','phone_number','extra')] <- list(19970528,3179,'hi')
mylist   #태그 넣는 방법

#헷갈리는 것
mylist[[3]][2] #가능-벡터의 인덱싱
mylist[3][2]   #불가능-mylist[3]이 리스트이므로
mylist[3][[1]][2]  #가능-order리스트 불러와서 벡터로 만들고 인덱싱

#재귀리스트-리스트안에 리스트
mylist$new <- list('hello',c(1,3,2))
mylist #new태그안에 2개의 리스트, new[[1]]과 new[[2]]
# hello만 꺼내오고 싶을때
mylist$new[[1]]  #new list안에 첫번째 리스트의 벡터
mylist$new[1]  #new list안에 첫번째 리스트
#new list안에 2번째 리스트의 3번째 원소 꺼내올때
mylist$new[[2]][3]

#unlist()함수-리스트를 리스트가 아닌거로 바꿔줌
unlist(mylist)  #벡터가 나옴
#문법-unlist(list,recursive=TRUE,use.names=TRUE)
#->recursive=TRUE때문에 new list가 new1과2,3,4로 나눠지게됨->끝까지 쪼갬
unlist(mylist,recursive=FALSE) #new1과 new2(c(1,3,2))로만 나눠짐->벡터가 아닌 리스트화됨
#최종적으로 unlist(mylist)는 전부 벡터여서 0단
#unlist(mylist,recursive=FALSE)는 전부 리스트이며 1단
#mylist는 리스트안에 리스트가 있어서 2단

#리스트 합치기 c()함수 사용:c(리스트들,recursive=FALSE)
c(list(1,'2'),list(5,c(1,3)))  #4개의 리스트
c(list(1,'2'),list(5,c(1,3)),recursive=TRUE) #5개의 벡터가 나옴
#이때 '2'가 character이므로 전부 캐릭터화
c(list('1',matrix(1:4,ncol=2)),list(5,c(1,3)))  #행렬나옴
c(list('1',matrix(1:4,ncol=2)),list(5,c(1,3)),recursive=TRUE)  #전부 character로 벡터화

#리스트나 벡터에 함수 적용
# lapply(list,function)-리스트어플라이는 리스트 각 원소에 접근해서 같은 함수를 적용시켜줌
lapply(list(1:2,1:5),sum) #1:2에 sum, 1:5에 sum 각각적용-리스트로 표현,()는 생략

# sapply(list,fuction)-simplified-apply로 결과를 단순화 시켜 벡터형식으로 뱉어냄
sapply(list(1:2,1:5),sum)

#연습문제:각 벡터들의 최대값의 위치는?
set.seed(1)
mylist3 <- replicate(100,runif(sample(10:50,1))) #replicate:함수를 100번 복제해라(반복해라)
str(mylist3)  #str은 structure를 의미->어떤 구조인지 보여줌
lapply(mylist3,which.max)  #which.max함수 이용
