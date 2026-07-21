<p align="center">
  <img src="assets/SAIPEN_design1.png" alt="SAIPEN Guide Title" width="800"/>
</p>

# SAIPEN 指南 (中文)

听着，新手。问题很简单：你的 AI 代理记忆只有金鱼水平。

**SAIPEN** 就是一个放在项目 `.saipen/` 目录里的硬核笔记本。

## 快速开始

1. **每台机器安装一次:**
```bash
git clone https://github.com/vacterro/saipen
cd saipen
powershell -ExecutionPolicy Bypass -File .\bootstrap\inject.ps1     # Windows
bash bootstrap/inject.sh                                            # macOS / Linux
```

2. **在项目中启动:**
> `saipen set`

3. **工作:**
> `saipen`

## 命令

| 命令 | 操作 |
|---|---|
| `saipen set` | 初始化记忆文件夹 `.saipen/` |
| `saipen continue` | 从笔记恢复工作 |
| `saipen stop` | 保存进度并停止 |
| `saipen status` | 读取看板和状态 |
| `saipen goal <text>` | 转向新目标 |
| `saipen clean` | 深度清理仓库 |
| `saipen translate` | 隔离的22种语言翻译构建 |
| `saipen ship` | 触发发布流程 |
