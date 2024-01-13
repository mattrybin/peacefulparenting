.PHONY: setup setup-environment setup-hosts setup-ssl setup-packages dev

# Define your scripts with variable in order to have a consistent format
MENU_SETUP_SCRIPT = devops/scripts/menu-setup.sh
SETUP_ENVIRONMENT_SCRIPT = devops/scripts/setup-environment.bash

setup:
	@bash $(MENU_SETUP_SCRIPT)

setup-environment:
	@bash $(SETUP_ENVIRONMENT_SCRIPT)

setup-hosts:
	@echo "Setting up local development domains..."
	@echo "127.0.0.1 frontend.peacefulparenting.local" | sudo tee -a /etc/hosts
	@echo "127.0.0.1 admin.peacefulparenting.local" | sudo tee -a /etc/hosts
	@echo "127.0.0.1 backend.peacefulparenting.local" | sudo tee -a /etc/hosts

setup-ssl:
	@echo "Generating a self-signed SSL certificate..."
	@mkdir -p devops/cert
	@openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout devops/cert/selfsigned.key -out devops/cert/selfsigned.crt -subj "/C=PL/ST=krakow/L=krakow/O=mattrybin/OU=peacefulparenting/CN=peacefulparenting/emailAddress=contact@mattrybin.com"

setup-packages:
	@echo "Setting up packages"
	@cd ./admin && pnpm install
	@cd ./backend && go get ./...
	@cd ./frontend && pnpm install

dev:
	@docker-compose --env-file development.database.env up --build

GIT_NEW_FEATURE_SCRIPT = devops/scripts/git-new-feature.sh

git-new-feature:
	@bash $(GIT_NEW_FEATURE_SCRIPT)