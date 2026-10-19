# Деплой Docker-образов с помощью Ansible

[![hexlet-check](https://github.com/kicha3007-boop/ansible-project-76/actions/workflows/hexlet-check.yml/badge.svg)](https://github.com/kicha3007-boop/ansible-project-76/actions)

Деплой [Redmine](https://hub.docker.com/_/redmine) в Docker на два сервера за балансировщиком Yandex Cloud с Managed PostgreSQL и мониторингом Datadog.

Учебный проект Хекслета: https://ru.hexlet.io/programs/ansible-deploy

## Инфраструктура

- Два сервера Ubuntu (группа `webservers` в `inventory.ini`)
- Application Load Balancer: HTTPS с сертификатом домена, запросы идут на порт `redmine_port` серверов
- Кластер Managed PostgreSQL, доступный только с серверов
- Домен делегирован на DNS облака, A-запись указывает на балансировщик

## Подготовка

```bash
make install                 # роли geerlingguy.pip, geerlingguy.docker, datadog.datadog и коллекция community.docker
echo 'пароль' > .vault_pass  # пароль от group_vars/webservers/vault.yml, в репозиторий не попадает
make vault-edit              # пароль БД, SECRET_KEY_BASE, ключ Datadog
```

Адреса серверов указываются в `inventory.ini`, адрес БД и прочие настройки — в `group_vars/webservers/vars.yml`.

## Использование

```bash
make prepare     # pip, Docker SDK и Docker на серверах
make deploy      # запуск контейнера Redmine с .env из шаблона, без изменения настроек серверов
make monitoring  # агент Datadog с http_check Redmine
make lint        # ansible-lint
```

Порт приложения задаётся переменной `redmine_port`.

<details>
<summary>Автоматические тесты Хекслета</summary>

Тесты запускаются на каждый коммит. За запуск отвечает файл `.github/workflows/hexlet-check.yml` — не удаляйте и не переименовывайте ни его, ни репозиторий.

</details>
