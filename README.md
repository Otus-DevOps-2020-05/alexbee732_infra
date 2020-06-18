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
