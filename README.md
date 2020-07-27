# alexbee732_infra
alexbee732 Infra repository

# Данные для проверки
bastion_IP = 84.201.134.111
someinternalhost_IP = 10.130.0.32

# Подключение одной командой к someinternalhost
ssh -i ~/.ssh/appuser -J appuser@84.201.134.111 appuser@10.130.0.32

# Подключение командой ssh someinternalhost
# Добавляем настройки хостов в ~/.ssh/config
Host someinternalhost
    HostName 10.130.0.32
    User appuser
    ProxyJump bastion

Host bastion
    HostName 84.201.134.111
    User appuser
    IdentityFile ~/.ssh/appuser

# Данные для проверки ДЗ №6
testapp_IP = 84.201.133.47
testapp_port = 9292

# ДЗ №7 Packer
Сделаны packer скрипты для создания двух видов образов: с установленным окружением и с установленным приложением reddit-app
См. packer/ubuntu16.json и packer/immutable.json
Написан скрипт для автоматического создания vm на базе полного образа

Как запустить проект:
packer build -var-file=variables.json immutable.json
packer build -var-file=variables.json ubuntu16.json
. create-reddit-vm.sh

# ДЗ №8 Terraform-1
Создана конфигурация terraform для запуска 3-х инстансов + балансировщика нагрузки для reddit-app.
Инфраструктура раскатывается:
terraform apply

# ДЗ №9 Terraform-2
Конфигурация терраформа разбита на модули: app - для развертывания приложения и db - для базы данных
Созданы 2 окружения stage и prod, использующие модули db и app
Дла раскатки инфры нужно из соответствующей папки (stage или prod) вызвать terraform apply
TODO: Выполнить задания со *

# ДЗ №9 Ansible-1
Созданы inventory файлы в двух форматах с описанием групп хостов и хостов
Создан файл конфига ansible.cfg чтобы не прописывать конфиг при вызове ansible вручную
Создан плейбук clone.yml для клонирования git репозитория с помощью модуля git
Тестовые команды:
ansible-playbook clone.yml
ansible db -m systemd -a name=mongod
ansible all -m ping -i inventory.yml
TODO: Выполнить задания со *

# ДЗ №10 Ansible-2
Создан плейбук reddit_app_one_play.yml, для запуска необходимо явно указывать группу хостов и тэги (один сценарий):
ansible-playbook reddit_app_one_play.yml --limit app --tags app-tag (неудобно)

Создан плейбук reddit_app_multiple_plays.yml, для запуска необходимо явно указывать только тэги (несколько сценариев):
ansible-playbook reddit_app_multiple_plays.yml --tags db-tag (удобнее, но можно лучше)

Создана группа плейбуков app.yml, db.yml и deploy.yml, объединенные в плейбуке site.yml, для запуска можно вызвать:
ansible-playbook site.yml (просто и удобно)

В packer provisioners заменены с shell скриптов на ansible плэйбуки ansible/packer_app.yml и ansible/packer_db.yml

TODO: Выполнить задания со *

# ДЗ №11 Ansible-3
Создали роли app и db и перенесли туда код из соответствующих плейбуков
ansible-galaxy init app
ansible-galaxy init db

Структурировали дерево проекта ansible

Добавили внешнюю роль из ansible-galaxy - jdauphant.nginx
ansible-galaxy install -r environments/stage/requirements.yml (предварительно прописали там требования)

Создали окружения prod и stage с разными inventory файлами и переменными в папке group_vars. Прописали в ansible.cfg дефолтный inventory из stage. Для вызова продового окружения нужно явно указать инвентори флагом -i:
ansible-playbook -i environments/prod/inventory playbooks/site.yml

Задействовали хранилище ansible vault с ключем в ~/.ansible/vault.key, прописав в конфиге дефолтный путь до ключа и зашифровав файлы credentials.yml командой
ansible-vault encrypt environments/prod/credentials.yml
