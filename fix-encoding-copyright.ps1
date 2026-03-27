$root = "C:\Users\pc\Documents\Site web @\Punaise Lit 33"

# Characters
$oe = [char]0x0152          # Œ (U+0152)
$badA = [char]0x00C5         # Å
$badQ = [char]0x2019         # curly apostrophe '
$bad = $badA + $badQ         # Å' (the corrupted form of Œ)

$files = Get-ChildItem -Path $root -Recurse -Include "*.html" | Where-Object { $_.FullName -notmatch '\node_modules\' }

$count = 0
foreach ($f in $files) {
    $text = [System.IO.File]::ReadAllText($f.FullName, [System.Text.Encoding]::UTF8)
    $changed = $false

    # Fix Œ encoding bug: Å' -> Œ
    if ($text.Contains($bad)) {
        $text = $text.Replace($bad, $oe)
        $changed = $true
    }

    # Fix copyright year: 2025 -> 2026
    if ($text.Contains("2025 Punaise Lit 33")) {
        $text = $text.Replace("2025 Punaise Lit 33", "2026 Punaise Lit 33")
        $changed = $true
    }

    if ($changed) {
        [System.IO.File]::WriteAllText($f.FullName, $text, [System.Text.Encoding]::UTF8)
        $count++
        Write-Host "Fixed: $($f.Name)"
    }
}
Write-Host "Done. $count files updated."
