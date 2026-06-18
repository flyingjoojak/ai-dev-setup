# Obsidian × Claude Code 연동 설치 가이드

> **이 문서를 Claude Code에 던져주는 방법:**
> ```
> 이 링크의 지침서대로 Obsidian을 설치하고 Claude와 연동해줘:
> https://raw.githubusercontent.com/flyingjoojak/ai-dev-setup/master/docs/obsidian-claude-setup.md
> ```
> Claude가 이 문서를 읽고 순서대로 안내합니다.

---

## 이 가이드로 완성되는 것

```
Obsidian (로컬 노트 앱)
    ↕ Smart Connections MCP
Claude Code (AI 에이전트)
```

- Claude가 옵시디언 노트를 **읽고** 답변 (시맨틱 검색)
- Claude가 옵시디언 노트를 **직접 작성** (회의록, 일지 등)
- 일간·주간 노트로 할 일·한 일 자동 관리

---

## 사전 요구사항

- macOS (Windows는 경로만 다르게 적용)
- [Claude Code](https://claude.ai/code) 설치됨
- Node.js 18+ 설치됨 (`node --version`으로 확인)
- Git 설치됨

---

## STEP 1 · Obsidian 설치

1. [https://obsidian.md](https://obsidian.md) → Download 클릭
2. 설치 후 실행
3. **새 볼트 만들기** 선택
   - 볼트 이름: `second_brain` (또는 원하는 이름)
   - 위치: `~/Desktop/second_brain` 권장
4. 볼트 경로를 메모해두기 (이후 설정에 사용)
   ```
   내 볼트 경로: /Users/[사용자명]/Desktop/second_brain
   ```

---

## STEP 2 · 볼트 폴더 구조 생성

Obsidian 안에서 아래 폴더를 생성한다. (좌측 사이드바 → 우클릭 → 새 폴더)

```
second_brain/
├── 01_Journals/
│   ├── Daily/
│   ├── Weekly/
│   └── Monthly/
├── 02_Projects/
│   └── Active/
├── 03_Areas/
├── 04_Resources/
└── 05_Archive/
```

> **PARA 구조**: Projects(진행 중) / Areas(지속 관리) / Resources(참고) / Archive(완료)

---

## STEP 3 · 핵심 플러그인 설치

Obsidian 설정(⚙️) → 커뮤니티 플러그인 → 커뮤니티 플러그인 검색

아래 플러그인을 순서대로 설치 + 활성화:

### 3-1. Smart Connections (필수 — Claude 연동 핵심)
- 검색: `Smart Connections`
- 설치 → 활성화
- **설정 → Smart Connections → 볼트 인덱싱 시작** 클릭
- 완료되면 `.smart-env/` 폴더가 볼트에 생성됨 (정상)

### 3-2. Periodic Notes (일간·주간·월간 노트)
- 검색: `Periodic Notes`
- 설치 → 활성화
- 설정:
  - Daily Notes: 활성화 / 경로 `01_Journals/Daily/` / 형식 `YYYY-MM-DD`
  - Weekly Notes: 활성화 / 경로 `01_Journals/Weekly/` / 형식 `YYYY-[W]WW`

### 3-3. Templater (노트 템플릿)
- 검색: `Templater`
- 설치 → 활성화
- 설정 → Template folder: `Templates` (볼트 루트에 Templates 폴더 생성)

### 3-4. Dataview (선택)
- 검색: `Dataview`
- 설치 → 활성화
- JavaScript queries 활성화

---

## STEP 4 · 노트 템플릿 생성

볼트 루트에 `Templates/` 폴더를 만들고 아래 파일을 생성한다.

### Templates/daily.md
```markdown
---
date: <% tp.date.now("YYYY-MM-DD") %>
day: <% tp.date.now("dddd") %>
week: "[[<% tp.date.now("YYYY-[W]WW") %>]]"
tags: [journal/daily]
---

# <% tp.date.now("YYYY-MM-DD (ddd)") %>

## 📆 오늘 일정
- 

## ✅ 오늘 할 일
- [ ] 

## 📝 오늘 한 일
- 

## 💡 메모 & 생각
> 

## 🔗 관련 노트
- 
```

### Templates/weekly.md
```markdown
---
week: "<% tp.date.now("YYYY-[W]WW") %>"
month: "[[<% tp.date.now("YYYY-MM") %>]]"
period: "<% tp.date.now("YYYY-MM-DD", 0, "week", "monday") %> ~ <% tp.date.now("YYYY-MM-DD", 6, "week", "monday") %>"
tags: [journal/weekly]
---

# <% tp.date.now("YYYY-[W]WW") %> 주간 리뷰

## 📆 이번 주 정기 미팅
- 

## 🎯 이번 주 목표
- [ ] 

## ✅ 완료한 것
- 

## ❌ 못한 것 & 이유
- 

## 📚 이번 주 배운 것
- 

## 🔮 다음 주 계획
- [ ] 

## 💬 한 줄 회고
> 
```

---

## STEP 5 · Smart Connections MCP 설치

Smart Connections 플러그인과 Claude Code를 연결하는 MCP 서버를 설치한다.

```bash
# 1. MCP 서버 클론
git clone https://github.com/brianpetro/smart-connections-mcp ~/smart-connections-mcp

# 2. 의존성 설치 및 빌드
cd ~/smart-connections-mcp
npm install
npm run build

# 3. 빌드 확인
ls dist/index.js  # 파일이 있으면 정상
```

---

## STEP 6 · Claude Code MCP 설정

Claude Code 프로젝트 루트(또는 `~/.mcp.json`)에 설정 추가:

```bash
# 설정 파일 열기 (프로젝트 루트 기준)
cat > .mcp.json << 'EOF'
{
  "mcpServers": {
    "smart-connections": {
      "command": "node",
      "args": [
        "/Users/[사용자명]/smart-connections-mcp/dist/index.js"
      ],
      "env": {
        "SMART_VAULT_PATH": "/Users/[사용자명]/Desktop/second_brain"
      }
    }
  }
}
EOF
```

> **[사용자명]** 부분을 실제 macOS 사용자명으로 변경 (`whoami` 명령으로 확인)

```bash
whoami  # 사용자명 확인
```

---

## STEP 7 · Claude Code 재시작 및 연결 확인

1. Claude Code 완전 종료
2. 재시작
3. 새 대화에서 아래 테스트 실행:

```
옵시디언 볼트에서 최근 노트를 검색해줘
```

Claude가 볼트 내용을 읽어서 답변하면 연동 성공.

---

## STEP 8 · 동작 테스트

### 8-1. 노트 읽기 테스트
```
내 옵시디언에서 [검색어]와 관련된 노트를 찾아줘
```

### 8-2. 노트 쓰기 테스트
```
오늘 일지를 옵시디언에 작성해줘. 오늘 한 일: 옵시디언 Claude 연동 설정 완료
```
→ `01_Journals/Daily/YYYY-MM-DD.md` 파일이 생성·수정되면 성공

### 8-3. 주간 할 일 관리 테스트
```
이번 주 할 일 목록을 만들어줘:
- [ ] 프로젝트 A 기획
- [ ] 미팅 준비
```
→ `01_Journals/Weekly/YYYY-WWW.md`에 반영되면 성공

---

## STEP 9 · 주간 할 일 알림 자동화 (선택)

매일 아침 오전 7시에 이번 주 할 일·한 일을 Discord로 받고 싶다면:

### 9-1. 스크립트 생성

```bash
mkdir -p ~/ai-agent/scripts
cat > ~/ai-agent/scripts/obsidian-discord.js << 'SCRIPT'
#!/usr/bin/env node
'use strict';
const fs = require('fs');
const path = require('path');
const https = require('https');

const VAULT = '/Users/[사용자명]/Desktop/second_brain';
const DISCORD_TOKEN = process.env.DISCORD_TOKEN;
const CHANNEL_ID = process.env.DISCORD_CHANNEL_ID;
const WEEKLY_DIR = path.join(VAULT, '01_Journals', 'Weekly');

function getISOWeek(date) {
  const d = new Date(date);
  d.setHours(0, 0, 0, 0);
  d.setDate(d.getDate() + 3 - (d.getDay() + 6) % 7);
  const week1 = new Date(d.getFullYear(), 0, 4);
  return 1 + Math.round(((d - week1) / 86400000 - 3 + (week1.getDay() + 6) % 7) / 7);
}

const today = new Date();
const year = today.getFullYear();
const week = String(getISOWeek(today)).padStart(2, '0');
const weekFile = path.join(WEEKLY_DIR, `${year}-W${week}.md`);

const doneTasks = [];
const todoTasks = [];
if (fs.existsSync(weekFile)) {
  for (const line of fs.readFileSync(weekFile, 'utf8').split('\n')) {
    if (/^\s*- \[x\]/i.test(line)) {
      const task = line.replace(/^\s*- \[x\]\s*/i, '').replace(/✅.*$/, '').trim();
      if (task) doneTasks.push(task);
    } else if (/^\s*- \[ \]/.test(line)) {
      const task = line.replace(/^\s*- \[ \]\s*/, '').trim();
      if (task) todoTasks.push(task);
    }
  }
}

const days = ['일','월','화','수','목','금','토'];
const dateStr = `${today.getMonth()+1}월 ${today.getDate()}일(${days[today.getDay()]})`;

let msg = `📅 **${dateStr} 금주 할 일 & 한 일**\n\n`;

if (doneTasks.length === 0) {
  msg += `✅ **완료한 일** — 없음\n\n`;
} else {
  msg += `✅ **완료한 일** (${doneTasks.length}개)\n`;
  doneTasks.forEach(t => { msg += `• ${t}\n`; });
  msg += '\n';
}

if (todoTasks.length === 0) {
  msg += `📋 **이번 주 할 일** — 없음 🎉`;
} else {
  msg += `📋 **이번 주 할 일** (${todoTasks.length}개)\n`;
  todoTasks.forEach(t => { msg += `• ${t}\n`; });
}

const payload = JSON.stringify({ content: msg.trim() });
const req = https.request({
  hostname: 'discord.com',
  path: `/api/v10/channels/${CHANNEL_ID}/messages`,
  method: 'POST',
  headers: {
    'Authorization': `Bot ${DISCORD_TOKEN}`,
    'Content-Type': 'application/json',
    'Content-Length': Buffer.byteLength(payload)
  }
}, (res) => {
  let data = '';
  res.on('data', d => data += d);
  res.on('end', () => {
    const parsed = JSON.parse(data);
    if (parsed.id) console.log('✅ Discord sent:', parsed.id);
    else console.error('❌ Discord error:', data);
  });
});
req.write(payload);
req.end();
SCRIPT

chmod +x ~/ai-agent/scripts/obsidian-discord.js
```

### 9-2. launchd 등록 (macOS 자동 실행)

```bash
cat > ~/Library/LaunchAgents/io.obsidian.discord.plist << 'PLIST'
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>Label</key>
    <string>io.obsidian.discord</string>
    <key>ProgramArguments</key>
    <array>
        <string>/usr/local/bin/node</string>
        <string>/Users/[사용자명]/ai-agent/scripts/obsidian-discord.js</string>
    </array>
    <key>StartCalendarInterval</key>
    <array>
        <dict><key>Weekday</key><integer>1</integer><key>Hour</key><integer>7</integer><key>Minute</key><integer>0</integer></dict>
        <dict><key>Weekday</key><integer>2</integer><key>Hour</key><integer>7</integer><key>Minute</key><integer>0</integer></dict>
        <dict><key>Weekday</key><integer>3</integer><key>Hour</key><integer>7</integer><key>Minute</key><integer>0</integer></dict>
        <dict><key>Weekday</key><integer>4</integer><key>Hour</key><integer>7</integer><key>Minute</key><integer>0</integer></dict>
        <dict><key>Weekday</key><integer>5</integer><key>Hour</key><integer>7</integer><key>Minute</key><integer>0</integer></dict>
    </array>
    <key>EnvironmentVariables</key>
    <dict>
        <key>DISCORD_TOKEN</key>
        <string>여기에_Discord_Bot_토큰</string>
        <key>DISCORD_CHANNEL_ID</key>
        <string>여기에_채널_ID</string>
        <key>HOME</key>
        <string>/Users/[사용자명]</string>
    </dict>
    <key>StandardOutPath</key>
    <string>/tmp/obsidian-discord.log</string>
    <key>StandardErrorPath</key>
    <string>/tmp/obsidian-discord-error.log</string>
</dict>
</plist>
PLIST

# 등록
launchctl load ~/Library/LaunchAgents/io.obsidian.discord.plist
```

---

## 연동 구조 요약

```
┌─────────────────────────────────────────────┐
│              Obsidian 볼트                    │
│  01_Journals/Daily/     ← 일간 노트          │
│  01_Journals/Weekly/    ← 주간 노트 (할일)   │
│  02_Projects/           ← 프로젝트 노트      │
│  .smart-env/            ← 임베딩 (자동 생성) │
└───────────────────┬─────────────────────────┘
                    │ Smart Connections MCP
                    ↕
┌───────────────────────────────────────────────┐
│              Claude Code                        │
│  - 노트 읽기: search_notes, get_note_content  │
│  - 노트 쓰기: Write 도구로 직접 파일 작성     │
└───────────────────────────────────────────────┘
                    │
        (선택) Discord Bot
                    ↓
┌──────────────────┐
│  Discord 채널     │
│  매일 오전 7시    │
│  주간 할일 알림   │
└──────────────────┘
```

---

## 자주 묻는 문제

### Smart Connections가 볼트를 못 읽는 경우
```bash
# 볼트 경로 확인
ls /Users/[사용자명]/Desktop/second_brain/.smart-env/
# 비어있으면 Obsidian에서 Smart Connections 플러그인 → 인덱싱 재실행
```

### MCP 서버가 연결 안 되는 경우
```bash
# 직접 실행해서 오류 확인
node ~/smart-connections-mcp/dist/index.js
```

### launchd 알림이 안 오는 경우
```bash
# 로그 확인
cat /tmp/obsidian-discord-error.log

# plist 재로드 (타임존 문제 해결)
launchctl unload ~/Library/LaunchAgents/io.obsidian.discord.plist
launchctl load ~/Library/LaunchAgents/io.obsidian.discord.plist
```

---

## 참고

- [Obsidian](https://obsidian.md)
- [Smart Connections Plugin](https://github.com/brianpetro/obsidian-smart-connections)
- [Smart Connections MCP](https://github.com/brianpetro/smart-connections-mcp)
- [ai-dev-setup](https://github.com/flyingjoojak/ai-dev-setup) — dev-flow / full-review 워크플로우
