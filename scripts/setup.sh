#!/bin/bash

set -e

echo "🏗️ Настройка Docker Multi-Project Architecture"
echo "=============================================="

# Проверяем что Docker работает
if ! command -v docker &> /dev/null; then
    echo "❌ Docker не установлен!"
    exit 1
fi

if ! docker info &> /dev/null; then
    echo "❌ Docker не запущен!"
    exit 1
fi

echo "✅ Docker готов"

# Переходим в папку infrastructure
cd infrastructure

echo "🔧 Исправление проблемных сетей..."
make clean-networks

echo "🌐 Инициализация infrastructure..."
make init

echo ""
echo "✅ Настройка завершена!"
echo "======================="
echo ""
echo "📋 Что дальше:"
echo "1. 🚀 Создайте первый проект:"
echo "   ./scripts/new-project.sh myproject myproject.local nginx"
echo ""
echo "2. 📊 Traefik Dashboard:"
echo "   http://localhost:8080"
echo ""
echo "3. 🗄️ Для запуска общей БД:"
echo "   make -C infrastructure up-shared-db"
echo "   echo '127.0.0.1 pma.shared.local' | sudo tee -a /etc/hosts"
echo "   https://pma.shared.local"
echo ""
echo "4. 📚 Читайте README.md для подробностей"
echo ""
echo "🎉 Multi-Project архитектура готова!"
