[CmdletBinding()]
param (
    [Parameter()]
    [string]
    $namespace_name = "kierantesgt",
    
    [Parameter()]
    [bool]
    $exists = $false
    
)

$namespace_name = "fastest"
$exists = $false

$namespace = az aks command invoke --command "kubectl get namespace" --resource-group cot-k8s-playground --name cot-k8s-playground

$count = $namespace.count

#if ($namespace[6] -match $namespace_name) {write-host"matching line 6"} else {write-host "not matching line 6"}

foreach ($c in 0..$count) {
    $line = $namespace[$c]
    Write-Host "checking line $c"
    Write-Verbose "checking $line"
    if ($line -match $namespace_name) {
        Write-verbose "Found $namespace_name in $line"
        $exists = $true 
        break      
    }
    else {
        Write-verbose "didn't find $namespace_name in $line"
        $exists = $false
    }
}
if ($exists -eq $true) {
    Write-Host "Found $namespace_name"
}
else {
    write-host "Didn't find $namespace_name"
}
