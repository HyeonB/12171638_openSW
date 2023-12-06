import pandas as pd

if __name__=='__main__':
	#DO NOT MODIFY THIS FUNCTION UNLESS PATH TO THE CSV MUST BE CHANGED.
	data_df = pd.read_csv('2019_kbo_for_kaggle_v2.csv')

	#문제1
	years = [2015,2016,2017,2018]
	sorting = ['H','avg','HR','OBP']
	k_sorting = ["안타","타율","홈런","출루율"]
	for year in years:
		print(f"{year}년")
		for i in range(4):
			print(f"{year}연도 {k_sorting[i]} 상위 10명")
			s_d = data_df.sort_values(by=['year',sorting[i]], ascending=False)
			im = s_d[s_d.year == year].head(10)
			print(im)
			print("")

	#문제2
	position = ["포수","1루수","2루수","3루수","유격수","좌익수","중견수","우익수"]
	d_2018 = data_df[data_df.year == 2018]
	for i in position:
		im = d_2018[d_2018.tp == i]
		s_d = im.sort_values(by=['war'], ascending=False)
		print(f"{i} 승리기여도 1위")
		print(s_d.head(1))
	#문제3
	among = ["R","H","HR","RBI","SB","war","avg","OBP","SLG"]
	high = -10
	hiv = ""
	sal = data_df.salary

	for i in among:
		im = data_df[i]
		cor = sal.corr(im)
		print(f"{i} correlation: {cor}")
		if cor > high:
			high = cor
			hiv = i
	
	print("Highest correlation with Salary:",hiv)
