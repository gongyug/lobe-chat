#!/bin/bash
set -e

echo "🚂 Railway 单服务部署脚本"
echo "================================"
echo ""

# 步骤1: 创建新项目
echo "📦 步骤1: 创建Railway项目..."
railway init
echo "✅ 项目创建成功"
echo ""

# 步骤2: 链接GitHub仓库
echo "🔗 步骤2: 链接GitHub仓库..."
railway link
echo "✅ 仓库链接成功"
echo ""

# 步骤3: 设置环境变量
echo "⚙️  步骤3: 设置环境变量..."

# 必需的环境变量
railway variables set SKIP_ENV_VALIDATION=1
echo "  ✓ SKIP_ENV_VALIDATION=1"

# 提示用户输入其他环境变量
echo ""
echo "请输入你的配置（可以直接回车跳过）："
echo ""

read -p "APP_URL (例如: https://your-app.railway.app): " APP_URL
if [ ! -z "$APP_URL" ]; then
    railway variables set APP_URL="$APP_URL"
    echo "  ✓ APP_URL 已设置"
fi

read -p "DATABASE_URL: " DATABASE_URL
if [ ! -z "$DATABASE_URL" ]; then
    railway variables set DATABASE_URL="$DATABASE_URL"
    echo "  ✓ DATABASE_URL 已设置"
fi

read -p "KEY_VAULTS_SECRET: " KEY_VAULTS_SECRET
if [ ! -z "$KEY_VAULTS_SECRET" ]; then
    railway variables set KEY_VAULTS_SECRET="$KEY_VAULTS_SECRET"
    echo "  ✓ KEY_VAULTS_SECRET 已设置"
fi

read -p "OPENAI_API_KEY: " OPENAI_API_KEY
if [ ! -z "$OPENAI_API_KEY" ]; then
    railway variables set OPENAI_API_KEY="$OPENAI_API_KEY"
    echo "  ✓ OPENAI_API_KEY 已设置"
fi

read -p "NEXT_PUBLIC_SERVICE_MODE (server/browser): " SERVICE_MODE
if [ ! -z "$SERVICE_MODE" ]; then
    railway variables set NEXT_PUBLIC_SERVICE_MODE="$SERVICE_MODE"
    echo "  ✓ NEXT_PUBLIC_SERVICE_MODE 已设置"
fi

echo ""
echo "✅ 环境变量设置完成"
echo ""

# 步骤4: 部署
echo "🚀 步骤4: 开始部署..."
railway up
echo ""
echo "✅ 部署完成！"
echo ""

# 显示部署信息
echo "📊 项目信息："
railway status

echo ""
echo "🎉 完成！访问 Railway Dashboard 查看部署状态"
echo "   https://railway.app/dashboard"
