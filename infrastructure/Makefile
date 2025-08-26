include .env
export

.PHONY: help init up down restart logs

# Помощь
help:
	@echo "🏗️ Infrastructure - общие сервисы для всех проектов"
	@echo "================================================="
	@echo ""
	@echo "🚀 Основные команды:"
	@echo "  make init              - Инициализация инфраструктуры"
	@echo "  make up                - Запуск всех общих сервисов"
	@echo "  make down              - Остановка всех сервисов"
	@echo "  make restart           - Перезапуск"
	@echo "  make logs              - Просмотр логов"
	@echo ""
	@echo "🔧 Профили сервисов:" 
	@echo "  make up-traefik        - Только Traefik"
	@echo "  make up-shared-db      - Traefik + общая БД + phpMyAdmin"
	@echo "  make up-full           - Все сервисы (БД, Redis, MailHog)"
	@echo ""
	@echo "💡 Доступные URL:"
	@echo "  http://localhost:$(TRAEFIK_DASHBOARD_PORT)  - Traefik Dashboard"
	@echo "  https://pma.shared.local        - phpMyAdmin (если запущена общая БД)"
	@echo "  https://mail.local              - MailHog (если запущен)"

# Инициализация
init: clean-networks networks up-traefik up-shared-db info

# Создание внешних сетей
networks:
	@echo "🌐 Создание внешних Docker сетей..."
	@echo "🧹 Очистка существующих сетей..."
	-docker network rm traefik-public 2>/dev/null || true
	-docker network rm shared-services 2>/dev/null || true
	@echo "🔨 Создание новых сетей..."
	docker network create traefik-public
	docker network create shared-services
	@echo "✅ Сети созданы успешно"

# Очистка проблемных сетей
clean-networks:
	@echo "🧹 Очистка проблемных сетей..."
	-docker network rm traefik-public 2>/dev/null || true
	-docker network rm shared-services 2>/dev/null || true

# Основные команды
up: up-traefik
down:
	docker compose -f infrastructure.yml down --remove-orphans

restart: down up
logs:
	docker compose -f infrastructure.yml logs -f

# Профили запуска
up-traefik:
	@echo "🌐 Запуск Traefik..."
	docker compose -f infrastructure.yml up -d traefik

up-shared-db:
	@echo "🗄️ Запуск Traefik + общая БД + phpMyAdmin..."
	COMPOSE_PROFILES=shared-db docker compose -f infrastructure.yml up -d

up-full:
	@echo "🚀 Запуск всех сервисов..."
	COMPOSE_PROFILES=shared-db,shared-cache,mailhog docker compose -f infrastructure.yml up -d

# Информация
info:
	@echo ""
	@echo "✅ Infrastructure готова!"
	@echo "======================="
	@echo "🌐 Traefik Dashboard: http://localhost:$(TRAEFIK_DASHBOARD_PORT)"
	@echo "📊 Статус сетей:"
	@docker network ls | grep -E "(traefik-public|shared-services)" || echo "   Сети не найдены"
	@echo ""
	@echo "💡 Следующие шаги:"
	@echo "   1. Создайте проекты: ../scripts/new-project.sh PROJECT_NAME DOMAIN"
	@echo "   2. Настройте hosts файл для доменов проектов"
	@echo "   3. Запустите проекты: make -C ../projects/PROJECT_NAME up"

# Управление сетями
list-networks:
	@echo "🌐 Список Docker сетей:"
	@docker network ls | grep -E "(NAME|traefik-public|shared-services|project)"

# Мониторинг
status:
	@echo "📊 Статус инфраструктуры:"
	@docker compose -f infrastructure.yml ps
	@echo ""
	@echo "🌐 Активные сети:"
	@docker network ls | grep -E "(traefik-public|shared-services)"

# Полная переустановка
reinstall: clean-networks down networks up-traefik
	@echo "🔄 Infrastructure переустановлена"
