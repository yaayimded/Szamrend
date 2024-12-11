function files($dir) {
    $ret = @()

    function Get-GitIgnorePatterns {
        param($dirPath)
        $gitIgnorePath = Join-Path -Path $dirPath -ChildPath ".gitignore"
        if (Test-Path $gitIgnorePath) {
            return Get-Content $gitIgnorePath | Where-Object { $_ -and -not $_.StartsWith("#") } | ForEach-Object { $_.Trim() }
        }
        return @() # Üres tömb, ha nincs .gitignore
    }

    function Should-SkipItem {
        param($itemName, $patterns)
        return $patterns.Contains($itemName)
    }

    if ($dir -eq $null) {
        # 1. hívás, kezdő könyvtár
        $currentDir = Get-Location
    } else {
        $currentDir = $dir
    }

    $gitIgnorePatterns = Get-GitIgnorePatterns -dirPath $currentDir

    # Fájlok feldolgozása
    $files = Get-ChildItem -Path $currentDir -File
    foreach ($file in $files) {
        if (-not (Should-SkipItem -itemName $file.Name -patterns $gitIgnorePatterns)) {
            $ret += $file
        }
    }

    # Almappák bejárása
    $directories = Get-ChildItem -Path $currentDir -Directory
    foreach ($subdir in $directories) {
        if (-not (Should-SkipItem -itemName $subdir.Name -patterns $gitIgnorePatterns)) {
            try {
                $ret += files $subdir.FullName
            } catch {
                Write-Host "Skipping inaccessible directory: $($subdir.FullName)" -ForegroundColor Yellow
            }
        }
    }

    return $ret
}

files $null
