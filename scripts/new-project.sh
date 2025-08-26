#!/bin/bash

# Скрипт создания нового проекта из шаблона

set -e

if [ "$#" -lt 1 ]; then
    echo "Использование: $0 PROJECT_NAME [DOMAIN] [WEB_SERVER]"
    echo "Пример: $0 myshop myshop.local nginx"
    exit 1
fi

PROJECT_NAME=$1
PROJECT_DOMAIN=${2:-${PROJECT_NAME}.local}
WEB_SERVER=${3:-apache}

echo "🚀 Создание нового проекта: $PROJECT_NAME"
echo "======================================"

# Проверяем что мы в правильной директории
if [ ! -d "projects/project-template" ]; then
    echo "❌ Ошибка: выполните скрипт из корневой папки docker-multi-project"
    exit 1
fi

# Проверяем что проект не существует
if [ -d "projects/$PROJECT_NAME" ]; then
    echo "❌ Ошибка: проект $PROJECT_NAME уже существует!"
    exit 1
fi

# Копируем шаблон
echo "📁 Копирование шаблона..."
cp -r projects/project-template projects/$PROJECT_NAME

# Настраиваем .env файл проекта
echo "⚙️ Настройка конфигурации..."
cd projects/$PROJECT_NAME

# Используем разные команды для MacOS и Linux
if [[ "$OSTYPE" == "darwin"* ]]; then
    # macOS
    sed -i '' "s/PROJECT_NAME=project1/PROJECT_NAME=$PROJECT_NAME/" .env
    sed -i '' "s/PROJECT_DOMAIN=project1.local/PROJECT_DOMAIN=$PROJECT_DOMAIN/" .env
    sed -i '' "s/WEB_SERVER=apache/WEB_SERVER=$WEB_SERVER/" .env
    sed -i '' "s/project1_db/${PROJECT_NAME}_db/" .env
    sed -i '' "s/project1_user/${PROJECT_NAME}_user/" .env
    sed -i '' "s/project1_password_2024/${PROJECT_NAME}_password_2024/" .env
    sed -i '' "s/PROJECT_DOMAINS_EXTRA=www.project1.local,api.project1.local/PROJECT_DOMAINS_EXTRA=www.$PROJECT_DOMAIN,api.$PROJECT_DOMAIN/" .env
else
    # Linux
    sed -i "s/PROJECT_NAME=project1/PROJECT_NAME=$PROJECT_NAME/" .env
    sed -i "s/PROJECT_DOMAIN=project1.local/PROJECT_DOMAIN=$PROJECT_DOMAIN/" .env
    sed -i "s/WEB_SERVER=apache/WEB_SERVER=$WEB_SERVER/" .env
    sed -i "s/project1_db/${PROJECT_NAME}_db/" .env
    sed -i "s/project1_user/${PROJECT_NAME}_user/" .env
    sed -i "s/project1_password_2024/${PROJECT_NAME}_password_2024/" .env
    sed -i "s/PROJECT_DOMAINS_EXTRA=www.project1.local,api.project1.local/PROJECT_DOMAINS_EXTRA=www.$PROJECT_DOMAIN,api.$PROJECT_DOMAIN/" .env
fi

echo "✅ Проект $PROJECT_NAME создан!"
echo ""
echo "📋 Следующие шаги:"
echo "1. 🌐 Настройте hosts файл:"
echo "   echo '127.0.0.1 $PROJECT_DOMAIN' | sudo tee -a /etc/hosts"
echo "   echo '127.0.0.1 www.$PROJECT_DOMAIN' | sudo tee -a /etc/hosts"
echo ""
echo "2. 🚀 Запустите проект:"
echo "   cd projects/$PROJECT_NAME"
echo "   make init"
echo ""
echo "3. 🌍 Откройте в браузере:"
echo "   https://$PROJECT_DOMAIN"
echo ""
echo "🎯 Проект готов к разработке!"
