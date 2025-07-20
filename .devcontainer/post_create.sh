#!/bin/bash
set -e

echo "🔧 Corrigiendo permisos persistentes para Jenkins y asegurando usuario arheanja..."

sudo chown -R jenkins:jenkins /var/lib/jenkins /var/log/jenkins /var/cache/jenkins || true
sudo chmod -R 755 /var/lib/jenkins /var/log/jenkins /var/cache/jenkins || true

echo "Iniciando Jenkins como servicio en segundo plano..."
sudo service jenkins start

sleep 3
sudo service jenkins status || true

echo "Jenkins arrancado en http://localhost:8081"
echo "Clave inicial: sudo cat /var/lib/jenkins/secrets/initialAdminPassword"
