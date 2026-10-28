---
"junchul-skills": patch
---

`wizard` 템플릿 수정: `ask`가 Readline을 써서 화살표 키로 커서가 움직입니다 (#741). `write_env`가 값을 홑따옴표로 감싸서 공백, `#`, `$`, 따옴표가 `source`와 dotenv에서 살아남습니다 (#770). 브라우저 열기 수단이 없으면 `open_url`이 직접 열라는 경고를 출력합니다 (#774). `write_env`가 심볼릭 링크된 `.env`를 통해 쓰고 기존 파일의 모드를 유지합니다 (#811). `ask`와 `ask_secret`이 EOF에서 반복하지 않고 실패합니다 (#852).
