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
