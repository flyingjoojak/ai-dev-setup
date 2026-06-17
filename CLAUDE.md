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
| **spec-kit** | 기능 구현 전 스펙 3종 문서 자동 생성 (spec / plan / tasks) |
| **dev-flow** | specify → plan → tasks → TDD → ECC → full-review 6단계 워크플로우 |
| **full-review** | 코드·보안·DB·silent-failure·성능·a11y·contract-consistency 7종 리뷰어 병렬 실행 |
| **contract-consistency** | 프론트↔백엔드 API 계약 일치 전담 리뷰어 (양쪽 동시 변경 시 자동 활성화) |

## 사용법

설치 후 Claude Code에서:

```
/dev-flow 회원가입 기능 만들어줘
```
→ 6단계 진행. 매 단계 완료 시 `⏸ GATE [STEP N]` 출력 후 승인 대기.
→ "진행해" / "다음" / "OK" 입력해야 다음 단계로 이동.

```
/full-review
```
→ 최근 변경된 파일 자동 감지 후 7종 리뷰 리포트 출력.
→ 프론트+백엔드 동시 변경이면 contract-consistency 자동 활성화.
