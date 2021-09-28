$Folder = Read-Host "Root Folder Path"
$AllFolders = Get-ChildItem -Path $Folder -Recurse -Directory

$UntouchedPaths = @()

for ($i = 0; $i -lt $AllFolders.Count; $i++) {
    $Folder = $AllFolders[$i]
    if (($Folder.LastWriteTime -gt (Get-Date).AddDays(-30))) {
        $FoundTouched = $false

        foreach ($UntouchedItem in $UntouchedPaths) {
            if ($Folder.FullName -match [regex]::escape($UntouchedItem)) {
                $FoundTouched = $true
            }
        }
        
        if ($FoundTouched -eq $false) {
            $UntouchedPaths = $UntouchedPaths + $Folder.FullName
        }
    }
}

foreach ($item in $UntouchedPaths) {
    Write-Host $item
}