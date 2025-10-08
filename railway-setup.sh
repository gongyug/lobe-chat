#!/bin/bash
# Railway CLI setup script - Deploy as SINGLE service

# 安装 Railway CLI (如果没有)
# npm i -g @railway/cli

# 初始化项目
railway init

# 链接到GitHub仓库
railway link

# 创建单个服务
railway service create lobe-chat

# 设置环境变量
railway variables set SKIP_ENV_VALIDATION=1
railway variables set APP_URL=https://your-app.railway.app

# 部署
railway up
