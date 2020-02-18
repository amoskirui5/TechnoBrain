function Install-7zipNpp ($source = ($env:TEMP + "\SW"))
{    
    try{
        If (!(Test-Path -Path $source -PathType Container)) {New-Item -Path $source -ItemType Directory | Out-Null}
            
            $packages = @(

            @{title='Notepad++ 6.7.5';url='http://download.tuxfamily.org/notepadplus/archive/6.7.5/npp.6.7.5.Installer.exe';Arguments=' /Q /S';Destination=$source}
            )
            
            foreach ($package in $packages) {
                    $packageName = $package.title
                    $fileName = Split-Path $package.url -Leaf
                    $destinationPath = $package.Destination + "\" + $fileName
            
            If (!(Test-Path -Path $destinationPath -PathType Leaf)) {
            
                Write-Host "Downloading $packageName"
                $webClient = New-Object System.Net.WebClient
                $webClient.DownloadFile($package.url,$destinationPath)
                }
                }
            
            foreach ($package in $packages) {
                $packageName = $package.title
                $fileName = Split-Path $package.url -Leaf
                $destinationPath = $package.Destination + "\" + $fileName
                $Arguments = $package.Arguments
                Write-Output "Installing $packageName"
            Write-Host "$packageName successfully installed"
            
            
            Invoke-Expression -Command "$destinationPath $Arguments"
            }
        
    }
    
catch

{
#errors output
Write-Host "An error Occurred"

Write-Host $_ 
$logs = "C:\Users\TechAdmin\Desktop\Scripts\logs.txt"
  $Time=Get-Date
    $_ | out-file $logs -append

}
  
  finally
  {
  #logging every time an installation is done

  $logs = "C:\Users\TechAdmin\Desktop\Scripts\logs.txt"
  $Time=Get-Date
    "Successfull install attempt at $Time" | out-file $logs -append
  }    
    }
        Install-7zipNpp