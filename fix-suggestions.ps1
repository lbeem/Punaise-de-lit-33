$root = "C:\Users\pc\Documents\Site web @\Punaise Lit 33"
$count = 0
Get-ChildItem -Path "$root\blog" -Filter "*.html" | ForEach-Object {
    $t = [System.IO.File]::ReadAllText($_.FullName, [System.Text.Encoding]::UTF8)
    $changed = $false

    # Bouton card: piqure-punaise-de-lit-dos.webp → bouton-punaise-de-lit.webp
    $old1 = 'alt="Bouton punaise de lit" width="1080" height="1350"><h3>Bouton punaise de lit</h3>'
    $new1 = $old1.Replace('piqure-punaise-de-lit-dos.webp', 'bouton-punaise-de-lit.webp')
    # Actually need to match the full img tag
    $oldImg1 = 'src="/assets/piqure-punaise-de-lit-dos.webp" alt="Bouton punaise de lit"'
    $newImg1 = 'src="/assets/bouton-punaise-de-lit.webp" alt="Bouton punaise de lit"'
    if ($t.Contains($oldImg1)) { $t = $t.Replace($oldImg1, $newImg1); $changed = $true }

    if ($changed) {
        [System.IO.File]::WriteAllText($_.FullName, $t, [System.Text.Encoding]::UTF8)
        $count++
        Write-Host ("Updated card: " + $_.Name)
    }
}
Write-Host ("Done. " + $count + " card images updated.")
