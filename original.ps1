$src_dir="C:\Users\a.bushmakin\Desktop"
$texts="AssemblyTitle", 
      "1", "3",
      "AssemblyDescription",
      "AssemblyConfiguration",
      "AssemblyCompany",
      "AssemblyProduct",
      "AssemblyCopyright",
      "AssemblyTrademark",
      "AssemblyCulture",
      "AssemblyInformationalVersion"

$1=Get-ChildItem $src_dir -recurse | where {$_.extension -eq ".txt"}  | Select-Object FullName
$2=$1.FullName        
$file=gc -Path $2 
ForEach ($files in $file){ 
if ($files -eq $texts) {Write-host $file}

#"$file = " + $files.length #|  Out-File -FilePath $2 1.txt
   

}


#{Write-Host $_.FullName}  

#|  gc -Path $1 | ForEach-Object {"{0} : {1}" -f $_,$text}  
