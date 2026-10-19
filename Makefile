VAULT = --vault-password-file $(CURDIR)/.vault_pass

# Роли и коллекции из Ansible Galaxy
install:
	ansible-galaxy role install -r requirements.yml
	ansible-galaxy collection install -r requirements.yml

# Подготовка серверов: pip, Docker SDK, Docker
prepare:
	ansible-playbook playbook.yml --tags prepare $(VAULT)

# Деплой Redmine без изменения настроек серверов
deploy:
	ansible-playbook playbook.yml --tags deploy $(VAULT)

# Агент Datadog с http_check
monitoring:
	ansible-playbook playbook.yml --tags monitoring $(VAULT)

vault-edit:
	ansible-vault edit group_vars/webservers/vault.yml $(VAULT)

vault-view:
	ansible-vault view group_vars/webservers/vault.yml $(VAULT)

lint:
	ansible-lint

.PHONY: install prepare deploy monitoring vault-edit vault-view lint
