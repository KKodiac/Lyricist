# Lyricist

코딩하면서 노래 부를때 유용한 맥OS 앱

맥OS 유투브 뮤직 앱 등에서 음악을 재생하고 메뉴바에서 확인해보세요.

![Screenshot 2023-04-25 at 12 56 22 PM](https://user-images.githubusercontent.com/35219323/234170936-404a9934-2b4d-4213-9e57-0aeec44b1602.png)

### ⚠️This is a work in progress

디버깅을 위해 `fatalError`가 남발되어 있습니다. 

`CFBundle` 에 생성된 앱 자원에서 미디어 자원에 접근하여 내용을 확인합니다.

현재까지 확인된 내용은: 

- 멜론에 요청을 하고 노래 내역이 없으면 발생됩니다.

- 실행되는 음악 컨텐츠가 없으면 발생됩니다. 

## 앱으로 사용하는 방법

### 우선 프로젝트를 클론해주세요. 
```
git clone https://github.com/KKodiac/Lyricist.git
```

### Xcode 를 실행해 메뉴바에서 아래를 참고해주세요.

1. Product - Archive 로 앱 아카이브 생성
  
2. Window - Organizer 로 생성된 아카이브 확인

3. Distribute App - Copy App - 저장할 앱 경로 선택

### 유투브 뮤직 앱 등을 켜서 앱 사용합니다.
