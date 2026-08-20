Write-Host "=== CLOUD SANDBOX STATUS ==="

Write-Host "`n--- Docker Container ---"
docker ps --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}"

Write-Host "`n--- Kubernetes / Minikube ---"
minikube status

Write-Host "`n--- Kubernetes Pods ---"
kubectl get pods -A

Write-Host "`n--- Erreichbarkeit ---"

$services = @{
    "Load Balancer" = "http://localhost:8082"
    "Grafana" = "http://localhost:3000"
    "Monitoring-Web" = "http://localhost:8081"
    "CI/CD Demo" = "http://localhost:8083"
    "Prometheus" = "http://localhost:9090"
    "LocalStack" = "http://localhost:4566/_localstack/health"
}

foreach ($service in $services.GetEnumerator()) {
    try {
        $response = Invoke-WebRequest -Uri $service.Value -UseBasicParsing -TimeoutSec 3
        Write-Host "$($service.Key): OK ($($response.StatusCode))"
    }
    catch {
        Write-Host "$($service.Key): NICHT ERREICHBAR"
    }
}

Write-Host "`n=== STATUS CHECK FERTIG ==="