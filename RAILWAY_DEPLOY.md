# Railway CLI 部署指南 - 单服务模式

## 方式1: 自动化脚本（推荐）

直接运行部署脚本：

```bash
./railway-deploy.sh
```

脚本会引导你完成所有步骤。

---

## 方式2: 手动执行（完全控制）

### 步骤1: 创建新项目

```bash
railway init
```

**交互选项：**
- `Select a workspace`: 选择 `gauneng's Projects`
- `Enter project name`: 输入 `lobe-chat` 或你喜欢的名字
- `Starting point`: 选择 `Empty Project`

### 步骤2: 链接GitHub仓库

```bash
railway link
```

**交互选项：**
- 选择仓库：`gongyug/lobe-chat`
- 选择分支：`main`

### 步骤3: 设置环境变量

```bash
# 必需 - 跳过构建时验证
railway variables set SKIP_ENV_VALIDATION=1

# 必需 - 应用URL（部署后Railway会提供，先设置占位符）
railway variables set APP_URL=https://placeholder.railway.app

# 数据库相关（如果使用）
railway variables set NEXT_PUBLIC_SERVICE_MODE=server
railway variables set DATABASE_URL=your_database_url
railway variables set KEY_VAULTS_SECRET=your_secret_key

# AI服务
railway variables set OPENAI_API_KEY=sk-xxx
# 添加其他需要的API keys
```

### 步骤4: 部署

```bash
railway up
```

这会：
- ✅ 从GitHub拉取代码
- ✅ 使用nixpacks.toml配置构建
- ✅ 部署为**单个服务**
- ✅ 生成部署URL

### 步骤5: 获取部署URL并更新APP_URL

```bash
# 查看部署状态和URL
railway status

# 复制生成的URL，然后更新环境变量
railway variables set APP_URL=https://your-actual-url.railway.app
```

### 步骤6: 重新部署（使用正确的APP_URL）

```bash
railway up
```

---

## 查看部署状态

```bash
# 查看项目状态
railway status

# 查看实时日志
railway logs

# 查看所有环境变量
railway variables

# 打开Railway Dashboard
railway open
```

---

## 常用命令

```bash
# 查看帮助
railway --help

# 查看服务列表
railway service

# 重新部署
railway up

# 删除项目
railway delete

# 登出
railway logout
```

---

## 预期结果

部署成功后，你应该看到：

✅ **Railway Dashboard显示：**
- 1个项目：`lobe-chat`
- 1个服务（主应用）
- 构建状态：Success
- 部署URL：`https://xxx.railway.app`

✅ **访问URL后：**
- 应用正常加载
- 可以使用配置的API keys
- 数据库连接正常（如果配置了）

---

## 故障排查

### 问题1: 构建失败 "Invalid environment variables"

**解决：**
```bash
# 确认已设置
railway variables | grep SKIP_ENV_VALIDATION
# 应该看到：SKIP_ENV_VALIDATION=1
```

### 问题2: 还是创建了多个服务

**原因：** Railway自动检测到monorepo

**解决：**
1. 删除多余服务：进入Dashboard → 删除packages相关的服务
2. 或者重新创建项目，使用本指南的步骤

### 问题3: 运行时无法连接数据库

**解决：**
```bash
# 检查环境变量
railway variables | grep DATABASE_URL

# 如果缺失，添加：
railway variables set DATABASE_URL=postgresql://...
```

---

## 更新部署

代码更新后，Railway会自动部署。也可以手动触发：

```bash
# 提交代码
git add .
git commit -m "update"
git push

# 或者手动触发部署
railway up
```
