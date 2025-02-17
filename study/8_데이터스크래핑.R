#데이터스크래핑-정보의 가공 및 추출-원하는 정보만을 빼와서 내 데이터로 만듬
#웹 스크래핑-웹에 있는 정보 가져오기

#지적재산권 침해요소
#다른 사람의 재산일 경우-ex)숙박업소, 제품판매사이트 등
#나의 스크랩이 사이트의 트래픽에 영향을 주면 안됨

#스크랩이 허용된 정보인가?-> robots.txt확인
#사이트url/robots.txt 입력->allow인 것들만 스크랩 가능


#필요준비물-크롬확장프로그램->크롬웹스토어방문->selectorGadget다운
#실행시 화면에 주황색 박스->클릭하면 html의 해당 태그 나옴
#rvest패키지와 너무 좋음
install.packages('rvest')
library(rvest)

# rvest()의 주요함수들
#read_html(): 웹페이지 읽어오기
#html_elements(): 특정요소에해당하는내용추출하기
#html_attr(): 특정태그에해당하는값추출하기
#html_text(): 추출한내용텍스트로 바꾸기

#목차가져오기 연습
url <- 'https://courses.statisticsplaybook.com/p/r'
web_page <- read_html(url)
print(web_page)
length(web_page) #head와 body 두개의 벡터로 이루어져있구나
#사이트 우클릭 후 소스보기-><head>와 <body>두 부위가 web_page의 시작부분

#목차 내용 가져오기
#selectorgadget으로 해당 페이지 목차 가져오기-선택은클릭
#선택된 부분 없애기->빨간색인 부분 다시 클릭하여 제거
#밑의 상자칸의 정보 복사->html_elements에 넣음
chapter_name <- web_page|>
  html_elements('.block__curriculum__section__list__item__link')
#이것도 가능
html_elements(web_page,'.block__curriculum__section__list__item__link')
chapter_name #길이18의 벡터
print(chapter_name[1],width=1000) #옆이 잘리므로 width로 1000까지 늘려줌
#ㄴ>기초공략zip교재안내가 무수히 많은 태그들로 둘러쌓여있음

#태그없애고 안의 실제 컨텐츠만 가져오기
chapter_name|>html_text() #18줄의 실제내용

#transfermarkt.com 스크래핑
#transfermarkt.com/robots.txt->allow존재하므로 스크랩
#market value->most valuable playes페이지로

#문제-선수이름 불러오기
url2 <- 'https://www.transfermarkt.com/spieler-statistik/wertvollstespieler/marktwertetop'
web_page2 <- read_html(url2)
player_name <- web_page2|>
  html_elements('#yw1 .inline-table a')|>html_text()
player_name
player_name <- player_name[1:25*2]

#선수 나이 가져오기
player_age <- web_page2|>
  html_elements('#yw1 td:nth-child(3)')|>html_text()
player_age
player_age <- as.integer(player_age) #파이썬의 int()

#클럽정보 가져오기
#그냥 클릭하면 이미지여서 안됨->좀더 내리면 img말고 tda있음
player_club <- web_page2|>
  html_elements('#yw1 .zentriert a')
print(player_club[1],width=1000) # a tag가 제일 크게 감싸고 있음
player_club <- player_club|>html_children()   # 제일 바깥 태그를 벗김-><a사리지고 <img tag
print(player_club[1],width=1000)
#img안에 속성: scr='https://..., alt='manchester city'
player_club <- player_club|>html_attr('alt') # alt안의 것을 가져오겠다
player_club
#alt 대신 title도 가능

#국가불러오기
player_nation <- web_page2|>
  html_elements('.flaggenrahmen')
print(player_nation[1],width=1000)
player_nation <-player_nation|>html_attr('title') #alt도 가능
player_nation

#이중 국적의 문제->테이블 선택
player_nation <- web_page2|>
  html_elements('.zentriert:nth-child(4)')
player_nation <- player_nation[-1]
print(player_nation[2],width=1000) #이중국적인 애
#구조가 <td><img><img><td>
html_children(player_nation[2]) #<img><br><img>, <br>은 줄바꿈을 의미
length(html_children(player_nation[2])) #3개다

count_dup <- sapply(player_nation,
                    \(x) length(html_children(x))) #\(x)->player_nation을 x에 넣을것이다
count_dup
which(count_dup>1) #이중국적자의 위치
result <- sapply(player_nation,
                 \(x) html_attr(html_children(x)[1],'alt'))
result #앞의 것만 가져옴
player <- data.frame(name=player_name,
                     age=player_age,
                     club=player_club,
                     national=result)
player

#정규표현식 사용하여 market value가져오기
player_value <- web_page2|>
  html_elements('.rechts a')
player_value
player_value <- player_value|>html_text()
player_value

#유로 제거하기
install.packages('stringr')
library(stringr)
#str_extract(string,기준)->string중 기준에 해당하는 애들만 가져올 수 있음
value <- str_extract(player_value,'\\d+\\.\\d+')
value <- as.integer(value)
value
player$value <- value
player

#csv파일 생성
write.csv(player,
          file = "./soccer.csv", 
          row.names = FALSE,
          fileEncoding = "UTF-8")

#다른 페이지도 스크래핑
#다음 페이지로 가도 주소가 같음->2 우클릭 후 주소 복사 후 새페이지에서 열기
base_url <- 'https://www.transfermarkt.com/spieler-statistik/wertvollstespieler/marktwertetop/mw/cpAuthError/access_denied/cpAuthErrorDescription/page/4/2/10/14/5//page/' #뒤에 페이지 2만 지움
url <- paste0(base_url,1:3) #여러개의 페이지

data_scrap <- function(url){
  web_page <- read_html(url)
  player_name <- web_page|>
    html_elements('#yw1 .inline-table a')|>html_text()
  player_name 
}
result <- lapply(url,data_scrap)
result #리스트화 되어있음
unlist(result) #벡터화
