# spring-boot-oauth2-example

### OAuth2 Server端配置

生成JWT秘钥

```
$ keytool -genkeypair -alias jwt -keyalg RSA -dname "CN=jwt, L=Berlin, S=Berlin, C=DE" -keypass mySecretKey -keystore jwt.jks -storepass mySecretKey
```

将秘钥存储到`OAuth2 Server`端的`src/main/resources/jwt.jks`

根据秘钥生成公钥

```
$ keytool -list -rfc --keystore jwt.jks | openssl x509 -inform pem -pubkey
▒▒▒▒▒▒Կ▒▒▒▒▒:  mySecretKey
-----BEGIN PUBLIC KEY-----
MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAoLnfiQCCqhXbrRHg/hhR
RIBffp/B/c5xyXqKJ3QYKU2s3iPo9eVFNvZu80KzKhQ6CsTgzRHfujxVp3IOB/CN
tKPfx2P6ulIS0R9sA4mDiXINYLao8Kpg7uK865QehYitB5voMNDTzi3sjUBoKlK5
ps46Pd8YmuXmM7TxonFGYjaGGtdt+w0RiC5ggF3mvzk6AHUR1KupCNPpcsGNMYGG
ek4FMcxZf2QBJEtvRN76blwQiUDX6R7xx4yeKsew2sVU86hE14h2NbuvVtdDIOKM
+F76o3+zGQzn4/Ijcs9faWoHbLUmigEmYU08B2zc3/6eDiaFsa0Lcm8QCWprVfpe
DQIDAQAB
-----END PUBLIC KEY-----
-----BEGIN CERTIFICATE-----
MIIDGTCCAgGgAwIBAgIEULSkdTANBgkqhkiG9w0BAQsFADA9MQswCQYDVQQGEwJE
RTEPMA0GA1UECBMGQmVybGluMQ8wDQYDVQQHEwZCZXJsaW4xDDAKBgNVBAMTA2p3
dDAeFw0xNjExMDUwNjAyNTFaFw0xNzAyMDMwNjAyNTFaMD0xCzAJBgNVBAYTAkRF
MQ8wDQYDVQQIEwZCZXJsaW4xDzANBgNVBAcTBkJlcmxpbjEMMAoGA1UEAxMDand0
MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAoLnfiQCCqhXbrRHg/hhR
RIBffp/B/c5xyXqKJ3QYKU2s3iPo9eVFNvZu80KzKhQ6CsTgzRHfujxVp3IOB/CN
tKPfx2P6ulIS0R9sA4mDiXINYLao8Kpg7uK865QehYitB5voMNDTzi3sjUBoKlK5
ps46Pd8YmuXmM7TxonFGYjaGGtdt+w0RiC5ggF3mvzk6AHUR1KupCNPpcsGNMYGG
ek4FMcxZf2QBJEtvRN76blwQiUDX6R7xx4yeKsew2sVU86hE14h2NbuvVtdDIOKM
+F76o3+zGQzn4/Ijcs9faWoHbLUmigEmYU08B2zc3/6eDiaFsa0Lcm8QCWprVfpe
DQIDAQABoyEwHzAdBgNVHQ4EFgQUaisB+TYSddByoWa9a9Xhpjx3+YQwDQYJKoZI
hvcNAQELBQADggEBAHyLIstXg+O63ETlsyovscyGVv4F1MrWx3nmZT++mlr7Ivbw
UoOzG71knOkaAINox/BrPCciDddBIRkKDdT6orolMg1HiPZGwCt+DJ2c7J/kFyJ3
kCUeQp6JefHIKrQUeEErPSDaQpm+afc0mq5I/FP5Kg0aSg6sUr1SJfqG6aEWf/pg
8V8I3/bGFG1QzHER3R/hX2f+09UElgIvIK8KTJoT1EnVRbzDyG0IEvvheIk/TXG+
ICaxFrDCkavbP2Swx7HuMNi9FQEIQ7lwPYtzX6cfeYYNHJ1CR70uN9YYkroTRWLx
4vsgVFhzRbGvnW5Ufv18lI0IThHsU395F/75aFw=
-----END CERTIFICATE-----
```

注：mySecretKey为生成秘钥时使用的密码

### OAuth2 Client端配置

拷贝生成的公钥存储到`OAuth2 Client`端`src/main/resources/public.cert`

