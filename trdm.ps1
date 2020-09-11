mstsc /v:<server or ip>

cmdkey /generic:"<server or ip>" /user:"<username>" /pass:"<password>"

## obtener los objetos de 1Password con la etiqueta "TRDM":
$items = .\op.exe list items --tags TRDM | ConvertFrom-Json

## Listar los servidores
foreach ($item in $items) { $item.overview.title }

## Listar los servidores (2).
$items.overview.title

## Leer por pantalla un nombre de servidor:
$servidor = Read-Host "Servidor: "

## Obtener el objeto cuyo nombre coincide con el nombre de servidor indicado:
$item = .\op.exe get item $servidor | ConvertFrom-Json

## Obtener la ip del objeto cuyo nombre coincide con el nombre del servidor indicado:
$ip = .\op.exe get item $servidor --fields IP 

## Obtener la password del objeto cuyo nombre coincide con el nombre del servidor indicado:
$password = .\op.exe get item $servidor --fields password

