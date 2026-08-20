Write-Host "=== Cloud Sandbox STOP ==="

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
    $running = docker ps -q --filter "name=^${container}$"

    if ($running) {
        docker stop $container | Out-Null
        Write-Host "$container gestoppt"
    }
}

Write-Host "`nMinikube wird gestoppt..."
minikube stop

Write-Host "`n=== SANDBOX GESTOPPT ==="