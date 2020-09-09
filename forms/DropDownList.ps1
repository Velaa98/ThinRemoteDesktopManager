$DropDownArray = @("Test1", "Test2", "Test3")

# Form building

Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

$Form = New-Object System.Windows.Forms.Form
$Form.width = 300
$Form.height = 200
$Form.Text = ”User move Destination Location”
$Form.StartPosition = "CenterScreen"

$DropDownFrom = New-Object System.Windows.Forms.ComboBox
$DropDownFrom.Location = New-Object System.Drawing.Size(140,10)
$DropDownFrom.Size = New-Object System.Drawing.Size(130,30)

ForEach ($Item in $DropDownArray) {
$DropDownFrom.Items.Add($Item) | Out-Null
}

$Form.Controls.Add($DropDownFrom)

$DropDownFromLabel = New-Object System.Windows.Forms.Label
$DropDownFromLabel.Location = New-Object System.Drawing.Size(10,10)
$DropDownFromLabel.Size = New-Object System.Drawing.Size(100,40)
$DropDownFromLabel.Text = "Select the user Original location ?"
$Form.Controls.Add($DropDownFromLabel)


$DropDownTo = New-Object System.Windows.Forms.ComboBox
$DropDownTo.Location = New-Object System.Drawing.Size(140,50)
$DropDownTo.Size = New-Object System.Drawing.Size(130,30)

ForEach ($Item in $DropDownArray) {
$DropDownTo.Items.Add($Item) | Out-Null
}

$Form.Controls.Add($DropDownTo)

$DropDownToLabel = new-object System.Windows.Forms.Label
$DropDownToLabel.Location = new-object System.Drawing.Size(10,50)
$DropDownToLabel.size = new-object System.Drawing.Size(100,40)
$DropDownToLabel.Text = "Select the user Destination location ?"
$Form.Controls.Add($DropDownToLabel)


$OKButton = new-object System.Windows.Forms.Button
$OKButton.Location = new-object System.Drawing.Size(100,100)
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