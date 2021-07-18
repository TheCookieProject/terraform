## InfluxDB 

Despliga una base de datos, un volumen de 10G en donde almacena las metricas, luego se extiende el volumen a través de terraform.

### Herramientas

* telegraf 
* grafana 
* docker 


### Configuración

utilizar playbook: 

* influxdb.yaml
* telegraf.yaml
* docker.yaml 

```
git clone https://github.com/thecookieproject/ansible.git 
cd 03-influxdb
ansible-playbook influxdb.yaml 
...

cd 01-base 
cd ../01-base 
ansible-playbook base_telegraf.yaml 

```

### Visualización

Grafana: public_ip:3000 

dashboards ID: 

### Extender el volumen

Editar main.tf de 10G a 15G 

`terraform plan` para comprobar y luego `terraform apply`

```
ansible -a "resize2fs /dev/sda" [grupo_do]
ansible -a "df -h" [group_do]

 ```

:wq!
