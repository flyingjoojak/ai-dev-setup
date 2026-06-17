#!/bin/bash
set -e

echo "🚀 ai-dev-setup 설치 시작..."
echo ""

# 1. ECC 설치
echo "📐 [1/4] ECC 설치 중..."
if [ -d "$HOME/.claude/rules/ecc" ]; then
  echo "  → ECC 이미 설치됨, 스킵"
else
  git clone https://github.com/eastcoastcoder/ecc "$HOME/.claude/rules/ecc"
  echo "  ✅ ECC 설치 완료"
fi

# 2. spec-kit 설치
echo "📋 [2/4] spec-kit 설치 중..."
if command -v specify &> /dev/null; then
  echo "  → specify 이미 설치됨, 스킵"
else
  npm install -g spec-kit
  echo "  ✅ spec-kit 설치 완료"
fi

# 3. dev-flow 스킬 설치
echo "🔄 [3/4] dev-flow 스킬 설치 중..."
mkdir -p "$HOME/.claude/skills/dev-flow"
cp "$(dirname "$0")/skills/dev-flow/SKILL.md" "$HOME/.claude/skills/dev-flow/SKILL.md"
echo "  ✅ dev-flow 설치 완료"

# 4. full-review 스킬 설치
echo "🔍 [4/4] full-review 스킬 설치 중..."
mkdir -p "$HOME/.claude/skills/full-review"
cp "$(dirname "$0")/skills/full-review/SKILL.md" "$HOME/.claude/skills/full-review/SKILL.md"
echo "  ✅ full-review 설치 완료"

echo ""
echo "✅ 설치 완료! Claude Code에서 바로 사용 가능합니다."
echo ""
echo "사용법:"
echo "  /dev-flow [기능명]   — spec → TDD → ECC → full-review 자동 진행"
echo "  /full-review         — 현재 변경분 6종 리뷰"
