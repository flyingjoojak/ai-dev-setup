# ai-dev-setup

Claude Code에 **dev-flow & full-review** 워크플로우를 원클릭으로 설치합니다.

## 무엇을 설치하나요?

```
specify → plan → tasks → TDD → ECC → full-review
스펙 작성  구현 계획  태스크 분해  테스트 먼저  코딩 규칙  AI 7명 검토
```

| 도구 | 설명 |
|------|------|
| **ECC** | Claude Code에 코딩 규칙 자동 주입. 매번 말 안 해도 보안·품질 기준 적용 |
| **spec-kit** | AI가 역질문 → `.spec.md` / `.plan.md` / `.tasks.md` 3종 기획 문서 자동 완성 |
| **dev-flow** | 6단계 워크플로우. 각 단계마다 `⏸ GATE` 형식으로 반드시 사용자 승인 후 진행 |
| **full-review** | 코드·보안·DB·silent-failure·성능·a11y·**contract-consistency** 7개 에이전트 동시 검토 |

## 설치

```bash
git clone https://github.com/flyingjoojak/ai-dev-setup
cd ai-dev-setup
chmod +x setup.sh && ./setup.sh
```

## 사용법

```bash
# 새 기능 개발 시작
/dev-flow 기능명

# 코드 리뷰 (PR 전)
/full-review
```

## 요구사항

- [Claude Code](https://claude.ai/code) 설치
- Node.js (spec-kit 설치용)
- Git
