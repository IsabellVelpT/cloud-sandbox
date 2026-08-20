Write-Host "=== Cloud Sandbox START ==="

# Docker muss bereits laufen
docker info | Out-Null
if ($LASTEXITCODE -ne 0) {
    Write-Host "FEHLER: Docker Desktop zuerst starten."
    exit 1
}

# Kubernetes starten
minikube start

# Sandbox-Container
$containers = @(
    "localstack",
    "grafana",
    "prometheus",
    "blackbox-exporter",
    "monitoring-web",
    "web1",
    "web2",
    "loadbalancer",
    "cicd-demo"
)

foreach ($container in $containers) {
    $exists = docker ps -aq --filter "name=^${container}$"

    if ($exists) {
        docker start $container | Out-Null
        Write-Host "$container OK"
    }
    else {
        Write-Host "$container NICHT GEFUNDEN"
    }
}

Write-Host "`n=== STATUS ==="
docker ps

Write-Host "`n=== SANDBOX BEREIT ==="
Write-Host "Grafana: http://localhost:3000"
Write-Host "Prometheus: http://localhost:9090"
Write-Host "Monitoring-Web: http://localhost:8081"
Write-Host "Load Balancer: http://localhost:8082"
Write-Host "CI/CD Demo: http://localhost:8083"
Write-Host "LocalStack: http://localhost:4566"