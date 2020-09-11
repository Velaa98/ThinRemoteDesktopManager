#$DropDownArray_Servers = @("server1", "server2", "server3")

## obtener los objetos de 1Password con la etiqueta "TRDM":
$items = .\op.exe list items --tags TRDM| ConvertFrom-Json

## Guardar los servidores en una lista:
$DropDownArray_Servers = $items.overview.title

#$DropDownArray_Users = @("user1", "user2", "user3")

# Form building

Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

$Form = New-Object System.Windows.Forms.Form
$Form.width = 600
$Form.height = 400
$Form.Text = ”Thin Remote Desktop Manager”
$Form.StartPosition = "CenterScreen"



## Etiqueta para identificar la lista desplegable con los servidores
$dropDownLabel_Servers = New-Object System.Windows.Forms.Label
$dropDownLabel_Servers.Location = New-Object System.Drawing.Size(10,10)
$dropDownLabel_Servers.Size = New-Object System.Drawing.Size(100,40)
$dropDownLabel_Servers.Text = "Servidor: "
$Form.Controls.Add($dropDownLabel_Servers)


## Lista desplegable con los servidores:
$dropDown_Servers = New-Object System.Windows.Forms.ComboBox
$dropDown_Servers.Location = New-Object System.Drawing.Size(140,10)
$dropDown_Servers.Size = New-Object System.Drawing.Size(130,30)
ForEach ($Item in $DropDownArray_Servers) { $dropDown_Servers.Items.Add($Item) | Out-Null }
$Form.Controls.Add($dropDown_Servers)




$DropDownTo = New-Object System.Windows.Forms.ComboBox
$DropDownTo.Location = New-Object System.Drawing.Size(140,50)
$DropDownTo.Size = New-Object System.Drawing.Size(130,30)

ForEach ($Item in $DropDownArray_Users) {
$DropDownTo.Items.Add($Item) | Out-Null
}

$Form.Controls.Add($DropDownTo)

$DropDownToLabel = new-object System.Windows.Forms.Label
$DropDownToLabel.Location = new-object System.Drawing.Size(10,50)
$DropDownToLabel.size = new-object System.Drawing.Size(100,40)
$DropDownToLabel.Text = "User: "
$Form.Controls.Add($DropDownToLabel)

$label = New-Object System.Windows.Forms.Label
$label.Location = New-Object System.Drawing.Point(10,90)
$label.Size = New-Object System.Drawing.Size(100,20)
$label.Text = 'password'
$form.Controls.Add($label)

$textBox_Password = New-Object System.Windows.Forms.TextBox
$textBox_Password.PasswordChar = '*'
$textBox_Password.Location = New-Object System.Drawing.Point(140,90)
$textBox_Password.Size = New-Object System.Drawing.Size(130,20)
$form.Controls.Add($textBox_Password)


$OKButton = new-object System.Windows.Forms.Button
$OKButton.Location = new-object System.Drawing.Size(0,130)
$OKButton.Size = new-object System.Drawing.Size(100,20)
$OKButton.Text = "OK"
$OKButton.Add_Click({
$Form.DialogResult = "OK"
$Form.close()
})
$form.Controls.Add($OKButton)


$CancelButton = New-Object System.Windows.Forms.Button
$CancelButton.Location = New-Object System.Drawing.Size(100,130)
$CancelButton.Size = New-Object System.Drawing.Size(100,20)
$CancelButton.Text = "Cancel"
$CancelButton.Add_Click({
$Form.DialogResult = "Cancel"
$Form.close()
})
$Form.Controls.Add($CancelButton)


$Form.Add_Shown({$Form.Activate()})

$result = $Form.ShowDialog()

$server= $dropDown_Servers.Text

$user= $DropDownTo.Text

$password = $textBox_Password.Text

$ip = .\op.exe get item $server --fields IP

## Lista por pantalla las credenciales existentes para la ip destino
cmdkey /list:$ip

## Crea las credenciales
cmdkey /generic:"$ip" /user:"$user" /pass:"$password"

## inicia el escritorio remoto
mstsc /v:$ip

## Lista por pantalla las credenciales existentes para la ip destino
cmdkey /list:$ip
## Elimina las credenciales
cmdkey /delete:$ip 
## Lista por pantalla las credenciales existentes para la ip destino
cmdkey /list:$ip