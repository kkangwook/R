import statistics as st 
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
