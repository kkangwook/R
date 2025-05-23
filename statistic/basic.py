import statistics as st 
-기본 함수 :
x=df[col]

평균 = st.mean(x)
중위수 = st.median(x)
# 짝수일때 -> 중위수는 2개 -> low, high로 구분
낮은 중위수 = st.median_low(x),  높은 중위수 = st.median_high(x)
최빈수 =  st.mode(x)
표본의 분산 = st.variance(x)  #모집단에서 일부 표본 x를 뽑았을때
모집단의 분산 = st.pvariance(x)  # x는 그냥 모집단
표본의 표준편차 = st.stdev(x)  #모집단에서 일부 표본 x를 뽑았을때
모집단의 표준편차 = st.pstdev(x)  # x는 그냥 모집단
사분위수 : st.quantiles(x)  # 1qr, 2qr, 3qr순서로 리스트로 반환
변동계수(Coefficient of Variation) : 표준편차를 평균으로 나눈 값으로 평균이 다른 두 집단 비교 시 유용


import scipy.stats as sts
- 분포의 정보
# 왜도(치우침): 왼쪽으로 치우침=오른쪽에 데이터가 몰려있다(꼬리가 왼쪽에 있다)
sts.skew(x)  -> 기울어짐을 측정: 0이면 좌우대칭, 0보다 크면 왼쪽으로 치우침, 0보다 작으면 오른쪽으로 치우침 
# 첨도(가장 높은 봉우리 척도)
sts.kurtosis(x) -> 0이면 정규분포, 0보다 크면 뾰족함, 0보다 작으면 완만함 


-연속확률분포(연속적이서 셀수없음 ex:키)  vs  이산확률분포(셀수 있음 ex:성공횟수)
  연속확률분포 
    정규분포: sts.norm.rvs(mu,sigma,size) # rvs는 N개 표본추출 
    sts.beta.rvs(a=2, b=5, size=100) : 알파(a)와 베타(b) 구간의 연속확률분포 
    sts.chi2.rvs(df=자유도, size=100) : 극단값을 허용하는 멱분포, 표본 수가 많을수록 대칭
    sts.f.rvs(dfn=분자자유도, dfd=분모자유도, size=100) stats.f : 두 chi2분포를 각각의 자유도(d.f)로 나눈 비율을 나타낸 분포
    sts.t.rvs(df=자유도, size=100) : 표본수가 작은 경우(30개 미만) 정규분포 대신 사용(표본 수 많아질수록 정규분포와 유사해짐)
    sts.uniform.rvs(a=0, b=1, size=100) : 0~1사이에서 균등하게 표본추출된 확률분포 

  이산확률분포
    sts.bernoulli.rvs(p, size=100) : 독립시행 !!1번!!(베루누이시행)으로 추출된 베루누이 분포 
        -> 값이 1 or 0이 확률에 따라 100개 ex) [1,0,1,1,0,0,1,1,1,0,1,0,0]
    sts.binom.rvs(n=시행횟수, p, size=100) 독립시행 !!n번!!으로 표본이 추출된 이항분포
        -> n번 시도해서 성공횟수값을 100개    ex) [5,4,6,5,5,4,3,6,5,7] 
    sts.geom.rvs(p=성공확률, size=100) : 최초 성공할 때 까지 실패한 횟수를 갖는 기하분포
    sts.poisson.rvs(mu= 평균발생횟수, size=100) : 발생 가능성이 매우 작은 포아송분포


-정규성 검사
  sts.shapiro(x) : 검정통계량과 p-value 동시에 반환
  # 검정통계량: 1에 가까울수록 정규분포와 유사
  # p-value가 0.05보다 커야 귀무가설(정규분포와 차이가 없다) 채택, 아니면 대립가설(정규분포와 차이가 있다)이 채택됨

  정규분포를 표준정규분포화(z) 하기:  (X - mu) / sigma # X는 정규분포

-이항검정 : stats.binomtest -> pvalue값 나옴
예시) 게임에 이길 확률(p)이 40%이고, 게임의 시행회수가 50 일 때 95% 신뢰수준에서 검정    
귀무가설(H0) : 게임에 이길 확률(p)는 40%와 차이가 없다 vs 대립가설(H1) : 게임에 이길 확률(p)는 40%와 차이가 있다
ex) # 베르누이분포 표본 추출 
binom_sample = stats.binom.rvs(n=1, p=p, size=50)
k = np.count_nonzero(binom_sample) # k는 성공(1값) 개수  
result = stats.binomtest(k=k, n=50, p=0.4, alternative='two-sided') #
pvalue = result.pvalue # 이 값이 0.05보다 커야 이항분포와 차이가 없다 == 이항분포를 잘 따른다