```
-----BEGIN PUBLIC KEY-----
MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAoLnfiQCCqhXbrRHg/hhR
RIBffp/B/c5xyXqKJ3QYKU2s3iPo9eVFNvZu80KzKhQ6CsTgzRHfujxVp3IOB/CN
tKPfx2P6ulIS0R9sA4mDiXINYLao8Kpg7uK865QehYitB5voMNDTzi3sjUBoKlK5
ps46Pd8YmuXmM7TxonFGYjaGGtdt+w0RiC5ggF3mvzk6AHUR1KupCNPpcsGNMYGG
ek4FMcxZf2QBJEtvRN76blwQiUDX6R7xx4yeKsew2sVU86hE14h2NbuvVtdDIOKM
+F76o3+zGQzn4/Ijcs9faWoHbLUmigEmYU08B2zc3/6eDiaFsa0Lcm8QCWprVfpe
DQIDAQAB
-----END PUBLIC KEY-----
```

### 运行OAuth2 Server，获取accesstoken

* 使用grant_type=password获取accesstoken

使用`POST`方式请求`appClient:appSecret@http://localhost:9999/oauth/token`接口传递`grant_type=password`使用用户名密码直接授权获取`accesstoken`

获取具有只读权限的`accesstoken`

```
$ curl -XPOST "appClient:appSecret@localhost:9999/oauth/token" -d "grant_type=password&username=user&password=user"
{"access_token":"eyJhbGciOiJSUzI1NiJ9.eyJleHAiOjE0NzgzNzQ3NTcsInVzZXJfbmFtZSI6InVzZXIiLCJhdXRob3JpdGllcyI6WyJSRUFEIl0sImp0aSI6Ijg4Zjk4ZWYxLTZjOGItNDA1MC1iOTc3LWFlYjcxMzhlNjg2OCIsImNsaWVudF9pZCI6ImFwcENsaWVudCIsInNjb3BlIjpbIk9BdXRoMiJdfQ.sop6d8acs6piMgiN1FH8EVw4Qglh69wU5vvdMQZ87YSVjtaTCQqpf4kR65jXtqTNuTTZ8azf_aD5GoIBaqVrDDGEHk8dZLciobgD1vexpX2XnrfAFUt0xHg1LXIO_mJtf7x4CBiF4ysGWdlhWQbX2wq5YNvG3QhIkRHdnvxBNSiLJPSaa2sqHKxdXs4J7tLnNN415K1TI2pV7_6C3p-BQD2qfdIWZXB2JLYSmTVjnvUQtjIvLDNu8OL7mvyfP2F_d-b-PAPYU4ul9RZfnB9hYr02i8M-7lYh7pK-SoA0MlMlIP-QSDpACTqWuWpyP_q8N-tFDwPZ997ES2FOaWArFA","token_type":"bearer","refresh_token":"eyJhbGciOiJSUzI1NiJ9.eyJ1c2VyX25hbWUiOiJ1c2VyIiwic2NvcGUiOlsiT0F1dGgyIl0sImF0aSI6Ijg4Zjk4ZWYxLTZjOGItNDA1MC1iOTc3LWFlYjcxMzhlNjg2OCIsImV4cCI6MTQ4MDkyMzU1NywiYXV0aG9yaXRpZXMiOlsiUkVBRCJdLCJqdGkiOiJmMWNhYTI5YS05Zjg5LTQ4YmItYTIxZi02MTI3OTM0YzI1MWEiLCJjbGllbnRfaWQiOiJhcHBDbGllbnQifQ.ZevWVRKmRIqJ7njhXmcykgGJ4sAY9qItMdFiLDEX68hAYcRpiv2Q5mifIH3HPvVB-Nv84oGHI2cam2Bs4gIH6SJbBlzYxanOdWOkyN9vknVEkFiA0bwh9hyem94sbbTmxYr3kFfuhFvPma6v7iD-YFxnVqvBo8WoMEMEwZlcOxD5fV0yyRdst_i7PTfPc4hyc5sfW75IJdGduD_tp5ePnRMO6pXUYXhfcCXgf3zHYd_HlR88cqA__yh_0b3AY4TFts19SW68LgzG72UOP5F1HYzLetiwtAwpnPJawTDCYQLMf5YCnHoNxZR3RKcuDE8xwgt_Ytn8Tg9KHMXZzk0Gig","expires_in":43199,"scope":"OAuth2","jti":"88f98ef1-6c8b-4050-b977-aeb7138e6868"}
```

获取具有读写权限的`accesstoken`

