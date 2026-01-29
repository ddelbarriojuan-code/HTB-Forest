# 1. Cargar la configuración de seguridad del dominio
$Dominio = Get-Acl "AD:\DC=htb,DC=local"

# 2. Identificar al usuario y obtener su SID
$Usuario = Get-ADUser usuario_prueba
$SID = $Usuario.SID

# 3. Definir GUIDs y crear reglas de acceso (ACE)
$Guid_PedirCambios = [Guid]"1131f6aa-9c07-11d1-f79f-00c04fc2dcd2"
$Guid_PedirTodo = [Guid]"1131f6ad-9c07-11d1-f79f-00c04fc2dcd2"

$Regla1 = New-Object System.DirectoryServices.ActiveDirectoryAccessRule($SID, "ExtendedRight", "Allow", $Guid_PedirCambios)
$Regla2 = New-Object System.DirectoryServices.ActiveDirectoryAccessRule($SID, "ExtendedRight", "Allow", $Guid_PedirTodo)

# 4. Aplicar cambios
$Dominio.AddAccessRule($Regla1)
$Dominio.AddAccessRule($Regla2)
Set-Acl "AD:\DC=htb,DC=local" $Dominio