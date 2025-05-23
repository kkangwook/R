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

import scipy.stats as sts
- 분포의 정보
# 왜도(치우침): 왼쪽으로 치우침=오른쪽에 데이터가 몰려있다(꼬리가 왼쪽에 있다)
sts.skew(x)  -> 기울어짐을 측정: 0이면 좌우대칭, 0보다 크면 왼쪽으로 치우침, 0보다 작으면 오른쪽으로 치우침 
# 첨도(가장 높은 봉우리 척도)
sts.kurtosis(x) -> 0이면 정규분포, 0보다 크면 뾰족함, 0보다 작으면 완만함 

