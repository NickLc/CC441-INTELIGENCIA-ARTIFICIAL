# Lab 03: Reconocimiento facial con matlab

## Pixeleado de caras

Convierte una foto a pixeles, para reducir la cantidad de entradas a una neurona.
En el archivo `PixeleadoCaras`

### Para el recorte del cuello 
Se necesita cambiar el valor de `k` para cada foto, cuando menor sea el k se recorta más e viceversa, generalmente esta entre 1 y 7

Guardar el valor del k para la validacion de cara.

### Entrenamiento de neuronas
El entrenamiento se encuentra en el archivo `NeuronCarasReconoce`, se utiliza 
bias: agrega 1 al final del vector entrada x , entrenamiento `batch` y un eta o radio de aprendiza `0.08`

Se entrenaron con 10 fotos, entonces se necesita 10 neuronas intermedias

### Validacion de caras

Cuando se hace un buen entrenamiento, la red neuronal siempre podra reconocer la foto original. La idea de la validacion de caras es cuando hay alguna modificacion en la imagen y si la red neuronal puede reconocerla, para ello modificar la foto y pixearla con el mismo k utilizado en el pixeleado de la foto original

La validacion de cara toma los valores de la conexion entre las neuronas `pesoscara`  generados por el entrenamiento de la red neuronal.









