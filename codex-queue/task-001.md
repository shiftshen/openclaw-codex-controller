verdict: done
goal: 开源技能包封装优化 (openclaw-codex-controller)
repo/path: /Users/shift/openclaw/workspace-xmanx/projects/openclaw-codex-controller
branch: main

## 任务说明

当前项目已提取了我们之前的 `codex-controller` 技能，并初始化了 GitHub 仓库。请完成以下开源标准封装工作：

1. **项目自声明**：
   执行 `python3 /Users/shift/openclaw/workspace-xmanx/scripts/progress_report.py --state in_progress --project openclaw-codex-controller --action "开始封装 Codex 控制器技能包" --checking "文档与安装脚本优化" --apply`
   *(注意：不要向不存在的目录或沙箱外写无关数据)*

2. **文档与架构优化**：
   - 编写中英双语的 `README.md`，介绍本技能包的作用（管理 Codex、约束目标模式、设定交付标准）。
   - 创建 `install.sh`：参考之前项目的经验，写一个安装脚本，将 `SKILL.md` 和 `templates/` 安装到目标 `OPENCLAW_WORKSPACE/skills/codex-controller/` 目录下。

3. **收尾工作**：
   - 因为沙箱可能限制修改 `.git/`，本任务**不需要**你执行 `git commit` 或 `git push`。你只需完成所有文件的编写与修改。
   - 完成后，执行：
     `python3 /Users/shift/openclaw/workspace-xmanx/scripts/progress_report.py --state completed --project openclaw-codex-controller --action "文件编写与封装完成" --checking "等待主控节点提交代码" --apply`
   - 将本任务卡首行的状态修改为 `verdict: done`。
