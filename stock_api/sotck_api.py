import pykis

# API 사용을 위한 API key정보 및 계좌 정보를 설정합니다. 
# 별도의 파일(json, yaml, xml, etc) 등에 내용을 저장하여 불러오는 것을 추천합니다. 
# key 정보는 절대 외부로 유출되지 않도록 주의하시고, 유출시 즉시 재발급 하시기 바랍니다.  


key_info = {		# KIS Developers 서비스 신청을 통해 발급받은 API key 정보
	"appkey": "PSG4LDbHPH8BI4SjA1jeIFCEIZyAKhTqqYB9",                  
	"appsecret": "lJ6HHvDXoYVPWW5P0tDMl1qE/GE5c4iDSgT3H0xcbqarJeBe939M1Ju8WNkYdJi24gfwi3qTbN0j8XrrNtNJ+uXWkpdQdeb4Ps587eUSqGT3uq4A7elFB5n14sNRvAsdxj0F/ZOGVichh4gLjfMmucznlkOte6fQDZtwOSVEPb3YxNubaCY=" 
    
} # api키 유출 조심

account_info = {	# 사용할 계좌 정보
	"account_code": "[API를 신청한 종합 계좌번호(계좌번호 앞자리 8자리 숫자)]",   
	"product_code": "[계좌번호의 끝자리 2자리 숫자]"             # ex> "01", "22", etc
}

# API 객체 생성 
api = pykis.Api(key_info=key_info, account_info=account_info)

# 모의 계좌를 사용하는 경우
domain_info = pykis.DomainInfo(kind="virtual")

# API 객체 생성 
api = pykis.Api(key_info=key_info, domain_info=domain_info, account_info=account_info)

# 최근 30 일/주/월 OHLCV 데이터를 DataFrame으로 반환
ticker = "005930"   # 삼성전자 종목코드
time_unit = "D"     # 기간 분류 코드 (D/day-일, W/week-주, M/month-월), 기본값 "D"
ohlcv = api.get_kr_ohlcv(ticker, time_unit)
print(ohlcv)

#### 국내 주식 현재가 조회
ticker = "005930"   # 삼성전자 종목코드
price = api.get_kr_current_price(ticker)
print('국내주식 현재가 ', price)

#### 국내 주식 하한가 조회
ticker = "005930"   # 삼성전자 종목코드
price = api.get_kr_min_price(ticker)
print('국내주식 하한가 ', price)

#### 국내 주식 매수 주문
ticker = "005930"   # 삼성전자 종목코드
price = 100000      # 매수 가격 예시. 가격이 0 이하인 경우 시장가로 매수
amount = 1          # 주문 수량

print('종목 ', ticker, ' 매수 가격 ', price, ' ', '주문수량 ', amount)
