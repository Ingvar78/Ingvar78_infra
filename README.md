# Ingvar78_infra
Ingvar78 Infra repository

[![Build Status](https://travis-ci.com/Otus-DevOps-2020-05/Ingvar78_infra.svg?branch=master)](https://travis-ci.com/Otus-DevOps-2020-05/Ingvar78_infra)

[![Play-travis Status](https://img.shields.io/travis/Otus-DevOps-2020-05/Ingvar78_infra/play-travis?label=Play-travis&style=plastic)](https://github.com/Otus-DevOps-2020-05/Ingvar78_infra/tree/play-travis)

[![Cloud-bastion Status](https://img.shields.io/travis/Otus-DevOps-2020-05/Ingvar78_infra/cloud-bastion?label=Cloud-bastion&style=plastic)](https://github.com/Otus-DevOps-2020-05/Ingvar78_infra/tree/cloud-bastion)
[![Сloud-testapp Status](https://img.shields.io/travis/Otus-DevOps-2020-05/Ingvar78_infra/cloud-testapp?label=Сloud-testapp&style=plastic)](https://github.com/Otus-DevOps-2020-05/Ingvar78_infra/tree/cloud-testapp)

[![Packer-base Status](https://img.shields.io/travis/Otus-DevOps-2020-05/Ingvar78_infra/packer-base?label=Packer-base&style=plastic)](https://github.com/Otus-DevOps-2020-05/Ingvar78_infra/tree/packer-base)

[![Terraform-1 Status](https://img.shields.io/travis/Otus-DevOps-2020-05/Ingvar78_infra/terraform-1?label=Terraform-1&style=plastic)](https://github.com/Otus-DevOps-2020-05/Ingvar78_infra/tree/terraform-1)
[![Terraform-2 Status](https://img.shields.io/travis/Otus-DevOps-2020-05/Ingvar78_infra/terraform-2?label=Terraform-2&style=plastic)](https://github.com/Otus-DevOps-2020-05/Ingvar78_infra/tree/terraform-2)


[![Ansible-1 Status](https://img.shields.io/travis/Otus-DevOps-2020-05/Ingvar78_infra/ansible-1?label=Ansible-1&style=plastic)](https://github.com/Otus-DevOps-2020-05/Ingvar78_infra/tree/ansible-1)
[![Ansible-2 Status](https://img.shields.io/travis/Otus-DevOps-2020-05/Ingvar78_infra/ansible-2?label=Ansible-2&style=plastic)](https://github.com/Otus-DevOps-2020-05/Ingvar78_infra/tree/ansible-2)
[![Ansible-3 Status](https://img.shields.io/travis/Otus-DevOps-2020-05/Ingvar78_infra/ansible-3?label=Ansible-3&style=plastic)](https://github.com/Otus-DevOps-2020-05/Ingvar78_infra/tree/ansible-3)
[![Ansible-4 Status](https://img.shields.io/travis/Otus-DevOps-2020-05/Ingvar78_infra/ansible-4?label=Ansible-4&style=plastic)](https://github.com/Otus-DevOps-2020-05/Ingvar78_infra/tree/ansible-4)


<h1> 5. ДЗ Знакомство с облачной инфраструктурой. Yandex.Cloud </h1>

```
bastion_IP = 84.201.157.40
someinternalhost_IP = 10.130.0.21
testapp_IP = 84.201.130.72
testapp_port = 9292
```

<h2> 5.1 Самостоятельное задание </h2>
способ подключение к `someinternalhost` одной командой

опции ssh: -A пробрасывает авторизацию на удалённый сервер. -J - Jumphost, -l - login_name, -i - identity_file

[проброс по SSH](https://itsecforu.ru/2018/11/29/%D0%BA%D0%B0%D0%BA-%D0%BF%D0%BE%D0%BB%D1%83%D1%87%D0%B8%D1%82%D1%8C-%D0%B4%D0%BE%D1%81%D1%82%D1%83%D0%BF-%D0%BA-%D1%83%D0%B4%D0%B0%D0%BB%D0%B5%D0%BD%D0%BD%D0%BE%D0%BC%D1%83-%D1%81%D0%B5%D1%80%D0%B2/)

```
ssh -J appuser@<bastion_IP> appuser@<someinternalhost_IP>
**OR**
ssh -i ~/.ssh/appuser -A -J appuser@<bastion_IP> appuser@<someinternalhost_IP>
**OR**
ssh -l appuser -A -J appuser@<bastion_IP> <someinternalhost_IP>
```
подключение по hostname путем настройки .ssh/config ProxyCommand
```
Host someinternalhost
     HostName 10.130.0.21
     User appuser
     ProxyCommand ssh -W %h:%p appuser@84.201.157.40
```

<h2> 5.2 Создаем VPN-сервер для серверов Yandex.Cloud </h2>

На хосте **bastion** установлен и настроен VPN-сервер Pritunl.
```
Для подключения по vpn через GUI необходимо скачать файл конфигурации пользователя - *cloud-bastion.ovpn* и выполнить импорт конфигурации (запросит логин\пароль).

Pritunl имеет встроенную интеграцию с Let's encrypt.
Для использования валидного сертификата необходимо в настройках Pritunl "Lets Encrypt Domain" указать соответсвующий URL.
Сертификат сгенерируется автоматически на стороне сервиса sslip.io и привяжется к FQDN.
```
Lets Encrypt Domain ``https://84-201-157-40.sslip.io/``

<h1> 6. Основные сервисы Yandex Cloud </h1>

```
yc compute instance create \
  --name reddit-app1 \
  --hostname reddit-app1 \
  --memory=4 \
  --create-boot-disk image-folder-id=standard-images,image-family=ubuntu-1604-lts,size=10GB \
  --network-interface subnet-name=default-ru-central1-a,nat-ip-version=ipv4 \
  --metadata-from-file user-data=./reddit.yaml
```

<h1> 7. Модели управления инфраструктурой. Подготовка образов с помощью Packer  </h1>
<h2> 7.1 Сборка образов VM при помощи Packer</h2>

Создан шаблон "ubuntu16.json" для создания образа

Добавлены провиженеры rubby и mongodb

Создан образа. В процессе сборки образа  добавлена ("use_ipv4_nat": true), и таймауты запуска скриптов ("pause_before": "60s")

Создан инстанс на основе образа. Выполнен деплой reddit приложения с использованием скрипта из предыдущего задания

<h2> 7.2 Самостоятельные задания </h2> 

Выполнена параметризация шаблона (variables.json)

```
  packer build -var-file=variables.json ./ubuntu16.json
```

<h2> 7.3 Дополнительные задания </h2>

В шаблон добавлены дополнителный "provisioners" для деплоя приложения reddit, cоздан образ на основе базового

Сбокра образа:

```
  packer build -var-file=variables.json ./immutable.json
```

Создан скрипт create-reddit-vm.sh

Проверка работы http://84.201.131.37:9292/


<h1> 8. Практика IaC с использованием Terraform  </h1>

<h2> 8.1 Декларативное описание в виде кода инфраструктуры YC, требуемой для запуска тестового приложения, при помощи Terraform.</h2>

Изучена документация terraform

Определаны input переменные

Отформатированы все файлы через terraform fmt

Создан файл terraform.tfvars.example с примерами переменных

Создан файл lb.tf для **Load Balancer**, через outputs.tf выведены ip адреса инстансов и load balancer

Проверена работоспособность LB с несколькими аппами. Проверена работоспособность LB при выключении сервиса на одном из аппов.

Дополнен main.tf для возможности создавать n инстансов с приложениями, через изменение значения app_instances_count (в текущей конфигурации максимум 3 инстанса минимум 1), для создания большего числа инстансов необходимо внести изменения в outputs.tf

Создание инстансов: 

```
$ terraform apply -auto-approve

....

Apply complete! Resources: 0 added, 1 changed, 0 destroyed.

Outputs:

external_ip_address_app-1 = 130.193.50.49
external_ip_address_app-2 = 130.193.37.100
external_ip_address_app-3 = 130.193.36.65
reddit-balancer-address = [
  "84.201.159.22",
]
```

<h1> 10. Создание Terraform модулей для управления компонентами инфраструктуры. </h1>

Дла новых шаблона db.json и app.json для создания образа ВМ с предустановленными mongodb и ruby

```
packer build -var-file=variables.json ./app.json
packer build -var-file=variables.json ./db.json
```

<h2> 10.1 Модули </h2>

Конфигурация терраформа разбита на модули:
    app - для развертывания приложения
    db - для базы данных
    vpc - для сети

<h2> 10.2 Переиспользование модулей </h2>
Созданы 2 окружения stage и prod, использующие модули db. app и vpc

Для загрузки модулей выполнить: terraform get

Для деплоя необходимо из соответствующей директории (stage или prod) выполнить:

```
$ terraform init
$ terraform plan
$ terraform apply -auto-approve
$ terraform destroy -auto-approve
```
<h2> 10.3 Удалённое хранение стэйта </h2>

Для генерации/просмотра ключей воспользоваться командой

```
yc iam access-key create --service-account-name <name_sa> --description "this key is for my bucket"
yc iam access-key list --service-account-name <name_sa>
```

Добавлен storage-bucket.tf, backend.tf

TODO: Выполнить задания со *

<h1> 11. Управление конфигурацией. Знакомство с Ansible </h1>

Установлен Ansible, изучены базовые функциями и инвентори.

Созданы и настроены файлы конфигурации Ansible:

ansible.cfg - конфигурационный файл

clone.yml - простой плейбук из ДЗ

inventory - статический инвентори

inventory.sh - динамический инвентори с данными из YC

inventory.yml - статический инвентори в формвте YML

inventory_tf.sh динамический инвентори с данными из terraform

requirements.txt - файл для установки ansible

При первом вызове плэйбука происходит изменение хоста (changed=1), при последующих запусках изменений не происходит (changed=0) т.к. шаг уже выполнен.

```
$  ansible-playbook clone.yml
```
при составлении динамического инвентори использовались следующие команды terraform и YC:

 Не проходит тест со * 
```
$ terraform output  external_ip_address_app
$ yc compute instance get reddit-app --format json
```

<h1> 12. Управление настройками хостов и деплой приложения при помощи Ansible. </h1>

<h2> 12.1 Один playbook, один сценарий</h2> 

Использованы плейбуки, хендлеры и шаблоны для конфигурации окружения и деплоя тестового приложения. Подход один плейбук, один сценарий 

reddit_app_one_play.yml

<h2> 12.2 Один плейбук, несколько сценариев / Несколько плейбуков</h2> 

reddit_app_multiple_play.yml

Аналогично один плейбук, но много сценариев и много плейбуков.

Создан основной плейбук site.yml, который включает в себя остальные db.yml, app.yml, deploy.yml

<h2> 12.3 Провижининг в Packer. </h2>

Изменены packer/db.json, packer/app.json - вместо shell/command используем модули ansible: 

packer_db.yml - добавляет репозиторий MongoDB

packer_app.yml - устанавливает Ruby и Bundler

билд образов через пакер:

```
packer validate -var-file=packer/variables.json.example packer/app.json
packer build -var-file=variables.json app.json
packer validate -var-file=packer/variables.json.example packer/db.json
packer build -var-file=variables.json db.json
```

Созданы новые образы reddit-app-base и reddit-db-base из которых развернуто приложение с применением site.yml и динамического inventory.
Backend - работает, в БД сообщения сохраняет.

```
#output "external_ip_address_app" {
#  value = module.app.external_ip_address_app
#}
#output "external_ip_address_db" {
#  value = module.db.external_ip_address_db
#}
# for ansible
output "inventory" {
  value = <<INVENTORY
{ "_meta": {
        "hostvars": { }
    },
  "app": {
    "hosts": ["${module.app.external_ip_address_app}"]
  },
  "db": {
    "hosts": ["${module.db.external_ip_address_db}"],
    "vars": {
        "private_ip": "${module.db.internal_ip_address_db}"
    }
  }
}
    INVENTORY
}
```

Шаблон с динамической переменной из inventory templates/db_config_din.j2:

```
DATABASE_URL={{ hostvars[groups['db'][0]]['private_ip'] }}
```

ansible.cfg с динамическим инвентори:

```
[defaults]
inventory = ./inventory.sh
remote_user = ubuntu
private_key_file = ~/.ssh/ubuntu
host_key_checking = False
retry_files_enabled = False
show_custom_stats = yes
deprecation_warnings=False
```

команда ansible для накатки конфигурации:
ansible-playbook site.yml


<h1> 13. Ansible: работа с ролями и окружениями </h1>

<h1> 13. Ansible: работа с ролями и окружениями </h1>

Изучена работа с  Ansible Galaxy, Vault и инструментами тестрирования.

Изучена работа с ролями.

Перенесены созданные плейбуки в раздельные роли. Описаны два окружения stage и prod	

Использован Ansible Vault для шифрования переменных окружений.

Для проксирования добалена коммьюнити роль nginx.

Добавлен  плейбук для создания пользователей - файл ansible/playbooks/users.yml, создан файл ключа vault_password_file = ~/Documents/Otus/ansible/vault.key - не храниться в репозитории.

Создан файл с данными пользователей credentials.yml для каждого environments stage\prod, произведено шифрование credentials.yml ранее созданный vault.key.

При выове плейбука site.yml будут созданы пользователи в соответствии со списком пользователей в credentials.yml, авторизация по логину/паролю на создаваемых хостах.

Скрипты для динамического inventory: inventory.sh  добавлены в ansible/environments/stage, ansible/environments/prod. переработано создание хостов из terraform, для разделения на stage и prod путём добавления переменной postfix_name и разделения по сетям.

В ansible.cfg добавлено:
```
[defaults]
inventory = ./environments/stage/inventory.sh
```

<h2> ** Настройка TravisCI </h2>

валидаторы ansible, packer, terraform выполняются:
```
./test/packer_validate.sh
./test/ansible_validate.sh
./test/packer_validate.sh

```

в README.md добавлен бейдж со статусом билда

<h1>14. Разработка и тестирование Ansible ролей и плейбуков </h1>

<h2>14.1 Локальная разработка при помощи Vagrant, доработка ролей для провижининга в Vagrant </h2>

<h2>14.2 Тестирование ролей при помощи Molecule и Testinfra </h2>

<h2>14.3 Переключение сбора образов пакером на использование ролей </h2>

<h2>14.4 Результат работы c  molecule</h2>

<pre><font color="#4E9A06">iva@c8hard </font><font color="#CC0000">db (ansible-4 *=) </font><font color="#729FCF"><b>$</b></font><font color="#4E9A06"> molecule create</font>
<font color="#4E9A06">--&gt; </font><font color="#06989A">Test matrix</font>

└── default
    ├── dependency
    ├── create
    └── prepare

--&gt; <font color="#06989A">Scenario: &apos;default&apos;</font>
--&gt; <font color="#06989A">Action: &apos;dependency&apos;</font>
<font color="#C4A000">Skipping, missing the requirements file.</font>
<font color="#C4A000">Skipping, missing the requirements file.</font>
--&gt; <font color="#06989A">Scenario: &apos;default&apos;</font>
--&gt; <font color="#06989A">Action: &apos;create&apos;</font>
<font color="#C4A000">Skipping, instances already created.</font>
--&gt; <font color="#06989A">Scenario: &apos;default&apos;</font>
--&gt; <font color="#06989A">Action: &apos;prepare&apos;</font>
<font color="#C4A000">Skipping, instances already prepared.</font>
<font color="#4E9A06">iva@c8hard </font><font color="#CC0000">db (ansible-4 *=) </font><font color="#729FCF"><b>$</b></font><font color="#4E9A06"> molecule list</font>
<font color="#4E9A06">Instance Name    Driver Name    Provisioner Name    Scenario Name    Created    Converged</font>
<font color="#4E9A06">---------------  -------------  ------------------  ---------------  ---------  -----------</font>
<font color="#4E9A06">instance         vagrant        ansible             default          true       true</font>
</pre>

<pre><font color="#4E9A06">molecule converge</font>
<font color="#4E9A06">--&gt; </font><font color="#06989A">Test matrix</font>

└── default
    ├── dependency
    ├── create
    ├── prepare
    └── converge

--&gt; <font color="#06989A">Scenario: &apos;default&apos;</font>
--&gt; <font color="#06989A">Action: &apos;dependency&apos;</font>
<font color="#C4A000">Skipping, missing the requirements file.</font>
<font color="#C4A000">Skipping, missing the requirements file.</font>
--&gt; <font color="#06989A">Scenario: &apos;default&apos;</font>
--&gt; <font color="#06989A">Action: &apos;create&apos;</font>
<font color="#C4A000">Skipping, instances already created.</font>
--&gt; <font color="#06989A">Scenario: &apos;default&apos;</font>
--&gt; <font color="#06989A">Action: &apos;prepare&apos;</font>
<font color="#C4A000">Skipping, instances already prepared.</font>
--&gt; <font color="#06989A">Scenario: &apos;default&apos;</font>
--&gt; <font color="#06989A">Action: &apos;converge&apos;</font>

    PLAY [Converge] ****************************************************************

    TASK [Gathering Facts] *********************************************************
    <font color="#4E9A06">ok: [instance]</font>

    TASK [Include db] **************************************************************

    TASK [db : Show info about the env this host belongs to] ***********************
    <font color="#4E9A06">ok: [instance] =&gt; {</font>
    <font color="#4E9A06">    &quot;msg&quot;: &quot;This host is in local environment!!!&quot;</font>
    <font color="#4E9A06">}</font>

    TASK [db : Upgrade apt packages] ***********************************************
    <font color="#C4A000">changed: [instance]</font>

    TASK [db : Add key from the URL] ***********************************************
    <font color="#C4A000">changed: [instance]</font>

    TASK [db : Add APT repository] *************************************************
    <font color="#C4A000">changed: [instance]</font>

    TASK [Install mongodb package] *************************************************
    <font color="#C4A000">changed: [instance]</font>

    TASK [db : Configure service supervisor] ***************************************
    <font color="#C4A000">changed: [instance]</font>

    TASK [db : Change mongo config file] *******************************************
    <font color="#C4A000">changed: [instance]</font>

    RUNNING HANDLER [db : restart mongod] ******************************************
    <font color="#C4A000">changed: [instance]</font>

    PLAY RECAP *********************************************************************
    <font color="#C4A000">instance</font>                   : <font color="#4E9A06">ok=9   </font> <font color="#C4A000">changed=7   </font> unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
</pre>
