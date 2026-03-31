$root = "C:\Users\pc\Documents\Site web @\Punaise Lit 33"
$dirs = @("$root\blog", $root)
Write-Host "=== Pages blog sans image ==="
Get-ChildItem -Path "$root\blog" -Filter "*.html" | ForEach-Object {
    $t = [System.IO.File]::ReadAllText($_.FullName, [System.Text.Encoding]::UTF8)
    $has = [regex]::Matches($t, '<img[^>]+>') | Where-Object { $_.Value -notmatch 'logo-Punaise' }
    if ($has.Count -eq 0) { Write-Host ("  " + $_.Name) }
}
Write-Host ""
Write-Host "=== Pages thematiques sans image ==="
$thematic = @(
    "traitement-thermique-punaise-de-lit.html",
    "traitement-chimique-punaise-de-lit.html",
    "detection-chien-renifleur-punaise-de-lit.html",
    "reconnaitre-piqure-punaise-de-lit.html",
    "oeufs-punaise-de-lit.html"
)
foreach ($name in $thematic) {
    $f = Join-Path $root $name
    if (Test-Path $f) {
        $t = [System.IO.File]::ReadAllText($f, [System.Text.Encoding]::UTF8)
        $has = [regex]::Matches($t, '<img[^>]+>') | Where-Object { $_.Value -notmatch 'logo-Punaise' }
        if ($has.Count -eq 0) { Write-Host ("  " + $name) }
    }
}
Write-Host ""
Write-Host "=== Pages guide sans image ==="
Get-ChildItem -Path "$root\guide" -Filter "*.html" | ForEach-Object {
    $t = [System.IO.File]::ReadAllText($_.FullName, [System.Text.Encoding]::UTF8)
    $has = [regex]::Matches($t, '<img[^>]+>') | Where-Object { $_.Value -notmatch 'logo-Punaise' }
    if ($has.Count -eq 0) { Write-Host ("  " + $_.Name) }
}
