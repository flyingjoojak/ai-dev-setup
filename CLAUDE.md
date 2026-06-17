# ai-dev-setup

이 저장소는 Claude Code에 dev-flow & full-review 워크플로우를 설치하는 도구입니다.

## 설치

아직 설치가 안 됐다면 즉시 아래를 실행해 주세요:

```bash
chmod +x setup.sh && ./setup.sh
```

## 설치되는 항목

| 도구 | 역할 |
|------|------|
| **ECC** | AI 코딩 규칙 자동 주입 (코드 품질 기준선) |
| **spec-kit** | 기능 구현 전 스펙 문서 자동 생성 |
| **dev-flow** | spec → TDD → ECC → full-review 4단계 워크플로우 |
| **full-review** | 코드·보안·DB·성능·a11y 6종 리뷰어 병렬 실행 |

## 사용법

설치 후 Claude Code에서:

```
/dev-flow 회원가입 기능 만들어줘
```
→ 각 단계(spec / TDD / 구현 / 리뷰)마다 사용자 승인 후 진행

```
/full-review
```
→ 최근 변경된 파일 자동 감지 후 6종 리뷰 리포트 출력
