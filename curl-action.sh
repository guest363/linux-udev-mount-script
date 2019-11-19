#!/bin/bash
#Имя хоста берем из команды hostname которая в свою очередь смотрит /etc/hostname
machineID=$(hostname)
#В списке запущенных процессов ищем парметр xfreerdp где передается имя пользователя при соединении
# 1- Отсекаем все /u:... 2- Берем последний со значением и 3 - Оставляем только фамилию
FREERD=$(ps aux | grep -o "\/u\:[[:upper:]][[:lower:]]*" | sed -n "/\:[a-z]*/{p;q;}" | grep -o [^\/u\:].* )
#Из вывода оставляем только последнее значение после двоеточия
NameF=$FREERD
#Аналогично для rdescktop
RDESCKTOP=$(ps aux | grep --only-matching "/\-u[[:space:]][[:upper:]][[:lower:]]*" | sed -n "/[[:space:]][a-z]*/{p;q;}")
NameR=${RDESCKTOP##*u}
RealName=""
#Если не нашлось процесса xfreerdp то присваивается значение из rdescktop, которое так же может
#ровняться нулю если пользователь еще не подключился к серверу 
#При этом символ < должен быть экранирован
if [ "$NameF"  \< " " ]
then
RealName=$NameR
else
RealName=$NameF
fi
#Передача POST запроса на сервер, имя до curl указывается абсолютное, при этом результат запроса
#записывается в переменную
action=$(/writable/var/mountScripts/curl-bin/curl --noproxy "*" -d "product=${PRODUCT_USB}&manufacture=${MANUFACTURE_USB}&serial=${SERIAL_USB}&hostid=$machineID&event=mount&username=$RealName" "${SERVER_URL}")
#Действия в зависимости от полученного ответа с сервера
if [ $action = "true" ]
then
echo "Вставленна легитимная flash"
else
#shutdown now
fi
exit 0