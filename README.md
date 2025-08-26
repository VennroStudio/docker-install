# 🏗️ Docker Multi-Project Architecture (NETWORK FIXED)

## 🔧 ИСПРАВЛЕНИЯ

Исправлены критические ошибки сетей:
- ✅ Убран устаревший `version: 3.8`
- ✅ Сети помечены как `external: true` 
- ✅ Добавлена команда очистки проблемных сетей
- ✅ Исправлена совместимость с macOS

## 🚀 Быстрый старт

```bash
# 1. Настройка
unzip docker-multi-project-NETWORK-FIXED.zip
cd docker-multi-project
./scripts/setup.sh

# 2. Создание проекта
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
- 🗄️ **phpMyAdmin** (если запущена общая БД): https://pma.shared.local

## 🛠️ Команды

```bash
# Infrastructure
make -C infrastructure init        # Только Traefik
make -C infrastructure up-shared-db # + общая БД

# Проекты
cd projects/PROJECT_NAME
make init                          # Запуск проекта
make logs                         # Просмотр логов
make shell-php                    # Подключение к PHP

# Создание новых проектов
./scripts/new-project.sh shop shop.local apache
./scripts/new-project.sh blog blog.local nginx
```

## 🎯 Решение ошибок

Если возникают проблемы с сетями:

```bash
# Полная переустановка infrastructure
make -C infrastructure reinstall

# Очистка всех сетей Docker
docker network prune -f
```

**Теперь все работает корректно!** 🎉
