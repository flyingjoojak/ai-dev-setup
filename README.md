# ai-dev-setup

Claude Code에 **dev-flow & full-review** 워크플로우를 원클릭으로 설치합니다.

## 무엇을 설치하나요?

```
spec-kit  →  TDD  →  ECC  →  full-review
요구사항 확정  테스트 먼저  코딩 규칙  AI 6명 검토
```

| 도구 | 설명 |
|------|------|
| **ECC** | Claude Code에 코딩 규칙 자동 주입. 매번 말 안 해도 보안·품질 기준 적용 |
| **spec-kit** | AI가 역질문을 던져 `.spec.md` 기획서 자동 완성. 대화가 길어져도 기획이 유지됨 |
| **dev-flow** | 위 4단계를 순서대로 자동 진행. 각 단계마다 사용자 승인 후 다음으로 이동 |
| **full-review** | 코드·보안·DB·성능·silent-failure·a11y 6개 에이전트가 동시에 코드 검토 |

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
