# Recommended Skills

This package expects the following global skills to be available on the target
machine under the host global skill catalog before synchronization:

- Windows typical path: `C:\Users\<user>\.agents\skills`
- macOS typical path: `~/.agents/skills`

Recommended skills:

- `feishu-doc-1.2.7`
- `feishu-drive-1.0.0`
- `feishu-perm`
- `feishu-chat-history`
- `feishu-send-file`
- `search`
- `tavily`
- `agent-reach`
- `autoglm-browser-agent`
- `docx`
- `pdf`
- `nano-pdf`
- `web-scraping`
- `clawdefender-1`

The repository does not vendor all third-party skill contents. Instead,
`sync-required-skills.ps1` copies any available recommended skills from the host
global skill catalog into:

```text
~/.openclaw/domains/legal-opc/workspace/skills/shared
```
