#!/bin/bash
set -e

echo "🚀 ai-dev-setup 설치 시작..."
echo ""

# 1. ECC 설치
echo "📐 [1/3] ECC 설치 중..."
if [ -d "$HOME/.claude/rules/ecc" ]; then
  echo "  → ECC 이미 설치됨, 스킵"
else
  git clone https://github.com/flyingjoojak/ecc "$HOME/.claude/rules/ecc"
  echo "  ✅ ECC 설치 완료"
fi

# 2. spec-kit 설치
echo "📋 [2/3] spec-kit 설치 중..."
if command -v specify &> /dev/null; then
  echo "  → specify 이미 설치됨, 스킵"
else
  npm install -g spec-kit
  echo "  ✅ spec-kit 설치 완료"
fi

# 3~4. dev-flow / full-review 스킬 설치 — claude-skills 저장소(private)에서 받아온다.
# 스킬 원본은 이 레포가 아니라 https://github.com/flyingjoojak/claude-skills 에서 관리한다
# (다른 스킬들과 함께 한곳에 모아둠). private 저장소라 clone 하려면 flyingjoojak 계정으로
# 인증돼 있어야 한다(gh auth login 등).
echo "🔄 [3/3] dev-flow · full-review 스킬 설치 중..."
_tmp_skills="$(mktemp -d)"
git clone --depth 1 https://github.com/flyingjoojak/claude-skills "$_tmp_skills" -q
mkdir -p "$HOME/.claude/skills/dev-flow" "$HOME/.claude/skills/full-review"
cp "$_tmp_skills/skills/dev-flow/SKILL.md" "$HOME/.claude/skills/dev-flow/SKILL.md"
cp "$_tmp_skills/skills/full-review/SKILL.md" "$HOME/.claude/skills/full-review/SKILL.md"
rm -rf "$_tmp_skills"
echo "  ✅ dev-flow · full-review 설치 완료"

echo ""
echo "✅ 설치 완료! Claude Code에서 바로 사용 가능합니다."
echo ""
echo "사용법:"
echo "  /dev-flow [기능명]   — spec → TDD → ECC → full-review 자동 진행"
echo "  /full-review         — 현재 변경분 6종 리뷰"
