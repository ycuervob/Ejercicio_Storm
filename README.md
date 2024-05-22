# Ejercicio Apache storm

El dockerfile en este repositorio levanta una instancia de apache storm y una de zookeper. Los comando de construccion y ejecución del contenedor se muestran a continuación.


## Comando construcción
```
docker build -f .\storm.dockerfile -t storm .
```

## Comando ejecución

Este comando corre en modo attach, para correrlo en modo dettach debe cambiar el _-it_ por _-d_.

```
docker run -it --name storm -p 8080:8080 -p 2181:2181 -p 6700:6700 -p 6701:6701 -p 6702:6702 -p 6703:6703 storm
```

Tambien se puede iniciar una terminal dentro del contenedor:

```
docker exec -it  storm /bin/bash
```

