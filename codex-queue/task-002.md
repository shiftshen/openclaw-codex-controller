verdict: done
goal: Codex 控制器二次开发完善 (AI项目经理与防漂移体系)
repo/path: /Users/shift/openclaw/workspace-xmanx/projects/openclaw-codex-controller
branch: main

## 任务说明

当前是 `openclaw-codex-controller` 的二次开发完善阶段。用户要求强化该技能包的核心灵魂：**让 OpenClaw 成为真正的 AI 项目经理，让 Agent 熟练掌握 Codex 命令，确保目标明确，绝对不发生“漂移”(Drifting)**。

请严格执行以下步骤：

1. **上报状态 (必须先执行)**：
   执行：`python3 /Users/shift/openclaw/workspace-xmanx/scripts/progress_report.py --state in_progress --project openclaw-codex-controller --action "执行二次开发：强化防漂移体系与AI项目经理规范" --checking "重写 SKILL.md 与 README.md" --apply`

2. **核心业务重构**：
   - 深度完善 `SKILL.md`（或 `README.md`），明确“AI 项目经理”的定义（由 Main 负责数据库登记、代码打包、发号施令，Codex 负责沙箱内干活）。
   - 增加**防漂移 (Anti-Drift) 准则**：强制单次任务锁定单一目标，严格控制修改范围，禁止发散，做到“指哪打哪”。
   - 提供一份完整的 **Codex 命令使用大全与避坑指南**，让后续调用的 Agent 都能极其熟练地使用 Codex 的模式（如 `--ephemeral`, `-C`, `--add-dir` 等）。

3. **收尾说明**：
   - 因为沙箱限制，不要执行 `git commit` 或 `git push`（Main 稍后会接管提交）。
   - 完工后必须执行：
     `python3 /Users/shift/openclaw/workspace-xmanx/scripts/progress_report.py --state completed --project openclaw-codex-controller --action "二次开发完善结束，防漂移体系与命令大全已写入文档" --checking "等待 Main 提交至 GitHub 主线" --apply`
   - 将本文件上方改为 `verdict: done`。
