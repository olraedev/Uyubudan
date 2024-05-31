![화면 001](https://github.com/olraedev/Uyubudan/assets/109517070/b1fae367-e81a-4090-8028-71c9aab99ad3)

## 🗳️ 우유부단
```
고민하고 있는 점을 투표 형식의 게시물로 올려 
다른 사용자들의 집단 지성을 이용해 도움을 받을 수 있거나
다른 사용자들에게 도움을 줄 수 있는 앱
```

> 1인 개발
<br> - 기간: 24.04.12 ~ 24.05.05 (약 3주)
<br> - 최소 버전: 16.0 
<br> - 세로 모드
<br> - 라이트 모드 

<br>

## ⚙️ 주요 기능
### 👤 회원 인증
- 회원가입 / 로그인 / 로그아웃 / 회원 탈퇴 / 프로필 수정

### ✉️ 게시글
- 게시글 작성 / 삭제
- 게시글 조회 (전체 및 카테고리 별 조회)
- 투표하기
- 댓글 작성 및 삭제

### 🎸 기타
- 유저간 팔로우 / 언팔로우

<br>

## 📚 기술 스택
### 1) User Interface
- UIKit / Code Base / SnapKit / Compositional Layout / Flow Layout / Toast

### 2) Network
- Alamofire / Codable / RequestInterceptor / NWPathMonitor / URLRequestConvertible

### 3) Design Pattern
- MVVM / Singleton / Router / Input-Output

### 4) ETC
- UserDefaults / Property Wrapper / RxSwift / Kingfisher / IQKeyboardManager / Iamport

<br>

## 💬 기술 상세 설명
### 1) User Interface
- `SnapKit`을 활용해 다양한 디바이스에 맞는 Layout 설계

### 2) Network
- 코드의 간소화와 가독성 측면에서 `Alamofire` 사용
- `Codable` 프로토콜을 사용해 JSON 데이터 파싱
- `RequestInterceptor` 프로토콜을 사용한 JWT(JSON Web Token) 갱신 구현
- 실시간 네트워크 감지를 위해 `NWPathMonitor` 사용
- `URLRequestConvertible` 이용한 네트워크 추상화

### 3) Design Pattern
- `MVVM Pattern`으로 View와 비지니스 로직을 분리하여 유지보수성을 높임
- 여러 스레드 간 데이터 공유 목적과 메모리 낭비를 방지하기 위해 `Singleton Pattern` 사용
- `Router Pattern`으로 중복적인 네트워크 코드 제거
- `Input-Output Pattern`으로 코드 가독성 증대

### 4) ETC
- `Property Wrapper`를 활용해 `UserDefaults`의 로직 분리
- `RxSwift`를 사용한 비동기 및 이벤트 기반 처리
- `Iamport` 결제 및 영수증 검증 로직 구현

<br>

## ❗ 핵심 기능

### 1) Alamofire의 RequestInterceptor를 이용한 JWT 갱신

<details>
<summary>adapt 메서드에서 HTTP Header에 accessToken 추가</summary>

   <img width="700" alt="jwt_1" src="https://github.com/olraedev/Uyubudan/assets/109517070/0ea1c5c3-7b09-41f0-b644-320bf8952b1e">

</details>

<br>

<details>
<summary>retry 메서드에서 accessToken 만료 시, 토큰 갱신 API 통신</summary>

   <img width="700" alt="jwt_2" src="https://github.com/olraedev/Uyubudan/assets/109517070/543583f4-fa43-45eb-894a-4b21f2563a21">

</details>

### 2) URLRequestConvertible + Router 를 이용한 네트워크 추상화

<details>
<summary>HTTP baseURL, method, header 등 초기값을 URLReqestConvertible로 캡슐화 하여 값을 전달</summary>

   <img width="700" alt="router_1" src="https://github.com/olraedev/Uyubudan/assets/109517070/d2453533-6a5e-472d-8b14-64ffc24cca50"> 
   
   <img width="700" alt="router_2" src="https://github.com/olraedev/Uyubudan/assets/109517070/9da553b5-e903-4ead-b95a-2779e9d6b788">

</details>

<br>

<details>
<summary>API 별 Router 분리</summary>

   <img width="700" alt="router_3" src="https://github.com/olraedev/Uyubudan/assets/109517070/99c68953-2446-4e3c-983f-2d56f081d536">
   
   <img width="700" alt="router_4" src="https://github.com/olraedev/Uyubudan/assets/109517070/a2073d4e-6b37-49e3-acfe-092466b9fe1f">

</details>

### 3) Property Wrapper를 사용한 로직 분리

<details>
<summary>프로퍼티가 저장되는 방식을 관리하는 로직과 프로퍼티를 정의하는 로직 분리 하여 코드의 재사용성을 높임</summary>

<img width="700" alt="wrapper" src="https://github.com/olraedev/Uyubudan/assets/109517070/b16a13fc-4ebb-461b-8dd5-f49f7c45a1d8">

</details>

<br>

## 😵‍💫 트러블 슈팅

### 1) Optimistic UI 적용
```
Optimistic UI란❓
특정 요청이 성공 할 것이라 가정을 하고 먼저 그 요청의 결과를 보여주는 방식의 UI입니다.
```

#### A. 적용 전 흐름

1. 투표 (좋아요) 진행 시, 서버에 좋아요 혹은 좋아요 취소 API 요청
2. 전체 포스트를 불러와 사용자에게 투표 결과 반영

#### B. Optimistic UI 적용 후

1. 투표 (좋아요) 진행 시, API 요청이 성공 할 것이라는 것을 가정 후 사용자에게 투표 결과를 반영
2. 서버에 좋아요 혹은 좋아요 취소 API 요청
3. 사용자가 다른 탭에서 피드 탭으로 이동 시, 혹은 새로고침을 진행 할 때 최신 포스트 데이터를 불러옴

| <img src="https://github.com/olraedev/Uyubudan/assets/109517070/828332f8-615e-4d2e-b74f-a898068a05f1" width="200" height="400"/> | <img src="https://github.com/olraedev/Uyubudan/assets/109517070/4aa22a8f-a49f-4293-9287-4786322b6ab8" width="200" height="400"/> |
|:----------:|:----------:|
| Optimistic UI 적용 전 | Optimistic UI 적용 후 |


### 2) 네트워크 모니터링

#### A. 기존 구현 방식
1. BaseViewController의 viewDidLoad 시점에 네트워크 상황에 따른 분기 처리를 통해 UI 처리
2. 네트워크 단절 시, NetworkFailedView 보여주기

#### B. 기존 구현 방식의 단점
1. 최상단의 뷰가 NetworkFailedView 인지 아닌지 판단하는 로직 필요
2. BaseViewController를 상속 받지 않는 ViewController에서는 어떻게 처리하지..?

#### C. 해결 방안
`현재 window 보다 높은 windowLevel을 설정한 UIWindow로 해결할 수 없을까??`

#### D. 구현
1. SceneDelegate에서 새로운 window 선언

   <img width="300" alt="Monitor_1" src="https://github.com/olraedev/Uyubudan/assets/109517070/570317c7-ae6f-4691-a10f-e79899844a5b">

1. 네트워크 상황에 따른 메서드 생성
    - 네트워크 단절
        1. errorWindow를 makeKeyAndVisible 설정
        2. 네트워크 단절 시 보여질 view가 더해진 errorWindow를 기존 윈도우 위에 뜨움
    
            <img width="620" alt="monitor_2" src="https://github.com/olraedev/Uyubudan/assets/109517070/570895a6-a1d3-42cd-a5ae-2ab44fad7b1e">
    
    - 네트워크 정상
        1. 윈도우 해제, hidden, nil 처리
    
            <img width="359" alt="monitor_3" src="https://github.com/olraedev/Uyubudan/assets/109517070/6e7b3a9e-ed96-44c3-8521-4e8b495d20dc">
    

#### E. 장점

- 최상단 뷰가 어떤 뷰인지 확인 하는 로직이 필요가 없어짐
- 모든 viewController에서 네트워크 모니터링이 가능

   <img src="https://github.com/olraedev/Uyubudan/assets/109517070/e1319bea-c879-402b-9696-035061253045" width="200" height="400"/>

<br>

## 🖥️ 화면별 동작

### 1) 회원 가입
| <img src="https://github.com/olraedev/Uyubudan/assets/109517070/f97c86fb-f51c-4cb6-8b7c-99fd86e2dd2c" width="200" height="400"/> | <img src="https://github.com/olraedev/Uyubudan/assets/109517070/2ffb869f-6fa1-47f8-b970-5793675b966d" width="200" height="400"/> | <img src="https://github.com/olraedev/Uyubudan/assets/109517070/4466a360-0b0e-469e-a658-86f5c9d3ca98" width="200" height="400"/> |
|:----------:|:----------:|:----------:|
| 이메일 | 비밀번호 | 닉네임 |

<br>

### 2) 포스트 작성
| <img src="https://github.com/olraedev/Uyubudan/assets/109517070/dd1413f8-84fa-40f2-8266-4a6aeef38304" width="200" height="400"/> | <img src="https://github.com/olraedev/Uyubudan/assets/109517070/f344428f-c6ec-4f37-907d-266d2df169ae" width="200" height="400"/> | <img src="https://github.com/olraedev/Uyubudan/assets/109517070/999ddbdb-a938-47c7-b7b4-91899638ec6e" width="200" height="400"/> | <img src="https://github.com/olraedev/Uyubudan/assets/109517070/70d6bc72-8fdb-4945-9f13-74b3defe351d" width="200" height="400"/> |
|:----------:|:----------:|:----------:|:----------:|
| 카테고리 | 제목 및 내용 | 이미지 업로드 | 고민 작성 |

<br>

### 3) 피드
| <img src="https://github.com/olraedev/Uyubudan/assets/109517070/abaad550-abba-45b3-bfd0-ffaa64aa5e9e" width="200" height="400"/> | <img src="https://github.com/olraedev/Uyubudan/assets/109517070/234bc939-85cc-4eeb-888b-b636c6db557e" width="200" height="400"/> | <img src="https://github.com/olraedev/Uyubudan/assets/109517070/5b948dbc-351c-481b-bbc6-8ada553f7dfb" width="200" height="400"/> | <img src="https://github.com/olraedev/Uyubudan/assets/109517070/8d787e37-be76-4528-a63a-f926014bed81" width="200" height="400"/> |
|:----------:|:----------:|:----------:|:----------:|
| 카테고리 | 투표 | 새로고침 | 팔로우 |

<br>

### 4) 댓글
| <img src="https://github.com/olraedev/Uyubudan/assets/109517070/65c5a45f-fe1b-443b-ab8e-f7cd0f40f28a" width="200" height="400"/> | <img src="https://github.com/olraedev/Uyubudan/assets/109517070/8a34aac2-52a3-4ba7-8fca-09a6ee540043" width="200" height="400"/> |
|:----------:|:----------:|
| 작성 | 삭제 |

<br>

### 5) 프로필
| <img src="https://github.com/olraedev/Uyubudan/assets/109517070/93b3f920-d19b-4685-ae71-fc59a44c76b4" width="200" height="400"/> | <img src="https://github.com/olraedev/Uyubudan/assets/109517070/1732d1a2-b0d0-45c7-96c0-c8a8346b7b92" width="200" height="400"/> | <img src="https://github.com/olraedev/Uyubudan/assets/109517070/f2f79280-2c0b-4593-970b-ada8743275d7" width="200" height="400"/> |
|:----------:|:----------:|:----------:|
| 메인 | 수정 | 팔로우 |
