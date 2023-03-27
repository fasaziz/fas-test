$namespace_name = "fastest"
$namespace_secrets = az aks command invoke --command "kubectl get secrets --namespace $namespace_name" --resource-group cot-k8s-playground --name cot-k8s-playground
$count = $namespace_secrets.count
$secret_name = "appsettings"
foreach ($c in 0..$count) {
    $line = $namespace_secrets[$c]
    Write-Host "checking line $c"
    Write-Verbose "checking $line"
    if ($line -match $secret_name) {
        Write-verbose "Found $secret_name in $line"
        $exists = $true 
        break      
    }
    else {
        Write-verbose "didn't find $namespace_name in $line"
        $exists = $false
    }
}
if ($exists -eq $true) {
    Write-Host "Found $secret_name"
    $found = "true"
}
else {
    write-host "Didn't find $secret_name"
    $found = "false"
}
Write-host ##vso[task.setvariable variable=appsettingsExists]$found
