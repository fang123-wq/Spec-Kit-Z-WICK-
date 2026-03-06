# Godot 小游戏记忆文档（速记版）

## 1. 脚本文件位置
- `D:\project\教材\catch_game.gd`

## 2. 正确挂载方式
1. 新建场景，根节点用 `Node2D`（不要用 `Node`）。
2. 选中根节点，点击“附加脚本”。
3. 选择已有脚本：`catch_game.gd`。
4. 运行时优先按 `F6`（运行当前场景）。

## 3. 游戏操作
- `←` / `→`：移动挡板
- 接住小球：加分
- 漏球：扣生命
- `Enter`：游戏结束后重开

## 4. 常见报错与修复
- `Script inherits from native type 'Node2D', so it can't be assigned to an object of type: 'Node'`
  - 原因：脚本是 `Node2D`，却挂在 `Node` 上。
  - 修复：把节点改成 `Node2D`。
- 顶层缩进报错
  - 修复：确保 `extends Node2D`、`var ...` 顶格写，只有 `func` 内部缩进。
- 背景遮挡小球
  - 修复：背景 `Z Index = -100`，游戏根节点 `Z Index = 10`。

## 5. 编辑器设置（避免粘贴乱缩进）
- 中文界面路径：`编辑器 -> 编辑器设置`
- 搜索 `缩进` / `粘贴`
- 关闭“粘贴时自动缩进 / 自动缩进”相关选项
