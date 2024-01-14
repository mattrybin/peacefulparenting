.PHONY: setup setup-environment setup-hosts setup-ssl setup-packages dev

MENU_SETUP_SCRIPT = devops/scripts/menu-setup.sh
MENU_GIT_SCRIPT = devops/scripts/menu-git.sh
MENU_SCRIPT = devops/scripts/menu.sh

default: menu
menu:
	@bash $(MENU_SCRIPT)
git:
	@bash $(MENU_GIT_SCRIPT)
setup:
	@bash $(MENU_SETUP_SCRIPT)



SETUP_ENVIRONMENT_SCRIPT = devops/scripts/setup-environment.bash
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
GIT_CHECKOUT_PR_SCRIPT = devops/scripts/git-checkout-pr.sh
GIT_MERGE_PR_SCRIPT = devops/scripts/git-merge-pr.sh
GIT_COMMIT_SCRIPT = devops/scripts/git-commit.sh
ASK_FOR_HELP = devops/scripts/ask-for-help.sh
ASK_FOR_REVIEW = devops/scripts/ask-for-review.sh
GO_NOTION_TICKET = devops/scripts/go-notion-ticket.sh

git-new:
	@bash $(GIT_NEW_FEATURE_SCRIPT)

git-checkout:
	@bash $(GIT_CHECKOUT_PR_SCRIPT)


TESTING = devops/scripts/notion-check.sh
testing:
	@bash $(TESTING)

	# @bash $(GIT_CHECKOUT_PR_SCRIPT)

commit-to-pr:
	@bash $(GIT_COMMIT_SCRIPT)

merge-pr:
	@bash $(GIT_MERGE_PR_SCRIPT)

ask-for-help:
	@bash $(ASK_FOR_HELP)

ask-for-review:
	@bash $(ASK_FOR_REVIEW)

go-github-pr:
	@bash $(GO_GITHUB_PR)

go-notion-ticket:
	@bash $(GO_NOTION_TICKET)