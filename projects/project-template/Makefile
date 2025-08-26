include .env
export

.PHONY: init up down restart logs help

help:
	@echo "🚀 Проект: $(PROJECT_NAME)"
	@echo "========================="
	@echo "  make init              - Инициализация проекта"
	@echo "  make up                - Запуск проекта"  
	@echo "  make down              - Остановка проекта"
	@echo "  make logs              - Просмотр логов"
	@echo "  make shell-php         - Подключение к PHP"

# Инициализация
init: check-infrastructure create-db-if-shared up info

# Проверка infrastructure
check-infrastructure:
	@if ! docker network ls | grep -q "traefik-public"; then \
		echo "❌ Сеть traefik-public не найдена!"; \
		echo "💡 Запустите: make -C ../../infrastructure init"; \
		exit 1; \
	fi

# Создание БД в общей MariaDB
create-db-if-shared:
ifeq ($(USE_SHARED_DB),true)
	@echo "🗄️ Создание БД $(DB_NAME) в общей MariaDB..."
	@docker exec infrastructure-mariadb mysql -u root -p$(SHARED_DB_ROOT_PASSWORD) \
		-e "CREATE DATABASE IF NOT EXISTS $(DB_NAME);" \
		-e "CREATE USER IF NOT EXISTS '$(DB_USER)'@'%' IDENTIFIED BY '$(DB_PASSWORD)';" \
		-e "GRANT ALL PRIVILEGES ON $(DB_NAME).* TO '$(DB_USER)'@'%';" \
		-e "FLUSH PRIVILEGES;" 2>/dev/null || echo "⚠️ БД создастся при запуске infrastructure"
endif

# Запуск проекта
up:
	@echo "🚀 Запуск проекта $(PROJECT_NAME) с $(WEB_SERVER)..."
	COMPOSE_PROFILES=$(WEB_SERVER) docker compose up -d

down:
	docker compose down --remove-orphans

restart: down up
logs:
	docker compose logs -f

shell-php:
	docker exec -it $(PROJECT_NAME)-php-fpm bash

info:
	@echo "✅ Проект $(PROJECT_NAME) запущен!"
	@echo "🌐 URL: https://$(PROJECT_DOMAIN)"
	@echo "🌍 Веб-сервер: $(WEB_SERVER)"
