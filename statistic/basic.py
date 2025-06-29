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
result = stats.binomtest(k=k, n=50, p=0.4, alternative='two-sided') # k: 성공횟수, n: 총시도수, p: 성공확률
pvalue = result.pvalue # 이 값이 0.05보다 커야 이항분포와 차이가 없다 == 귀무가설이 맞다
ex)150명의 합격자 중에서 남자 합격자가 62명일 때 남여 합격률에 차이가 있다고 할수 있는가? (신뢰수준 99%하에서 검정)
result = stats.binomtest(k=62, n=150, p=0.5, alternative='two-sided')
result.pvalue #이게 0.04나옴 -> 신뢰수준이 99퍼이므로 p-value가 0.01보다 작게나와야 다르다고 할수있음
   #-> 만약 신뢰수준 95퍼에서 검정한다했으면 남여합격률에 차이가 있다고 판단-> 대립가설 채택(차이가있다)



---가설검정

          모수(모집단)   vs   통계량(표본)
평균        µ(모평균)        X_bar(표본의 평균)
표준편차   σ(모표준편차)        S (표본의 표준편차)
분산        σ2(모분산)         S^2(표본의 분산)
대상수      N(사례수)          n(표본수)

1. 가설설정
  -귀무가설 H0: 두 변수간의 관계가 없다, 차이가 없다 등 (=, >=, <=)
  -대립가설 H1: 두 변수간의 관계가 있다, 차이가 있다, 효과가 있다 등 (>, <, !=) 

  -양측검정(two-sided): 대립가설에 방향성 없음 ( = or != )
    임계값 2개 (정규분포그래프에서 양쪽 기각역 2개)
  -단측검정(one-sided): 대립가설이 방향성을 포함(우측 > or 좌측 < )
    임계값 1개 (정규분포그래프에서 '이하'면 왼쪽 기각역 검정 vs '이상'이면 오른쪽 기각역 검정)     


2. 유의수준(alpha) 결정
  -alpha(유의수준): 가설을 신뢰할 수 없는 확률(보통 5%)
      유의수준 이상 ➔ 귀무가설 채택(신뢰할 수 있는 확률 5% 이상)
      유의수준 미만 ➔ 귀무가설 기각(신뢰할 수 있는 확률 5% 미만)
  -신뢰수준(1-alpha): 가설을 신뢰할 수 있는 확률(보통 95%) 

  -유의수준 결정
      일반 사회과학 분야 : α=0.05(5%)
      의.생명분야 : α=0.01(1%) 

      
3. 검정통계량: 표본으로 모수(평균,분산)를 검정에 이용하는 통계 -> 유의확률 p값 도출
  -z분포: 표본수 n>30이상으로 충분히 큰 경우, 정규분포
  -z 검정: 모집단이 정규분포이고 모집단의 분산을 알때 사용 
    -> 표본의 평균과 모집단의 표준편차 이용해 모평균 추정
  
  -t분포: 표본수가 n<30일때 z분포 대신 사용하는 분포 
  -t 검정: 모집단이 정규분포이지만 모집단의 분산을 모를때 사용 (주로 사용)
    -> 표본의 평균과 표준편차이용해 모평균 추정
주로사용하는  검정 t-test는 주로 집단간의(모집단과 표본집단) 평균을 비교

4. 가설 기각 or 채택 설정
유의수준 결정하고 p-value가 유의수준이하면 대립가설 채택, 유의수준이상이면 귀무가설 유지


### t검정 -> 집단 2개
from scipy import stats

# 단일표본 t검정: 한 집단 평균차이 검정(모평균검정)
result= stats.ttest_1samp(표본데이터(리스트형태 등),모평균값 , alternative='two-sided' or 'less' or 'greater')
print(result) # 검정통계량, p-value -> 0.05보다 작으면 표본은 모집단과 평균이 다르다

# 독립표본 t검정: 두 집단 평균차이 검정
result= stats.ttest_ind(A, B, alternative='less' or 'greater' or 'two-sided') 
print(result) # 검정통계량, p-value -> 0.05보다 작으면 두 집단은 다르다 

# 대응표본 t검정 : 한 집단의 전 후 차이 검정
result=stats.ttest_rel(before, after, alternative='greater' or 'less' or 'two-sided')
print(result) # 검정통계량, p-value -> 0.05보다 작으면 어떤 약이 집단에 유의미한 차이를 부여했다


### 분산분석(ANOVA) -> 집단 3개이상의 평균을 비교 
from scipy import stats # 일원분산분석(One-way_ANOVA) 
from statsmodels.formula.api import ols # 이원분산분석모델 생성  
import statsmodels.api as sm # 이원분산분석(Two_way_ANOVA) 

# 일원분산분석(One-way ANOVA): 독립변수(x)1개, 종속변수(y)1개
f_statistic, p_value = stats.f_oneway(group1, group2, group3) #리스트(단일컬럼)로 된 그룹을 넣어줌
print("F-statistic:", f_statistic)
print("p-value:", p_value)

# 이원 분산분석(Two-way ANOVA): 독립변수(x)2개, 종속변수(y)1
model = ols('종속변수 ~ 독립변수1 + 독립변수2', data=df).fit() # df의 컬럼명 그냥 넣으면 됨 ex) 'value~age+kick+sprint'
anova_table = sm.stats.anova_lm(model)
print(anova_table)

# 다원 변량 분산분석:독립변수(x)여러개, 종속변수(y) 여러개




### 카이제곱검정
1. 적합도 검정(1개의 변인): 한 개의 확률변수의 적합성 검정 - 일원

게임에서 사용하는 주사위가 공정한지 알아보기 위하여 60번 던지는 실험
real_data = [4, 6, 17, 16, 8, 9] # 관측값 - 관측도수 
exp_data = [10,10,10,10,10,10] # 기대값 - 기대도수 
chis = stats.chisquare(real_data, exp_data)
print(chis) # 0.05보다 크면 귀무가설:각 눈금의 확률이 1/6로 동일한 주사위에서 얻은 표본이다을 채택
            # else: 각 눈금의 확률이 1/6로 동일한 주사위에서 얻은 표본이 아니다.-> 공정하지 않다

2. 독립성 검정(2개의 변인) : 범주(집단)별로 차이가 있는지를 검정

예시) 남녀집단(변수1)과 공포영화선호도(변수2)
table = pd.crosstab(index=sex, columns=horror) # 교차분할표
chi2, pvalue, df, evalue = stats.chi2_contingency(observed= table) # 독립성 검정
print('chi2 = %.6f, pvalue = %.6f, d.f = %d'%(chi2, pvalue))
 #0.05보다 크면 성별과 공포영화선호도간에 관련성이 없다.
 #0.05보다 작으면 성별과 공포영화선호도간에 관련성이 있다. -> 차이가 있다.




###상관계수: 두 숫자형 변수 간의 관계의 강도와 방향을 파악하는 통계적 방법
- x,y가 바껴도 상관관계는 그대로  corr(x,y)==corr(y,x)
- 상관계수를 계산할 때 각 변수를 모두 표준화하기 때문에 단위의 영향을 받지 않음
- 상관계수 r은 항상 -1과 1사이의 숫자
from scipy.stats import pearsonr
data = pd.DataFrame({'공부시간': [1, 2, 3, 4, 5],
                    '점수': [55, 55, 65, 65, 75]})
r, p = pearsonr(data['공부시간'], data['점수'])
r= 상관계수, p=p-value(0.05이하여야 두 변수 간 상관관계있다) 
