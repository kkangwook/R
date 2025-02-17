# readlines()함수 사용->텍스트 파일의 각 줄이 벡터의 원소가 됨
hometown <- readLines('hometown.txt',encoding = 'UTF-8') #UTF-8있어야 오류안남
hometown
head(hometown)
class(hometown)
length(hometown)  #hometown은 22개의 원소로 이루어져 있구나
hometown[1]
hometown[1:7]

#특정 단어를 검색하여 위치를 알려줌-grep(): grep(패턴,문자열벡터)
index <- grep('아버지',hometown)
index  #이 줄에 위치해 있구나
hometown[index]

# 문자열의 길이 재기-nchar(문자열)-각 요소의 숫자 알려줌
nchar(c(1,2,c(1,2),3,'ervhebkebej',4,c('h','i')))
hometown[1]
nchar(hometown[1]) #공백과 특수문자도 글자 하나
nchar(hometown)

#문제- 고향 시에서 가장 길이가 긴 행은 어디일까?
which.max(nchar(hometown))

#여러개의 문자열을 이어주는 paste()
paste('백석','고향')   #공백 있음
paste0('백석','고향')  #paste0는 붙여씀
paste(1:5,'번째')
paste0(1:5,c('st','nd','rd',rep('th',2)))

#paste() 함수의 주요 옵션

#sep->문자열 사이를 원하는 것으로 채워춤
paste('1st','2nd','3rd')
paste('1st','2nd','3rd',sep=', ')  #사이에 ', '
paste(hometown[1],hometown[3],sep=', ')

#collapse
1:5
paste(1:5,collapse = '') #무너뜨리면서 각 원소 사이에''안의 것들을 채워줌
paste(1:5,collapse = ',')
#sep는 여러개 들어왔을때 사이에 넣어서 합침
#collapse는 벡터가 하나 들어왔을때 무너뜨려 재구성
paste(hometown[1],
      hometown[2],
      hometown[3],
      hometown[4],
      hometown[5],
      hometown[6], sep=', ')  #sep-여러개
paste(hometown[1:6],collapse=', ') #collapse-벡터하나

#문자열의 부분을 가져오는 substr(문자열,시작점,끝점)
substr('wvevevbve',4,8)
hometown[1]
substr(hometown[1],3,6)

#문제-6번째줄 마지막 4글자 가져오기
hometown[6]
substr(hometown[6],nchar(hometown[6])-3,nchar(hometown[6])) #length()말고 nchar()사용

#문자열 하나를 나눠 리스트화-strsplit(문자열 벡터,패턴)
#패턴의 기준이 된 애는 사라짐
hometown[3]
strsplit(hometown[3],split=' ') #''안의 것을 기준으로 나눔->리스트화
#문제-'앓아' 만 빼오기
result <-strsplit(hometown[3],split=' ')
result[[1]][4]

#특정 문자 바꿔주기-gsub(): 파이썬의 re.compile.sub와 비슷
#gsub(찾을 패턴, 바꿀내용, 문자열벡터)
hometown[6:7]
gsub(' ','',hometown[6:7])  #띄어쓰기를 없음으로 바꿈
hometown[6]
gsub('의','가',hometown[6]) #의를 가로


#특수문자 gsub으로 지우기
#특수문자들 앞에는 \\백슬래시 2개 붙여줌-> .?!+-[{()}]같은 애들
#한자 없애기
hometown[6]
gsub('\\(如來\\)','',hometown[6])

#|>심화버전
hometown[6]|>{\(x) gsub('\\(如來\\)','',x)}()
#{}()를 큰틀로, {}안에 함수
#\(x)는 ()안에 있는 애를 집어넣겠다->함수안에 x넣음

#문제-mat <- matrix(1:10,ncol=2)를 |>를 사용하여 apply에 넣기
mat <- matrix(1:10,ncol=2)
mat|>{\(x) apply(x,1,mean)}()
1|>{\(x) apply(mat,x,mean)}()  #이렇게도 됨

