#ajustes predeterminados:
$global:verComandoTrasEjecucion = 'yes'

function pause {
    Write-Host '...' -NoNewline -ForegroundColor Magenta
    Read-Host | Out-Null
}

function ayudaTodo {
    # Mostrar ayuda
    Clear-Host
    Write-Host ' _______________________________________________________________________________________________________________________________________'
    Write-Host '| AYUDA-----------Ayuda es un comando para mostrar ayuda, puedes seguirlo con el nombre del comando para mostrar su ayuda específica    |'
    Write-Host '| INFO------------Info es un comando usado para conseguir información.                                                                  |'
    Write-Host '| AJUSTE----------Ajuste es para cambiar los ajustes                                                                                    |'
    Write-Host '| DECIR-----------Decir seguido de cualquier otra cosa va a mostrar ese texto                                                           |'
    Write-Host '|_______________________________________________________________________________________________________________________________________|'
    pause
}

function ayuda {
    param (
        [string]$comando
    )
    Write-Host ''
    Write-Host '---------------------------------------' -ForegroundColor Yellow
    Write-Host ''
    if ($comando.ToLower() -eq 'ayuda') {
        Write-Host 'Ayuda es un comando para conseguir documentación:' -ForegroundColor Cyan
        Write-Host ''
        Write-Host 'Caso 1 | ' -NoNewline -ForegroundColor Gray
        Write-Host 'AYUDA: Muestra un resumen.' -ForegroundColor White
        Write-Host 'Caso 2 | ' -NoNewline -ForegroundColor Gray
        Write-Host 'AYUDA + comando: Muestra la documentación específica de dicho comando.' -ForegroundColor White
    } elseif ($comando.ToLower() -eq 'info') {
        Write-Host 'Info es un comando para conseguir información general sobre la terminal:' -ForegroundColor Cyan
        Write-Host ''
        Write-Host 'INFO ' -NoNewline -ForegroundColor Cyan
        Write-Host 'NOMBRE' -NoNewline -ForegroundColor Green
        Write-Host ' ------ ' -NoNewline -ForegroundColor Gray
        Write-Host 'Muestra todo sobre el nombre que has puesto.' -ForegroundColor White
    } elseif ($comando.ToLower() -eq 'ajuste') {
        Write-Host 'Ajuste cambia los ajustes de la consola:' -ForegroundColor Cyan
        Write-Host ''
        Write-Host 'AJUSTE ' -NoNewline -ForegroundColor Cyan
        Write-Host 'MostrarComandoTrasEjecucion ' -NoNewline -ForegroundColor Green
        Write-Host 'Verdadero' -NoNewline -ForegroundColor Red
        Write-Host ': Hace que cuando ejecutes un comando, aparezca en comando y el resultado, en Falso, solo aparece el resultado.' -ForegroundColor White
    } elseif ($comando.ToLower() -eq 'decir') {
        Write-Host 'Decir muestra texto:' -ForegroundColor Cyan
        Write-Host ''
        Write-Host 'Decir ' -NoNewline -ForegroundColor Cyan
        Write-Host 'Hola, Mundo!' -ForegroundColor Green
        Write-Host ' → Muestra "Hola, Mundo!"' -ForegroundColor DarkGreen
    }else {
        Write-Host "No hay ayuda disponible para el comando '$comando'." -ForegroundColor Red -BackgroundColor Black
    }
    Write-Host ''
    Write-Host '---------------------------------------' -ForegroundColor Yellow
    pause
}

function ajuste {
    param (
        [string]$ajuste
    )
    $valor = $ajuste.Split(' ')
    if ($valor -ne ' '){
        $ajusteName = $valor[0].ToLower()  # El primer valor es el nombre del ajuste
        $ajusteValue = $valor[1].ToLower()  # El segundo valor es el valor del ajuste
    }

    if ($ajusteName -eq 'mostrarcomandotrasejecucion') {
        if ($ajusteValue -eq 'verdadero') {
            Write-Host 'Se ha cambiado la configuración para que no se vuelva a mostrar el comando tras la ejecución.'
            $global:verComandoTrasEjecucion = 'yes'
        } elseif ($ajusteValue -eq 'falso') {
            Write-Host 'Se ha cambiado la configuración para que siempre se vea el comando tras la ejecución.'
            $global:verComandoTrasEjecucion = 'no'
        } else {
            Write-Host 'No se reconoce "'$ajusteValue '" Como Verdadero o Falso, no se ha aplicado ningún cambio.' -ForegroundColor Red -BackgroundColor Black
        }
    } else {
        Write-Host 'No se reconoce "'$ajusteName '" Como configuración, no se ha aplicado ningún cambio.' -ForegroundColor Red -BackgroundColor Black
    }
    pause
}

function decir {
    param (
        [string]$comando
    )
    Write-Host '🗨️ Server |'$comando
    pause
}

function infoNombre {
    # Imprimir valores
    Clear-Host
    Write-Host '1 | [' $nameFirstLetter ']' $name
    Write-Host '2 | [' $lastNameFirstLetter ']' $lastName
    pause
}

# Conseguir nombre
Clear-Host
Write-Host 'Introduce tu nombre: ' -foregroundcolor yellow
Write-Host '> ' -NoNewline -ForegroundColor Green
$name = Read-Host

# El primer carácter en mayúsculas y lo demás en minúscula
$name = $name.Substring(0,1).ToUpper() + $name.Substring(1).ToLower()

# Conseguir apellido
Clear-Host
Write-Host 'Introduce tu apellido: ' -ForegroundColor yellow
Write-Host '> ' -NoNewline -ForegroundColor Green
$lastName = Read-Host

# El primer carácter en mayúsculas y lo demás en minúscula
$lastName = $lastName.Substring(0,1).ToUpper() + $lastName.Substring(1).ToLower()

# Conseguir iniciales y ponerlas en mayúsculas por si acaso
$nameFirstLetter = $name[0].ToString().ToUpper()
$lastNameFirstLetter = $lastName[0].ToString().ToUpper()

while ($true) {
    # Pedir entrada del usuario
    Clear-Host
    Write-Host '> ' -NoNewline -ForegroundColor Gray
    $code = Read-Host 

    if ($global:verComandoTrasEjecucion -eq 'no') {
        Clear-Host
    }

    # Dividir la entrada en palabras
    $code = $code.Trim()  # Elimina espacios extras al inicio y final
    $words = $code.Split(' ')
    $command = $words[0].ToLower()
    $message = $words[1..($words.Length - 1)] -join ' '  # El resto del texto (si lo hay)

    # Procesar comandos
    if ($command -eq 'info' -and $message -eq 'nombre') {
        infoNombre
    }elseif ($command -eq ''){
    } elseif ($command -eq 'salir') {
        break
    }elseif ($command -eq 'ayuda') {
        ayuda $message
    } elseif ($command -eq 'manual') {
        ayudaTodo
    } elseif ($command -eq 'decir') {
        decir $message
    } elseif ($command -eq 'ajuste') {
        ajuste $message
    } else {
        Write-Host 'Comando "'$code '" no reconocido. Usa "manual" para obtener información.' -ForegroundColor Red -BackgroundColor Black
        pause
    }
}
Write-Host ''
Write-Host '__________________________________________' -ForegroundColor Yellow
Write-Host ''
Write-Host '❌ Server | Se ha terminado la ejecución.' -ForegroundColor Red
Write-Host '__________________________________________' -ForegroundColor Yellow
