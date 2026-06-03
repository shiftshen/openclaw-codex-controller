# 项目管理与 Codex 协同标准操作程序 (SOP)

> 这是 Main (项目经理) 与 Codex (执行代理) 的标准协同流。
> 它的诞生源于一次“血的教训”：当 Agent 只有执行力而没有强制通信约束时，就会出现执行黑洞。用户不得不用“骂”的方式，才逼出了现在这套强制 4 态通知闭环（`acknowledged`, `in_progress`, `blocked`, `completed`）。

## 核心原则：Main 负责管理，Codex 负责干活

所有项目必须遵循以下流水线，严禁倒置：

### 第一步：立项与登记 (Main 负责)
1. 所有的项目（无论大小）第一步必须录入 SQLite 数据库 (`projects.db`)，明确 `name`, `theme`, `status`。
2. Main 负责维护状态大盘，确保不会因为项目增多而遗失追踪。

### 第二步：初始打包与上云 (Main 负责)
1. 除非是纯空项目，如果本地已有业务逻辑、草稿或旧版 SKILL.md，**必须由 Main 先行打包初始版本**。
2. Main 负责在本地 `git init`，并完成第一次 `git push` 到 GitHub。确保代码在云端有备份，避免丢失。

### 第三步：委派开发 (Main 负责派发)
1. 初始版本上云后，Main 撰写精确的 `task-xxx.md` 任务卡。
2. 任务卡必须包含强制的 `progress_report.py` 通知要求（必须要求 Codex 自己上报进度）。
3. 任务卡还必须明确：`acknowledged` 不等于 `in_progress`。如果看不到结构化进度，Main 必须继续检查 repo 活跃度（如 `git status`、最近修改文件、输出物）再判断是否真的没开始。

### 第四步：开发与优化 (Codex 负责)
1. Codex 获取任务，在本地（或从 GitHub 拉取更新）进行开发、代码优化、文档重写。
2. Codex 必须遵循 **Agent 通信契约**：
   - 动手前发 `in_progress`。
   - 遇到沙箱或环境拦截，发 `blocked`。
   - 完工后发 `completed`。
   *没有通信闭环的执行，视为不合格。*
3. Codex 是**外部技术员工**，不负责业务员工总控。业务员工卡住时应先升级给 Main；只有技术修复/项目开发问题才交给 Codex。

### 第五步：结项闭环 (Main 负责)
1. Codex 开发完成后，如果因沙箱权限无法提交（如 `.git` 拦截），Main 负责接管最后的 `git push`。
2. Main 将数据库 `projects.db` 中的状态更新为 `completed`。
3. 如果没有收到结构化进度，Main 不能只看 receipt 就判断“未工作”；必须补查 repo 活跃度与产物证据，再决定是 `in_progress`、`blocked` 还是 worker 失效。