```
$ curl -XPOST "appClient:appSecret@localhost:9999/oauth/token" -d "grant_type=password&username=admin&password=admin"
{"access_token":"eyJhbGciOiJSUzI1NiJ9.eyJleHAiOjE0NzgzNzQ4MDQsInVzZXJfbmFtZSI6ImFkbWluIiwiYXV0aG9yaXRpZXMiOlsiUkVBRCIsIldSSVRFIl0sImp0aSI6IjgwYTU3Y2NkLTQzMGItNGQ5Zi1iODRjLWE0YTNjODQwODAxZiIsImNsaWVudF9pZCI6ImFwcENsaWVudCIsInNjb3BlIjpbIk9BdXRoMiJdfQ.nePNHgpMDukjhyZEYe_PFNSoGtftA61UmPy93P3r6VCrofhQpXP6vRUCBVTY0NfPXAd250x-jrkDS3SjnrSsatMj3WoJpBjPP56SzPQu1J3gUUgnbSu2zfeFZTcA4cEyyaGvZf3tVzCH-g_DQjcPoBL-vBB-RuzML7PfY1Hj8Bbl3ODxnQzUNnvA2FPI_mDuTqiR8L9r1p6xDt9lBKWc_HiZIE7LGt8xNCUKBbj0kQVO3J_L3vUtjWVt2kuvmSJ9eEsO5U6SmZx0Z6B5Xbp5HNgB2lhBlBDZZHk6niA6Mjk1_0LQBERTNgNrtja7ukqH9gcw_s5d0mo6bJCQlzhOMg","token_type":"bearer","refresh_token":"eyJhbGciOiJSUzI1NiJ9.eyJ1c2VyX25hbWUiOiJhZG1pbiIsInNjb3BlIjpbIk9BdXRoMiJdLCJhdGkiOiI4MGE1N2NjZC00MzBiLTRkOWYtYjg0Yy1hNGEzYzg0MDgwMWYiLCJleHAiOjE0ODA5MjM2MDQsImF1dGhvcml0aWVzIjpbIlJFQUQiLCJXUklURSJdLCJqdGkiOiIyODYyZDI3ZS0xYTJiLTQ5ZjAtOGYxZC1mYjI4N2M0MGI5OTMiLCJjbGllbnRfaWQiOiJhcHBDbGllbnQifQ.AHQUjBGynSJ3YvbIIeN92vdCwpOl-dg_m_M9ju935XcPT5AwXP6l99Yo0GnhT2UNqOEV4ibygXjOSY50ZtAVc3eeQC_bGEdqV1xF4fPx8cZ60cEV-dazm69dodGKTP93uFChn5zgxmZoKQHgrxVb3dnJnzMqkDAff9lf7aEbLsI12er9RWJ5bYLJKAUo9oKA3R2m6rO4YUwWsNctXeeq545MDuMR4SXBNwZ9KPGnOn_URKtXIYShnirVJwvlHZ5ZeaaQbn-PDqVyTG4seA7Qk_UQfSany1gSVQFZbgRZjX9pzIw6LV9eRm75gzPmcHMRcS-dtG2JBBYk75R7hmBCiw","expires_in":43199,"scope":"OAuth2","jti":"80a57ccd-430b-4d9f-b84c-a4a3c840801f"}
```

* 使用`code`方式获取`accesstoken`

使用`GET`方式请求`http://localhost:9999/oauth/authorize`接口传递`response_type=code`使用用户名密码授权（基于HttpBasic）先获取`authorization_code`，再使用获取到的`authorization_code`以`GET`方式请求`http://localhost:9999/oauth/token`接口传递`grant_type=authorization_code`获取`accesstoken`

```
http://localhost:9999/oauth/authorize?response_type=code&client_id=appClient&redirect_uri=http://notes.coding.me
```

输入用户名、密码，最终重定向到`http://notes.coding.me/?code=8JsYwV`，再根据返回的`code`获取access token

