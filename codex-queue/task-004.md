verdict: done
goal: 补充零 Token 心跳巡检机制说明文档 (task-004)
repo/path: /Users/shift/openclaw/workspace-xmanx/projects/openclaw-codex-controller
branch: main

## 任务说明

当前是技能包的最后一块拼图。由于系统内核沙箱限制，Codex 不能向全局发送报告，只能就地写入 `reports/`。主控端（Main）会使用纯 Python 脚本做文件系统扫描。这一机制需要清晰地写入文档中。

1. **就地汇报 (开始)**：
   执行：`python3 scripts/progress_report.py --state in_progress --project openclaw-codex-controller --action "撰写心跳巡检机制文档" --checking "补充 0 Token 本地扫描架构" --out-dir reports/`

2. **文档更新**：
   - 修改 `README.md` 和 `SKILL.md`。
   - 增加关于 **"心跳巡检与沙箱规避 (Heartbeat & Sandbox Bypass)"** 的专门说明。
   - 强调两点：
     1. Agent 必须使用 `python3 scripts/progress_report.py --out-dir reports/` 将进度落盘在本地，绝对禁止跨域写全局总线。
     2. 这是一个 **0 Token 消耗** 的极速机制。外部守护进程只是普通的 `python` 文件扫描脚本（0 LLM 调用，0 费用，每 3 秒扫一次本地目录）。
   
3. **就地汇报 (完工)**：
   - 执行：`python3 scripts/progress_report.py --state completed --project openclaw-codex-controller --action "心跳巡检机制已完整写入文档" --checking "技能包已100%完善" --out-dir reports/`
   - 将本任务卡上方改为 `verdict: done`。
