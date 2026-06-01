verdict: done
goal: 将通讯闭环脚本内置化并更新沙箱规避模板 (AI PM 闭环强化)
repo/path: /Users/shift/openclaw/workspace-xmanx/projects/openclaw-codex-controller
branch: main

## 任务说明

为了让 `openclaw-codex-controller` 真正独立，我们需要把 `progress_report.py` 脚本内置到该技能包中，并把“必须写入本地 reports/ 目录以绕过沙箱”的规范固化到任务模板中。

请执行以下严谨的工作流（这是对你汇报机制的最终测试，绝不许遗漏）：

1. **第一阶段汇报 (开始工作)**：
   必须执行以下命令（注意 `--out-dir reports`）：
   `python3 /Users/shift/openclaw/workspace-xmanx/scripts/progress_report.py --state in_progress --project openclaw-codex-controller --action "正在将通讯脚本打包内置并更新模板" --checking "沙箱绕过机制测试" --out-dir /Users/shift/openclaw/workspace-xmanx/projects/openclaw-codex-controller/reports`

2. **核心代码重构**：
   - 在当前项目里创建 `scripts/` 目录。
   - 把外部的 `/Users/shift/openclaw/workspace-xmanx/scripts/progress_report.py` 复制到当前项目的 `scripts/progress_report.py`。
   - 修改当前项目的 `install.sh`，使其在部署时同时把 `scripts/progress_report.py` 安装到目标环境的脚本目录，方便别的节点调用。
   - 修改 `templates/task-card.md`，在模板里把进度汇报的示例代码改为明确带有 `--out-dir reports/` 参数，指导后续 Agent 如何正确绕过内核沙箱。

3. **最终阶段汇报 (完工)**：
   不要执行 Git 推送，Main 会接管提交。完成代码重构后，必须执行：
   `python3 /Users/shift/openclaw/workspace-xmanx/scripts/progress_report.py --state completed --project openclaw-codex-controller --action "内置化完成，模板已更新" --checking "报告机制测试通过" --out-dir /Users/shift/openclaw/workspace-xmanx/projects/openclaw-codex-controller/reports`
   - 将本任务卡上方改为 `verdict: done`。