```
$ curl appClient:appSecret@localhost:9999/oauth/token -d grant_type=authorization_code -d client_id=appClient -d redirect_uri=http://notes.coding.me -d code=8JsYwV
{"access_token":"eyJhbGciOiJSUzI1NiJ9.eyJleHAiOjE0NzgzNzkzMzQsInVzZXJfbmFtZSI6ImFkbWluIiwiYXV0aG9yaXRpZXMiOlsiUkVBRCIsIldSSVRFIl0sImp0aSI6IjAyMjgyMzNkLWVjY2MtNDU5YS1hYjBkLTg4ZGU2MDQ0MWIwMCIsImNsaWVudF9pZCI6ImFwcENsaWVudCIsInNjb3BlIjpbIm9wZW5pZCJdfQ.tGQjNR_Xg_E52xFEIashqWPnH-hnvBsqkKjbNiQgHUGE-4wHNJ-wxxia-cfvfD4IR5fA3AekSUWzGk3uLaD4q66HmCHgl1zdSjgXEqsEC-C1VqI_FLq0HlunFtJ6i4mHjY0nIxsIx5hhdoyVONJk3HyckegCaVUKy8g1q8hn7qiuBpcZCTUhfuYq5Lb1A3nbCUMQRB72eZ3slC8l3Y60kAhVP3gcY5gLYwPrL-1O2FuwEOO_vpoe-yzdp-WxUabpX7v-78oxkpA2LKxQu-9fNwlJmsTTzk4bZ-onRHdVtHjZr_QvqekXTqDBnXVrv26r2cpSqli69R58M8OIvHKpAw","token_type":"bearer","refresh_token":"eyJhbGciOiJSUzI1NiJ9.eyJ1c2VyX25hbWUiOiJhZG1pbiIsInNjb3BlIjpbIm9wZW5pZCJdLCJhdGkiOiIwMjI4MjMzZC1lY2NjLTQ1OWEtYWIwZC04OGRlNjA0NDFiMDAiLCJleHAiOjE0ODA5MjgxMzQsImF1dGhvcml0aWVzIjpbIlJFQUQiLCJXUklURSJdLCJqdGkiOiIyMzJkZDBiMS1kNzc2LTQ4MTItOTllNy0xNjRiZmNhOTY3ZTgiLCJjbGllbnRfaWQiOiJhcHBDbGllbnQifQ.WRgsM-ZFyYwU7ObLjNSzRFe0CUU0P7TyprKY825qL8teHPhgKLOxYDSXDDdjIwlLzOFXRz0skX6-h6kLXvXvvkPRFG3KK01j7jVmOfn1bXTYP0sgOwZvBvkDeZp0LFZIBL2ruH_ciWou6LleCgRIhtUVyKYMojr4-4eFZ_ou6J8ezykvzlf-xwTXJhwOqXf57jeYsXy9eitUf8A_x7Lrz9HffW0HA5JfhFX1P-_W1vS3uUqwQLZovhAzEK2LctZmUHAfUKIuE9Z4Z1_pQDDK7hWbv2eRHAlceRGRvztrEebv-5cksfEUWpiQmj913t20uXzEfJYU3e9JqbqxbaahKA","expires_in":43199,"scope":"openid","jti":"0228233d-eccc-459a-ab0d-88de60441b00"}
```

* 使用`token`方式获取`accesstoken`

使用`GET`方式请求`http://localhost:9999/oauth/authorize`接口传递`response_type=token`使用用户名密码授权（基于HttpBasic）获取`accesstoken`

```
http://localhost:9999/oauth/authorize?response_type=token&client_id=appClient&redirect_uri=http://notes.coding.me
```

输入用户名、密码，最终重定向到`http://notes.coding.me/#access_token=eyJhbGciOiJSUzI1NiJ9.eyJleHAiOjE0NzgzNzg4NjEsInVzZXJfbmFtZSI6ImFkbWluIiwiYXV0aG9yaXRpZXMiOlsiUkVBRCIsIldSSVRFIl0sImp0aSI6ImEyMzE3NTlmLTZhMzktNGQ3YS1iMmMyLWIwOTdlMWZjZTEwMiIsImNsaWVudF9pZCI6ImFwcENsaWVudCIsInNjb3BlIjpbIm9wZW5pZCJdfQ.ASSLsAJa8CsgZDsv5vH8BqYTbmoCCeYKqSmv4m9jl2XpWc2edvauy89Vxvj8z6kKGr8QqDg786u6MMW7fX5CAjP34Mfs9XVI8gfg20Xk0sHoS3WPx0mseIXdJbaxhj0526X5947-eeMr_LDC5N_XlPQ3Qq_PcY3tmyh92IWUri2rRJMKEPHrmVqqWPcPcCSHoEaaMWNTq_gsdbsZiyX4jaW24LVQ0HZ4oYMnmUzbLCvIyPcKF7WR-KKEnOykYX5FJPjnbUz6EK5yG_icdkULsxmDr05JrEgkKR0n_JfL9_gOqpI8mpJFBkAUghM1y9No_fGvvhb22o-H8ar5wnGqYA&token_type=bearer&expires_in=43199&scope=openid&jti=a231759f-6a39-4d7a-b2c2-b097e1fce102`


