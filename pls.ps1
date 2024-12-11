function Get-FilesWithGitIgnore {
    param (
        [string]$Dir = (Get-Location).Path  # Alapértelmezett könyvtár az aktuális mappa
    )

    $files = @() # Gyűjti az eredményeket

    # Ellenőrzi, hogy van-e .gitignore fájl az aktuális mappában
    $gitIgnorePath = Join-Path -Path $Dir -ChildPath ".gitignore"
    $ignorePatterns = @()

    if (Test-Path -Path $gitIgnorePath) {
        # Beolvassa a .gitignore fájl tartalmát
        $ignorePatterns = Get-Content -Path $gitIgnorePath | Where-Object { -not [string]::IsNullOrWhiteSpace($_) -and -not $_.StartsWith("#") }
    }

    # Segédfüggvény az ellenőrzéshez
    function IsIgnored ($item, $patterns) {
        foreach ($pattern in $patterns) {
            if ($pattern -match "/$" -and $item.PSIsContainer) {
                if ($item.Name -like $pattern.TrimEnd('/')) {
                    return $true
                }
            } elseif ($item.Name -like $pattern) {
                return $true
            }
        }
        return $false
    }

    # Feldolgozza a fájlokat az aktuális mappában
    Get-ChildItem -Path $Dir -File | ForEach-Object {
        if (-not (IsIgnored $_ $ignorePatterns)) {
            $files += $_.Name
        }
    }

    # Feldolgozza az almappákat
    Get-ChildItem -Path $Dir -Directory | ForEach-Object {
        if (-not (IsIgnored $_ $ignorePatterns)) {
            $files += Get-FilesWithGitIgnore -Dir $_.FullName
        }
    }

    return $files
}
