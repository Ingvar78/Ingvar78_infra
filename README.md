# Ingvar78_infra
Ingvar78 Infra repository

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

<h1> 6. Основные сервисы Yandex Cloud
