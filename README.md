# Proyecto

Este proyecto contiene los archivos necesarios en System Verilog para implementar un procesador en Quartus Prime. El procesador es capaz de ejecutar las instrucciones definidas en el Reference Sheet. En este caso se ejecuta el algortimos RSA capaz de desencriptar una imagen en escala de grises.

## Uso

La implementación se puede ejecutar en una herramienta de HDL que pueda ejecutar System Verilog, se recomienda el uso de Quartus Prime 18.1.
Para la compilación se debe utilizar Python 3.7.5 como recomendado y ejecutar la siguiente línea para compilar el código:
```
python3 asm_compiler.py
```

Esto genera un archivo `.mif` que se utiliza para implementar en la memoria del procesador.

Para la generación de los archivos `.mif` de las imágenes se ejecuta el comando:
```
python3 format_memory.py
```

Favor revisar el archivo `format_memory.py`

## Integrantes

Christian Alpizar Monge
Esteban Campos Granados
Jose Antonio Ortega González
Andrey Sibaja Garro
