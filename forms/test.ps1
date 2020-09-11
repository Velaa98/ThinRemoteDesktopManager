$DropDownArray_Servers = @("server1", "server2", "server3")
$DropDownArray_Users = @("user1", "user2", "user3")


# Form building

Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

$Form = New-Object System.Windows.Forms.Form
$Form.width = 600
$Form.height = 400
$Form.Text = ”Thin Remote Desktop Manager”
$Form.StartPosition = "CenterScreen"




$DropDownFrom = New-Object System.Windows.Forms.ComboBox
$DropDownFrom.Location = New-Object System.Drawing.Size(140,10)
$DropDownFrom.Size = New-Object System.Drawing.Size(130,30)

ForEach ($Item in $DropDownArray_Servers) {
$DropDownFrom.Items.Add($Item) | Out-Null
}

$Form.Controls.Add($DropDownFrom)

$DropDownFromLabel = New-Object System.Windows.Forms.Label
$DropDownFromLabel.Location = New-Object System.Drawing.Size(10,10)
$DropDownFromLabel.Size = New-Object System.Drawing.Size(100,40)
$DropDownFromLabel.Text = "Servidor: "
$Form.Controls.Add($DropDownFromLabel)




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

$textBox = New-Object System.Windows.Forms.MaskedTextBox
$textBox.PasswordChar = '*'
$textBox.Location = New-Object System.Drawing.Point(140,90)
$textBox.Size = New-Object System.Drawing.Size(130,20)
$form.Controls.Add($textBox)


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

$server= $Form.Controls[0].Text

$user= $Form.Controls[2].Text

$password = $textBox.Text

#cmdkey /generic:"$server" /user:"$user" /pass:"$password"

#mstsc /v:$server 
