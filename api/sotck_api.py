import pykis
import pandas as pd
import numpy as np
import seaborn as sns
import matplotlib.pyplot as plt
from matplotlib.animation import FuncAnimation
import yaml
import os
from dotenv import load_dotenv

# load .env
load_dotenv()

# API 사용을 위한 API key정보 및 계좌 정보를 설정합니다. 
# 별도의 파일(json, yaml, xml, etc) 등에 내용을 저장하여 불러오는 것을 추천합니다. 
# key 정보는 절대 외부로 유출되지 않도록 주의하시고, 유출시 즉시 재발급 하시기 바랍니다.  

g_appkey = os.environ.get('g_appkey')
g_appsceret = os.environ.get('g_appsceret')
g_account_code = os.environ.get('g_account_code')
g_product_code = os.environ.get('g_product_code')

key_info = {		# KIS Developers 서비스 신청을 통해 발급받은 API key 정보
	"appkey": g_appkey,                  
	"appsecret": g_appsceret} 
# api키 유출 조심

account_info = {	# 사용할 계좌 정보
	"account_code": g_account_code,   
	"product_code": g_product_code            
  }
# ex> "01", "22", etc

# API 객체 생성 
api = pykis.Api(key_info=key_info, account_info=account_info)

# 모의 계좌를 사용하는 경우
domain_info = pykis.DomainInfo(kind="virtual")

# API 객체 생성 
api = pykis.Api(key_info=key_info, domain_info=domain_info, account_info=account_info)

#### 국내 주식 현재가 조회
ticker = "005930"   # 삼성전자 종목코드
price = api.get_kr_current_price(ticker)
print('국내주식 현재가 ', price)

#### 국내 주식 상한가 조회
ticker = "005930"   # 삼성전자 종목코드
price = api.get_kr_max_price(ticker)
print('국내주식 상한가 ', price)

#### 국내 주식 하한가 조회
ticker = "005930"   # 삼성전자 종목코드
price = api.get_kr_min_price(ticker)
print('국내주식 하한가 ', price)

#### 국내 주식 잔고 조회 
# DataFrame 형태로 국내 주식 잔고 반환 
stocks_kr = api.get_kr_stock_balance()
print(stocks_kr)

#### 국내 주식 총 예수금 조회 
deposit = api.get_kr_deposit()
print(deposit)

#### 국내 주식 매수 주문
# ticker = "005930"   # 삼성전자 종목코드
# price = 100000      # 매수 가격 예시. 가격이 0 이하인 경우 시장가로 매수
# amount = 1          # 주문 수량

# 삼성전자 1주를 지정가로 매수 주문 
# api.buy_kr_stock(ticker, amount, price=price)

#### 국내 주식 매도 주문 
# ticker = "005930"   # 삼성전자 종목코드
# price = 100000      # 매도 가격 예시. 가격이 0 이하인 경우 시장가로 매도
# amount = 1          # 주문 수량

# 삼성전자 1주를 지정가로 매도 주문 
# api.sell_kr_stock(ticker, amount, price=price)

#### 정정/취소 가능한 국내 주식 주문 조회
# 정정/취소 가능한 국내 주식 주문을 DataFrame으로 반환
# orders = api.get_kr_orders()
# print(orders)

# 최근 30 일/주/월 OHLCV 데이터를 DataFrame으로 반환
ticker = "005930"   # 삼성전자 종목코드
time_unit = "M"     # 기간 분류 코드 (D/day-일, W/week-주, M/month-월), 기본값 "D"
ohlcv = api.get_kr_ohlcv(ticker, time_unit)

print(ohlcv)
sns.lineplot(data = ohlcv, x = 'Date', y = 'Close')
plt.show()