#regular expression:정규표현식
#특수문자들 앞에는 백슬래시\\2개 붙여줌
gsub('\\.','','statistics.playbook')
gsub('\\?','','statistics?playbook')

# \\d-숫자(0-9) \\D-숫자가 아닌것   digit
# \\w-문자 \\W-문자가 아닌것      word
# \\s-공백 \\S-공백이 아닌것     space
gsub('\\d','','stat.123')
gsub('\\D','','stat.123')

# .은 줄바꿈\n을 제외한 모든 문자를 의미
random_string <- c("123-123","123.123","statistics.playbook","r-programming")
grep("\\d\\d\\d.\\d\\d\\d", random_string)  #-, .등 모든 문자
grep('\\.',random_string)   #.만-> .과 \\.은 다름
gsub('.','','stat슬기로운.123')  #.은 모든 문자->다 지우게됨

#대괄호[]를 사용하여 매칭조건을 설정 가능
#[]안에 있는 애만 매칭
random_string <- c("123-123","123.123","123*123","123!123")
grep("\\d\\d\\d[.*]\\d\\d\\d", random_string) #. or *인 경우만 가져옴
grep("\\d\\d\\d[-!]\\d\\d\\d", random_string)

#매칭 개수 설정
#*:0이상 +:1이상 ?:0또는 1
#{x}:딱 x개 {a,b}:a에서b개
test_string <- c("슬기로운.통계생활", "슬기로운*PlayBOOK")
gsub('슬\\w*','',test_string)
gsub('슬\\w{2}','',test_string)

#[]대괄호안의 것과 매치, [^]대괄호 외의 것과 매치
# | :or  ():그룹
#regexpr->맞는것중 가장 앞에것만 가져옴
test_string <- c("슬기로운.통계생활", "슬기로운통계*PlayBOOK")
regexpr('슬\\w*',test_string) #맞는게 각 요소에 하나씩 있으며, 해당 문자의 길이는 4,6이다
m1 <- regexpr('슬\\w*',test_string)
regmatches(test_string,m1) #각 요소 앞에서부터 4,6개 가져와라
abc <- c('abcabcab','abc')
d <- regexpr('(abc){2}',x)  #abcabc
regmatches(x,d)

ex_str <- c("Mr. 슬통", "Mr 마통","Ms. Lee", "Mr. R",'Mr.R')
m1 <- regexpr("Mr\\.", ex_str)  #없으면 -1이 뜸
m2 <- regexpr("Mr\\.?", ex_str)  # .이 0개나 1개
m3 <- regexpr("M(r|s)\\.?", ex_str) #r or s
m4 <- regexpr('M(r|s)\\.?\\s',ex_str)  #스페이스가 없는 마지막 꺼는 탈락
m5 <- regexpr("M(r|s)\\.?\\s[A-Z]\\w*", ex_str) #[A-Z]는 모든 대문자영어를 의미
m6 <- regexpr("M(r|s)\\.?\\s[가-힣]\\w*", ex_str) #[가-힣]은 모든 한글을 의미
regmatches(ex_str,m1)
regmatches(ex_str,m2)
regmatches(ex_str,m3)
regmatches(ex_str,m4)

#문제: Mr. 슬통, Mr 마통만 가져오기
mm1 <- regexpr('Mr\\.?\\s[가-힣]+',ex_str)
mm2 <- regexpr('Mr\\.?\\s[가-힣]{2}',ex_str) #얘도 가능
regmatches(ex_str,m)


#마지막-고향의 한자어 전부 빼기
gsub('\\([^가-힣]+\\)','',hometown) #한글 외 전부

#\n은 줄바꿈을 뜻함
total <- paste(hometown, collapse = "\n")
total <- gsub("\\([^가-힣]\\w*\\)", "", total) #한글이 아닌 애들을 다 지워줘
file_con <- file("./output.txt", encoding="UTF-8") #./은 현재파일 위치를 의미
#file()은 파일을 만드는 함수-file(이름.확장자,encoding)
writeLines(total, file_con) #내용을 파일안에 적어라
close(file_con) #파일 닫기
