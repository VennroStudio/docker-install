# 🏗️ Docker Multi-Project Architecture

## 🔧 ИСПРАВЛЕНИЯ

Исправлены критические ошибки:
- ✅ Сети помечены как `external: true` 
- ✅ Добавлена команда очистки проблемных сетей
- ✅ Исправлена совместимость с macOS

## 🚀 Быстрый старт

```bash
# 1. Настройка
git clone https://github.com/VennroStudio/docker-install
cd docker-install
chmod +x ./scripts/setup.sh
./scripts/setup.sh

# 2. Создание проекта
chmod +x ./scripts/new-project.sh
./scripts/new-project.sh myproject myproject.local nginx

# 3. Настройка hosts (macOS)
echo "127.0.0.1 myproject.local" | sudo tee -a /etc/hosts

# 4. Запуск
cd projects/myproject  
make init

# 5. Проверка
open https://myproject.local
```

## 🌐 Доступные URL

- 🚀 **Ваш проект**: https://myproject.local
- 📊 **Traefik Dashboard**: http://localhost:8080
- 🗄️ **phpMyAdmin**: https://pma.shared.local

## 🛠️ Команды

```bash
# Проекты
cd projects/PROJECT_NAME
make init                         # Запуск проекта
make up                           # Старт
make down                         # Отключить
make logs                         # Просмотр логов
make shell-php                    # Подключение к PHP

# Создание новых проектов
./scripts/new-project.sh shop shop.local apache
./scripts/new-project.sh blog blog.local nginx
```

