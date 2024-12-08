# Szkript neve: fekez.ps1
# Használat: .\fekez.ps1 <K>
# Példa: .\fekez.ps1 100

param (
    [int]$K  # A távolságérték, amely alatt fékezni kell
)

$adatFajl = ".\adatok.txt"

# Fájl feldolgozása
Get-Content $adatFajl | ForEach-Object {
    # Sor feldolgozása
    $sor = $_ -split ",\s*"  # A sor elemeit vesszővel választjuk el
    $idopont = $sor[0]       # Időpont
    $sebesseg = $sor[1]      # Sebesség
    $tavolsagElol = $sor[2]  # Távolság elöl
    $tavolsagHatul = $sor[3] # Távolság hátul

    # Fékezési feltétel
    if ([int]$tavolsagElol -lt $K) {
        Write-Output "Fékezni kell! Időpont: $idopont, Távolság elöl: $tavolsagElol"
    }
}
