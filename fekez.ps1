param (
    [int]$K
)

$adatFajl = ".\adatok.txt"

Get-Content $adatFajl | ForEach-Object {
    $sor = $_ -split ",\s*"
    $idopont = $sor[0]
    $v = $sor[1]
    $elol = $sor[2]
    $hatul = $sor[3] 

    if ([int]$elol -lt $K) {
        Write-Output "fekez! ido: $idopont, tav elol: $elol"
    }
}