### 运行OAuth2 Client，使用accesstoken访问资源

```
TOKEN=eyJhbGciOiJSUzI1NiJ9.eyJleHAiOjE0NzgzNzQ3NTcsInVzZXJfbmFtZSI6InVzZXIiLCJhdXRob3JpdGllcyI6WyJSRUFEIl0sImp0aSI6Ijg4Zjk4ZWYxLTZjOGItNDA1MC1iOTc3LWFlYjcxMzhlNjg2OCIsImNsaWVudF9pZCI6ImFwcENsaWVudCIsInNjb3BlIjpbIk9BdXRoMiJdfQ.sop6d8acs6piMgiN1FH8EVw4Qglh69wU5vvdMQZ87YSVjtaTCQqpf4kR65jXtqTNuTTZ8azf_aD5GoIBaqVrDDGEHk8dZLciobgD1vexpX2XnrfAFUt0xHg1LXIO_mJtf7x4CBiF4ysGWdlhWQbX2wq5YNvG3QhIkRHdnvxBNSiLJPSaa2sqHKxdXs4J7tLnNN415K1TI2pV7_6C3p-BQD2qfdIWZXB2JLYSmTVjnvUQtjIvLDNu8OL7mvyfP2F_d-b-PAPYU4ul9RZfnB9hYr02i8M-7lYh7pK-SoA0MlMlIP-QSDpACTqWuWpyP_q8N-tFDwPZ997ES2FOaWArFA
```

以`GET`方式获取资源

```
$ curl -H "Authorization: Bearer $TOKEN" "localhost:9090/users"
```

以`POST`方式获取资源

```
$ curl -XPOST -H "Authorization: Bearer $TOKEN" "localhost:9090/users"
```

获取用户凭证

```
$ curl -H "Authorization: Bearer $TOKEN" "localhost:9999/user"
{"details":{"remoteAddress":"0:0:0:0:0:0:0:1","sessionId":null,"tokenValue":"eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJleHAiOjE0NzgzODY3NjcsInVzZXJfbmFtZSI6ImFkbWluIiwiYXV0aG9yaXRpZXMiOlsiUkVBRCIsIldSSVRFIl0sImp0aSI6Ijc2OTYzMzkyLWUxYzItNDdmMC05ODZjLWZhODQxZmZhYTU1NyIsImNsaWVudF9pZCI6ImFwcENsaWVudCIsInNjb3BlIjpbIm9wZW5pZCJdfQ.WiTSjojK0ow1x7fP0y3EZohCozU2kB4Sxi2xPd7A5RSb48N-KDM8PYjSX--D1iiEQiRt2xOdBij0J0A7pIHfqZMijphyJQtPQjyv_82AIP7hFuW-PFMo2P1VVSTWrZeYzCMCr8p1QaHbM5bJ1KTeiT_Ak8vbqmnd7r4KpqoyEehca69tr02nTPhi7YOfAjUm9czwqhhi2w4bL9b2epYhmv_d2B2LwCY4NZxv64xfeCti8ya-AG_hYoqNRGj2nIHaAR_uCWmDD6_tdESy5oKZJ-881Dr0VFduJu4cAcSxJX-PqI6HklknTm_Vzqik9lI9S02z3fj5sBM7trWvNuBnrQ","tokenType":"Bearer","decodedDetails":null},"authorities":[{"authority":"READ"},{"authority":"WRITE"}],"authenticated":true,"userAuthentication":{"details":null,"authorities":[{"authority":"READ"},{"authority":"WRITE"}],"authenticated":true,"principal":"admin","credentials":"N/A","name":"admin"},"principal":"admin","credentials":"","oauth2Request":{"clientId":"appClient","scope":["openid"],"requestParameters":{"client_id":"appClient"},"resourceIds":[],"authorities":[],"approved":true,"refresh":false,"redirectUri":null,"responseTypes":[],"extensions":{},"grantType":null,"refreshTokenRequest":null},"clientOnly":false,"name":"admin"}
```

阅读以下类源码

org.springframework.security.oauth2.provider.endpoint.TokenEndpoint /oauth/token接口

org.springframework.security.oauth2.provider.endpoint.AuthorizationEndpoint /oauth/authorize接口

org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter 自定义WebSecurityConfigurer

注意:以上请求url中的请求参数名不能随意修改。